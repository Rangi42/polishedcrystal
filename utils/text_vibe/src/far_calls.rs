//! Compare the cursor, output, resume address and bank of nested text calls.
use super::{GameBoy, RETURN, Symbols, enter};
use std::collections::BTreeMap;

const END: u8 = 0x53; // @
const DAY: u8 = 0x07;
const FAR: u8 = 0x08;
const BREAKS: [u8; 5] = [0x52, END, 0x54, 0x58, 0x59]; // DONE, @, PROMPT, CONT, PARA

#[derive(Default)]
pub struct Samples(BTreeMap<u8, (Vec<u8>, Vec<u8>)>);

impl Samples {
    // Select actual linked encodings with a short, directly printable first line.
    pub fn collect(&mut self, raw: &[u8], packed: &[u8]) {
        let Some(pos) = raw.iter().position(|b| BREAKS.contains(b)) else {
            return;
        };
        if (1..=14).contains(&pos) && raw.len() <= 48 && raw[..pos].iter().all(|b| *b >= 0x7f) {
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
        gb.mmu.write_byte(syms["wTextboxFlags"].1, 1 << 5); // nonblocking
        for stop in BREAKS {
            let (raw, packed) = &self.0[&stop];
            let pos = raw.iter().position(|b| *b == stop).unwrap();
            let pause = matches!(stop, 0x58 | 0x59);
            for text in [raw, packed] {
                let mut leaf_script = text.clone();
                leaf_script.extend([DAY, END]); // only @ falls through to DAY
                write_script(gb, leaf, &leaf_script);
                for tail_outer in [false, true] {
                    for tail_inner in [false, true] {
                        write_script(gb, inner, &call(leaf, tail_inner));
                        write_script(gb, outer, &call(inner, tail_outer));
                        let mut expected = raw[..pos].to_vec();
                        if !pause {
                            let days = usize::from(stop == END)
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
                        assert_eq!(u16::from_be_bytes([gb.cpu.h, gb.cpu.l]), resume);
                        assert_eq!(gb.cpu.sp, syms["wStackTop"].1);
                        assert_eq!(
                            gb.mmu.cart.as_ref().unwrap().current_rom_bank(),
                            u16::from(outer.0)
                        );
                        assert_eq!(gb.mmu.read_byte(syms["hROMBank"].1), outer.0);
                        assert_eq!(
                            u16::from_be_bytes([gb.cpu.b, gb.cpu.c]),
                            dest + expected.len() as u16
                        );
                        expected.push(0xaa); // guard immediately after the last glyph
                        for (i, byte) in expected.iter().enumerate() {
                            assert_eq!(gb.mmu.read_byte(dest + i as u16), *byte);
                        }
                    }
                }
            }
        }
        println!("Nested text_far and text_farend checks passed for raw and paired text");
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
