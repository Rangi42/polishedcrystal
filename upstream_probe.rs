//! Unmodified pokecrystal Gen 2 link regression comparison for #1179.
//! Transport is an ideal byte copy; serial timing, mail and a completed trade
//! are deliberately outside this test. Screenshots are the emulator PPU output
//! after the ROM draws its trade screen from the decoded party.
//! Usage: upstream_probe ROM.gbc

use std::{collections::HashMap, env, fs};
use vibe_emu_core::{cartridge::Cartridge, gameboy::GameBoy, hardware::Model};
struct Probe {
    g: GameBoy,
    s: HashMap<String, (u16, u16)>,
}
impl Probe {
    fn addr(&self, n: &str) -> u16 {
        self.s[n].1
    }
    fn put(&mut self, a: u16, d: &[u8]) {
        for (i, v) in d.iter().enumerate() {
            self.g.mmu.write_byte(a + i as u16, *v)
        }
    }
    fn get(&mut self, a: u16, n: usize) -> Vec<u8> {
        (0..n).map(|i| self.g.mmu.read_byte(a + i as u16)).collect()
    }
    fn bank(&mut self, n: &str) {
        let b = self.s[n].0;
        self.g.mmu.write_byte(0x2000, b as u8);
        if let Some(&(_, a)) = self.s.get("hROMBank") {
            self.g.mmu.write_byte(a, b as u8)
        }
    }
    fn run(&mut self, end: u16) {
        for _ in 0..5000000 {
            if self.g.cpu.pc == end {
                return;
            }
            self.g.cpu.step(&mut self.g.mmu)
        }
        panic!("timeout {:04x} target {end:04x}", self.g.cpu.pc)
    }
    fn call(&mut self, n: &str) {
        self.bank(n);
        self.g.cpu.sp = 0xcff0;
        self.put(0xcff0, &[0, 0xc1]);
        self.g.cpu.pc = self.addr(n);
        self.run(0xc100)
    }
    fn new(rom: &str) -> Self {
        let mut s = HashMap::new();
        for l in fs::read_to_string(rom.replace(".gbc", ".sym"))
            .unwrap()
            .lines()
        {
            let t: Vec<_> = l.split_whitespace().collect();
            if t.len() == 2 && t[0].contains(':') {
                let p: Vec<_> = t[0].split(':').collect();
                s.insert(
                    t[1].to_string(),
                    (
                        u16::from_str_radix(p[0], 16).unwrap(),
                        u16::from_str_radix(p[1], 16).unwrap(),
                    ),
                );
            }
        }
        let mut g = GameBoy::new(Model::Cgb(Default::default()));
        g.mmu
            .load_cart(Cartridge::from_bytes(fs::read(rom).unwrap()));
        g.mmu.write_byte(0xff40, 0);
        g.mmu.write_byte(0xffff, 0);
        g.cpu.ime = false;
        Self { g, s }
    }
}
fn roundtrip(rom: &str, position: Option<usize>, id: [u8; 2], remove_species_list: bool) -> bool {
    let mut p = Probe::new(rom);
    p.put(p.addr("wLinkMode"), &[3]);
    p.put(
        p.addr("wPlayerName"),
        &[
            0x80, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50,
        ],
    );
    p.put(p.addr("wPartyCount"), &[6, 1, 2, 3, 4, 5, 6, 0xff]);
    let stride = (p.addr("wPartyMon2Species") - p.addr("wPartyMon1Species")) as usize;
    let mut party: Vec<u8> = (0..stride * 6).map(|i| (i % 240) as u8).collect();
    for i in 0..6 {
        party[i * stride] = (i + 1) as u8;
    }
    p.put(p.addr("wPlayerID"), &id);
    p.put(p.addr("wPartyMon1Species"), &party);
    p.put(p.addr("wPartyMonOTs"), &[0x50; 132]);
    if let Some(i) = position {
        let addr = if i < 2 {
            p.addr("wPlayerID") + i as u16
        } else {
            p.addr("wPartyMon1Species") + (i - 2) as u16
        };
        p.put(addr, &[0xfe]);
    }
    p.call("Link_PrepPartyData_Gen2");
    let start = p.addr("wLinkSendParty");
    let len = (p.addr("wLinkPlayerPartyDataEnd") - p.addr("wLinkPlayerPartyData")) as usize;
    let expected = p.get(start + 6, len);
    if remove_species_list {
        // Model the 2021 payload shortening, without changing the stock ROM.
        // Moving player ID and following bytes seven bytes earlier is exactly
        // what changing CopyBytes(count+species+terminator) to count-only does.
        let id_start = p.addr("wLinkSendPartyPlayerID");
        let shortened = p.get(id_start, len - 19);
        p.put(id_start - 7, &shortened);
    }
    p.call("FixDataForLinkTransfer");
    let wire = p.get(start + 6, len + 16);
    let patches = p.get(p.addr("wPlayerPatchLists") + 10, 190);
    if remove_species_list {
        let missed = wire[12..14] == id;
        println!(
            "Removing the 7 species-list bytes leaves player ID unescaped: {missed}, bytes {:02x?}",
            &wire[12..14]
        );
        return missed && id.contains(&0xfe);
    }
    let source = p.addr("wLinkReceivedPartyData");
    p.put(source, &wire);
    p.g.cpu.h = (source >> 8) as u8;
    p.g.cpu.l = source as u8;
    let dest = p.addr("wLinkPlayerPartyData");
    p.g.cpu.d = (dest >> 8) as u8;
    p.g.cpu.e = dest as u8;
    p.g.cpu.b = (len >> 8) as u8;
    p.g.cpu.c = len as u8;
    p.call("Link_CopyOTData");
    let patch_source = p.addr("wOTPatchLists");
    p.put(patch_source, &patches);
    let base = p.addr("wLinkPlayerPatchedData");
    p.g.cpu.h = (base >> 8) as u8;
    p.g.cpu.l = base as u8;
    p.g.cpu.d = (patch_source >> 8) as u8;
    p.g.cpu.e = patch_source as u8;
    p.g.cpu.c = 2;
    p.bank("Gen2ToGen2LinkComms.party_patch_loop");
    p.g.cpu.pc = p.addr("Gen2ToGen2LinkComms.party_patch_loop");
    p.run(p.addr("Gen2ToGen2LinkComms.skip_mail"));
    let actual = p.get(dest, len);
    expected == actual
}
fn main() {
    let rom = env::args().nth(1).expect("ROM.gbc required");
    for id in [[0x75, 0xfe], [0xfe, 0x75], [0xfe, 0xfe]] {
        assert!(roundtrip(&rom, None, id, false));
        println!(
            "PASS unmodified pokecrystal: trainer ID {id:02x?}, entire decoded payload matches"
        );
    }
    for i in 0..290 {
        assert!(
            roundtrip(&rom, Some(i), [0x75, 0xfe], false),
            "position {i}"
        );
    }
    println!(
        "PASS unmodified pokecrystal: all 290 independent $FE injections, entire decoded payload matches"
    );
    assert!(roundtrip(&rom, None, [0x75, 0xfe], true));
}
