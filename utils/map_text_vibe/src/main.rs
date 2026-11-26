//! Run the linked Game Boy reader with vibe-emu-core. See docs/map_text.md.
use std::{collections::HashMap, env, fs};

use vibe_emu_core::{cartridge::Cartridge, gameboy::GameBoy, hardware::Model};

type Symbols = HashMap<String, (u8, u16)>;

fn symbols(path: &str) -> Symbols {
    let mut result = Symbols::new();
    for line in fs::read_to_string(path).unwrap().lines() {
        let mut fields = line.split_whitespace();
        let (Some(location), Some(name)) = (fields.next(), fields.next()) else {
            continue;
        };
        let Some((bank, addr)) = location.split_once(':') else {
            continue;
        };
        let key = name
            .rsplit_once(".pair_text_")
            .map_or(name, |(_, record)| record);
        result.insert(
            key.to_string(),
            (
                u8::from_str_radix(bank, 16).unwrap(),
                u16::from_str_radix(addr, 16).unwrap(),
            ),
        );
    }
    result
}

const RETURN: u16 = 0xc100;

fn enter(gb: &mut GameBoy, routine: u16, stack_top: u16) {
    gb.cpu.pc = routine;
    gb.cpu.sp = stack_top - 2;
    for (i, byte) in RETURN.to_le_bytes().into_iter().enumerate() {
        gb.mmu.write_byte(gb.cpu.sp + i as u16, byte);
    }
}

#[derive(Default)]
struct Timing {
    characters: u64,
    total: u64,
    maximum: u64,
}

impl Timing {
    fn sample(&mut self, cycles: u64) {
        self.characters += 1;
        self.total += cycles;
        self.maximum = self.maximum.max(cycles);
    }
}

struct Reader {
    gb: GameBoy,
    entry: u16,
    read_char: u16,
    bank_shadow: u16,
    stack_top: u16,
    timing: [Timing; 3],
}

impl Reader {
    // Run a real caller with a destination guard and a sentinel return address.
    // The RAM API returns the terminator in A and leaves DE pointing at its copy.
    fn check(&mut self, bank: u8, start: u16, end: u16, raw: &[u8], implicit: bool) {
        let gb = &mut self.gb;
        gb.mmu.write_byte(0x2000, bank);
        gb.mmu.write_byte(self.bank_shadow, bank);
        let format = match gb.mmu.read_byte(start) {
            0x4c => 2,
            0x5d => 1,
            _ => 0,
        };
        if format == 0 && implicit {
            // A raw inline fragment falls through into a text command. It is
            // consumed by PlaceString, not by the terminated-string RAM API.
            return;
        }
        const DEST: u16 = 0xd000;
        let guard = DEST + u16::try_from(raw.len()).unwrap();
        assert!(guard < 0xe000);
        gb.mmu.write_byte(guard, 0xaa);
        enter(gb, self.entry, self.stack_top);
        [gb.cpu.h, gb.cpu.l] = start.to_be_bytes();
        [gb.cpu.d, gb.cpu.e] = DEST.to_be_bytes();
        let begin = gb.cpu.cycles;
        let mut call = None;
        let mut index = 0;
        while gb.cpu.pc != RETURN {
            if gb.cpu.pc == self.read_char {
                let pc = u16::from_le_bytes([
                    gb.mmu.read_byte(gb.cpu.sp),
                    gb.mmu.read_byte(gb.cpu.sp + 1),
                ]);
                call = Some((pc, gb.cpu.cycles));
            } else if let Some((pc, since)) = call
                && gb.cpu.pc == pc
            {
                assert_eq!(gb.cpu.a, raw[index], "{bank:02x}:{start:04x}, byte {index}");
                assert_eq!(
                    gb.mmu.cart.as_ref().unwrap().current_rom_bank(),
                    u16::from(bank)
                );
                self.timing[format].sample(gb.cpu.cycles - since + 24); // include CALL
                index += 1;
                call = None;
            }
            gb.cpu.step(&mut gb.mmu);
            assert!(!gb.cpu.faulted && gb.cpu.cycles - begin < 10000 * (raw.len() as u64 + 1));
        }
        assert_eq!(
            u16::from_be_bytes([gb.cpu.h, gb.cpu.l]),
            end,
            "resume {bank:02x}:{start:04x}"
        );
        assert_eq!(u16::from_be_bytes([gb.cpu.d, gb.cpu.e]), guard - 1);
        assert_eq!(gb.cpu.sp, self.stack_top);
        assert_eq!(gb.cpu.a, *raw.last().unwrap());
        assert_eq!(gb.mmu.read_byte(guard), 0xaa);
        for (i, &byte) in raw.iter().enumerate() {
            assert_eq!(gb.mmu.read_byte(DEST + i as u16), byte);
        }
    }
}

fn main() {
    let args: Vec<_> = env::args().collect();
    assert_eq!(args.len(), 4, "usage: verify-map-text ROM SYM CORPUS");
    let syms = symbols(&args[2]);
    let mut gb = GameBoy::new(Model::Cgb(Default::default()));
    gb.mmu
        .load_cart(Cartridge::from_bytes(fs::read(&args[1]).unwrap()));
    gb.mmu.write_byte(0xffff, 0); // measure single-speed CPU T-cycles without interrupts
    gb.mmu.write_byte(0xff40, 0);
    gb.mmu.write_byte(0xff70, 1);
    let mut reader = Reader {
        gb,
        entry: syms["DecompressStringToRAM"].1,
        read_char: syms["ReadHuffmanChar"].1,
        bank_shadow: syms["hROMBank"].1,
        stack_top: syms["wStackTop"].1,
        timing: Default::default(),
    };
    let mut boundary = None;
    for line in fs::read_to_string(&args[3]).unwrap().lines() {
        let Some(record) = line.strip_prefix("PAIR ") else {
            continue;
        };
        let mut fields = record.split_whitespace();
        let id = fields.next().unwrap();
        let implicit = fields.next().unwrap() == "1";
        let hex = fields.next().unwrap().as_bytes();
        let raw: Vec<_> = hex
            .chunks_exact(2)
            .map(|byte| u8::from_str_radix(std::str::from_utf8(byte).unwrap(), 16).unwrap())
            .collect();
        let (bank, start) = syms[&format!("start{id}")];
        let (_, end) = syms[&format!("end{id}")];
        reader.check(bank, start, end, &raw, implicit);
        let (terminator, glyphs) = raw.split_last().unwrap();
        if boundary.is_none()
            && reader.gb.mmu.read_byte(start) == 0x4c
            && matches!(terminator, 0x52 | 0x53)
            && glyphs.len() <= 18
            && glyphs.iter().all(|&b| b >= 0x7f)
        {
            let rom = &reader.gb.mmu.cart.as_ref().unwrap().rom;
            let offset = (usize::from(bank) - 1) * 0x4000 + usize::from(start);
            boundary = Some((rom[offset..offset + usize::from(end - start)].to_vec(), raw));
        }
    }
    for (name, t) in ["singular", "pair"].iter().zip(&reader.timing[1..]) {
        if t.characters != 0 {
            println!(
                "{name}: {} bytes, mean {} and max {} T-cycles",
                t.characters,
                t.total / t.characters,
                t.maximum
            );
        }
    }
    // Move a complete packed record in the emulator's private ROM copy only.
    // The reader must stop at $8000 without fetching a byte from VRAM.
    let (packed, raw) = boundary.expect("no pair records tested");
    let rom = &mut reader.gb.mmu.cart.as_mut().unwrap().rom;
    let mut bank = u8::try_from(rom.len() / 0x4000 - 1).unwrap();
    if bank == syms["ReadMapPairToken"].0 {
        bank -= 1;
    }
    let start = 0x8000 - u16::try_from(packed.len()).unwrap();
    let end = (usize::from(bank) + 1) * 0x4000;
    rom[end - packed.len()..end].copy_from_slice(&packed);
    reader.check(bank, start, 0x8000, &raw, false);
    // Exercise the display path through its normal far-string entry point.
    // A one-line record lets us compare glyphs directly without input delays.
    let gb = &mut reader.gb;
    let dest = syms["wTilemap"].1 + 1;
    let glyphs = &raw[..raw.len() - 1];
    for i in 0..glyphs.len() as u16 + 2 {
        gb.mmu.write_byte(dest - 1 + i, 0xaa);
    }
    gb.mmu.write_byte(syms["wTextboxFlags"].1, 0);
    gb.mmu.write_byte(0x2000, 1);
    gb.mmu.write_byte(reader.bank_shadow, 1);
    gb.cpu.a = bank;
    [gb.cpu.h, gb.cpu.l] = dest.to_be_bytes();
    [gb.cpu.d, gb.cpu.e] = start.to_be_bytes();
    enter(gb, syms["FarString"].1, reader.stack_top);
    let begin = gb.cpu.cycles;
    while gb.cpu.pc != RETURN {
        gb.cpu.step(&mut gb.mmu);
        assert!(
            !gb.cpu.faulted && gb.cpu.cycles - begin < 200000,
            "FarString stalled at ${:04x}",
            gb.cpu.pc
        );
    }
    assert_eq!(gb.mmu.cart.as_ref().unwrap().current_rom_bank(), 1);
    assert_eq!(u16::from_be_bytes([gb.cpu.d, gb.cpu.e]), 0x7fff);
    assert_eq!(gb.mmu.read_byte(dest - 1), 0xaa);
    assert_eq!(gb.mmu.read_byte(dest + glyphs.len() as u16), 0xaa);
    for (i, &byte) in glyphs.iter().enumerate() {
        assert_eq!(gb.mmu.read_byte(dest + i as u16), byte);
    }
    println!("Bank-end RAM and far-string display checks passed");
}
