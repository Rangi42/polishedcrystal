//! Compare the cursor, output, resume address and bank of nested text calls.
use super::{GameBoy, RETURN, Symbols, enter};
use std::collections::BTreeMap;

const END: u8 = 0x53; // @
const RAM: u8 = 0x01;
const DAY: u8 = 0x07;
const FAR: u8 = 0x08;
const ENEMY: u8 = 0x5c;
const BREAKS: [u8; 6] = [0x52, END, 0x54, 0x58, 0x59, ENEMY]; // DONE, @, PROMPT, CONT, PARA, wrapped trainer

#[derive(Default)]
pub struct Samples(BTreeMap<u8, (Vec<u8>, Vec<u8>)>);

impl Samples {
    // Select actual linked encodings with a short, directly printable first line.
    pub fn collect(&mut self, raw: &[u8], packed: &[u8]) {
        let Some(pos) = raw.iter().position(|b| BREAKS.contains(b)) else {
            return;
        };
        if pos <= 14
            && (pos > 0 || raw[pos] == ENEMY)
            && raw.len() <= 40 // fits in wRadioText
            && raw[..pos].iter().all(|b| *b >= 0x7f)
        {
            self.0
                .entry(raw[pos])
                .or_insert_with(|| (raw.to_vec(), packed.to_vec()));
        }
    }

    pub fn check(&self, gb: &mut GameBoy, syms: &Symbols) {
        // Use padding in two different banks of the emulator's private ROM.
        let rom = &mut gb.mmu.cart.as_mut().unwrap().rom;
        let slots: Vec<_> = rom
            .chunks_exact(0x4000)
            .enumerate()
            .skip(1)
            .filter_map(|(bank, data)| {
                let offset = data
                    .windows(128)
                    .rposition(|w| w.iter().all(|b| *b == 0xff))?;
                Some((bank as u8, 0x4000 + offset as u16))
            })
            .take(2)
            .collect();
        let [outer, inner] = slots[..] else {
            panic!("missing scratch ROM slots")
        };
        let leaf = (outer.0, outer.1 + 16);
        let dest = syms["wTilemap"].1 + 1;
        gb.mmu.write_byte(syms["wCurDay"].1, 0); // Sunday
        gb.mmu.write_byte(syms["wLinkMode"].1, 0); // non-link trainers have both a class and a name
        gb.mmu
            .write_byte(syms["wTextboxFlags"].1, (1 << 5) | (1 << 4)); // nonblocking, wrap trainer names
        gb.mmu.write_byte(syms["wInBattleTowerBattle"].1, 1); // trainer name comes from wOTPlayerName
        let class = [0x80, 0xa2, 0xa4]; // Ace
        for (name, bytes) in [
            ("wOTClassName", &class[..]),
            ("wOTPlayerName", &[0x91, 0xa4, 0xa3][..]),
        ] {
            for (i, byte) in bytes.iter().copied().chain([END]).enumerate() {
                gb.mmu.write_byte(syms[name].1 + i as u16, byte);
            }
        }
        for stop in BREAKS {
            let (raw, packed) = &self.0[&stop];
            let pos = raw.iter().position(|b| *b == stop).unwrap();
            let pause = matches!(stop, 0x58 | 0x59 | ENEMY);
            for (text, from_ram) in [(raw, false), (packed, false), (raw, true), (packed, true)] {
                let mut leaf_script = if from_ram {
                    let addr = syms["wRadioText"].1;
                    for (i, byte) in text.iter().enumerate() {
                        gb.mmu.write_byte(addr + i as u16, *byte);
                    }
                    let [lo, hi] = addr.to_le_bytes();
                    vec![RAM, lo, hi]
                } else {
                    text.clone()
                };
                leaf_script.extend([DAY, END]);
                write_script(gb, leaf, &leaf_script);
                for tail_outer in [false, true] {
                    for tail_inner in [false, true] {
                        write_script(gb, inner, &call(leaf, tail_inner));
                        write_script(gb, outer, &call(inner, tail_outer));
                        let mut expected = raw[..pos].to_vec();
                        if stop == ENEMY {
                            expected.extend(class); // the synthetic <CONT> comes after the class
                        }
                        if !pause {
                            let days = usize::from(from_ram || stop == END)
                                + usize::from(!tail_inner)
                                + usize::from(!tail_outer);
                            for _ in 0..days {
                                expected.extend([0x92, 0xb4, 0xad, 0xa3, 0xa0, 0xb8]); // Sunday
                            }
                        }
                        for i in 0..=expected.len() {
                            gb.mmu.write_byte(dest + i as u16, 0xaa);
                        }
                        gb.mmu.write_byte(0x2000, outer.0);
                        gb.mmu.write_byte(syms["hROMBank"].1, outer.0);
                        [gb.cpu.h, gb.cpu.l] = outer.1.to_be_bytes();
                        [gb.cpu.b, gb.cpu.c] = dest.to_be_bytes();
                        enter(gb, syms["DoTextUntilTerminator"].1, syms["wStackTop"].1);
                        let start = gb.cpu.cycles;
                        while gb.cpu.pc != RETURN {
                            gb.cpu.step(&mut gb.mmu);
                            assert!(!gb.cpu.faulted && gb.cpu.cycles - start < 500_000);
                        }
                        let resume = outer.1 + if pause || tail_outer { 4 } else { 6 };
                        assert_eq!(
                            u16::from_be_bytes([gb.cpu.h, gb.cpu.l]),
                            resume,
                            "stop={stop:#04x}, from_ram={from_ram}, packed={}, tail_outer={tail_outer}, tail_inner={tail_inner}",
                            text == packed
                        );
                        assert_eq!(gb.cpu.sp, syms["wStackTop"].1);
                        assert_eq!(
                            gb.mmu.cart.as_ref().unwrap().current_rom_bank(),
                            u16::from(outer.0)
                        );
                        assert_eq!(gb.mmu.read_byte(syms["hROMBank"].1), outer.0);
                        assert_eq!(
                            u16::from_be_bytes([gb.cpu.b, gb.cpu.c]),
                            dest + expected.len() as u16,
                            "stop={stop:#04x}, from_ram={from_ram}, packed={}",
                            text == packed
                        );
                        expected.push(0xaa); // guard immediately after the last glyph
                        for (i, byte) in expected.iter().enumerate() {
                            assert_eq!(gb.mmu.read_byte(dest + i as u16), *byte);
                        }
                    }
                }
            }
        }
        println!("Nested text_far, text_farend and text_ram checks passed for raw and paired text");
    }
}

fn call((bank, addr): (u8, u16), tail: bool) -> [u8; 6] {
    let [hi, lo] = addr.to_be_bytes();
    [FAR, hi | if tail { 0x80 } else { 0 }, lo, bank, DAY, END]
}

fn write_script(gb: &mut GameBoy, (bank, addr): (u8, u16), bytes: &[u8]) {
    let start = (usize::from(bank) - 1) * 0x4000 + usize::from(addr);
    gb.mmu.cart.as_mut().unwrap().rom[start..start + bytes.len()].copy_from_slice(bytes);
}
