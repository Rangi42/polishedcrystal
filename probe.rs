//! Issue #1179 routine-level regression probe using the real assembled ROM.
//! Transport is an ideal byte copy; serial timing, mail and a completed trade
//! are deliberately outside this test. Screenshots are the emulator PPU output
//! after the ROM draws its trade screen from the decoded party.
//! Usage: probe ROM.gbc SAVE.dmp OUTPUT_PREFIX [screen|check|safe-id|versions|0..289]

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
    fn load(&mut self, save: &str) {
        let d = fs::read(save).unwrap();
        assert!(d.len() >= 32768);
        // These issue attachments use the v9 save layout, shared by these
        // player/party sections in the tested master build. No save conversion.
        let checksum = |start: usize, end: usize, stored: usize| {
            let sum = d[start..end]
                .iter()
                .fold(0u16, |s, &v| s.wrapping_add(v as u16));
            sum == u16::from_le_bytes([d[stored], d[stored + 1]])
        };
        let backup = !checksum(0x2008, 0x2b83, 0x2d0d);
        assert!(
            !backup || checksum(0x1208, 0x1d83, 0x1f0d),
            "neither save checksum is valid"
        );
        for (w, s) in [
            ("wPlayerData", "sPlayerData"),
            ("wPokemonData", "sPokemonData"),
        ] {
            let (b, a) = self.s[s];
            let mut off = b as usize * 8192 + (a as usize - 0xa000);
            if backup {
                off -= 0xe00;
            }
            let len = (self.addr(&(w.to_owned() + "End")) - self.addr(w)) as usize;
            self.put(self.addr(w), &d[off..off + len]);
        }
        self.put(self.addr("wLinkMode"), &[3]);
    }
}
fn main() {
    let a: Vec<_> = env::args().collect();
    let mut p = Probe::new(&a[1]);
    if a.get(4).map(String::as_str) == Some("versions") {
        for mode in [2, 3] {
            for version in [3, 4, 5] {
                p.put(p.addr("wLinkMode"), &[mode]);
                p.put(p.addr("wLinkOtherPlayerVersion"), &[0, version]);
                p.put(p.addr("wLinkOtherPlayerMinTradeVersion"), &[0, 3]);
                p.call("CheckCorrectLinkVersion");
                assert_eq!(p.g.cpu.a == 1, version == 5);
                println!("mode {mode}, peer version {version}: result {}", p.g.cpu.a);
            }
        }
        return;
    }
    p.load(&a[2]);
    if a.get(4).map(String::as_str) == Some("safe-id") {
        p.put(p.addr("wPlayerID"), &[0x75, 0xfd]);
    }
    if a.len() > 4 && a[4] != "screen" && a[4] != "check" && a[4] != "safe-id" {
        let i: usize = a[4].parse().unwrap();
        let target = if i < 2 {
            p.addr("wPlayerID") + i as u16
        } else {
            p.addr("wPartyMon1Species") + (i - 2) as u16
        };
        p.put(target, &[0xfe]);
    }
    let count = p.get(p.addr("wPartyCount"), 1)[0];
    assert!((1..=6).contains(&count));
    let size = (p.addr("wPartyMon2Species") - p.addr("wPartyMon1Species")) as usize;
    let expected = p.get(p.addr("wPartyMon1Species"), size * count as usize);
    let id = p.get(p.addr("wPlayerID"), 2);
    let ots = p.get(p.addr("wPartyMonOTs"), 132);
    p.call("ClearLinkData");
    p.call("Link_PrepPartyData_Gen2");
    p.call("FixDataForLinkTransfer");
    let raw = p.get(p.addr("wLinkData") + 6, 450);
    let patches = p.get(p.addr("wLinkPlayerFixedPartyMon1ID"), 190);
    println!(
        "ID {id:02x?}, first wire bytes {:02x?}, patches {:02x?}",
        &raw[..25],
        &patches[..20]
    );
    p.put(0xd000, &raw);
    p.g.cpu.h = 0xd0;
    p.g.cpu.l = 0;
    p.g.cpu.d = (p.addr("wLinkData") >> 8) as u8;
    p.g.cpu.e = p.addr("wLinkData") as u8;
    p.g.cpu.b = 1;
    p.g.cpu.c = 178;
    p.call("Link_CopyOTData");
    p.put(p.addr("wPlayerTrademon"), &patches);
    let base = p.addr("wLinkPatchList1");
    p.g.cpu.h = (base >> 8) as u8;
    p.g.cpu.l = base as u8;
    let src = p.addr("wPlayerTrademon");
    p.g.cpu.d = (src >> 8) as u8;
    p.g.cpu.e = src as u8;
    p.g.cpu.c = 2;
    p.bank("Gen2ToGen2LinkComms.loop1");
    p.g.cpu.pc = p.addr("Gen2ToGen2LinkComms.loop1");
    p.run(p.addr("Gen2ToGen2LinkComms.skip_mail"));
    let start = p.addr("Gen2ToGen2LinkComms.skip_mail");
    let end = (start..start + 60)
        .find(|&x| p.get(x, 2) == [0x1e, 0])
        .unwrap();
    p.run(end);
    let actual = p.get(p.addr("wOTPartyMons"), expected.len());
    println!(
        "expected species {:?}; received {:?}; differing bytes {}",
        expected.iter().step_by(size).collect::<Vec<_>>(),
        actual.iter().step_by(size).collect::<Vec<_>>(),
        expected.iter().zip(&actual).filter(|(x, y)| x != y).count()
    );
    fs::write(format!("{}.received", a[3]), &actual).unwrap();
    fs::write(format!("{}.expected", a[3]), &expected).unwrap();
    let received_id = p.get(p.addr("wOTPlayerID"), 2);
    let received_ots = p.get(p.addr("wOTPartyMonOTs"), 132);
    let ok = id == received_id && ots == received_ots && expected == actual;
    println!("Trainer ID + active party + OT names/nicknames exact: {ok}");
    if a.len() > 4 && a[4] != "screen" {
        assert!(ok, "round trip corrupted payload");
        return;
    }
    p.put(p.addr("wTextboxFlags"), &[0]);
    p.put(p.addr("wOptions2"), &[0]);
    for n in [
        "LoadStandardFont",
        "LoadFontsBattleExtra",
        "LoadTradeScreenGFX",
        "InitTradeSpeciesList",
    ] {
        println!("render {n}");
        p.call(n);
    }
    p.call("LoadLinkTradePalette");
    p.g.mmu.write_byte(0xff70, 5);
    let pals = p.get(p.addr("wBGPals1"), 64);
    p.g.mmu.write_byte(0xff70, 1);
    p.g.mmu.write_byte(0xff68, 0x80);
    for v in pals {
        p.g.mmu.write_byte(0xff69, v);
    }
    let attrs = p.get(p.addr("wAttrmap"), 360);
    p.g.mmu.write_byte(0xff4f, 1);
    for y in 0..18 {
        p.put(
            0x9800 + y * 32,
            &attrs[y as usize * 20..y as usize * 20 + 20],
        );
    }
    let tilemap = p.get(p.addr("wTilemap"), 360);
    p.g.mmu.write_byte(0xff4f, 0);
    for y in 0..18 {
        p.put(
            0x9800 + y * 32,
            &tilemap[y as usize * 20..y as usize * 20 + 20],
        );
    }
    p.g.mmu.write_byte(0xff47, 0xe4);
    p.g.mmu.write_byte(0xff42, 0);
    p.g.mmu.write_byte(0xff43, 0);
    p.g.mmu.write_byte(0xff40, 0x81);
    p.put(0xc100, &[0x18, 0xfe]);
    p.g.cpu.pc = 0xc100;
    for _ in 0..30000 {
        p.g.cpu.step(&mut p.g.mmu);
    }
    let mut ppm = b"P6\n160 144\n255\n".to_vec();
    for v in p.g.mmu.ppu.framebuffer() {
        ppm.extend_from_slice(&[(v >> 16) as u8, (v >> 8) as u8, *v as u8]);
    }
    fs::write(format!("{}.ppm", a[3]), ppm).unwrap();
}
