#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from glob import iglob

import sys
import re

sym_rx = re.compile(r'^([0-9A-F]{2}):([0-9A-F]{4}) ([A-Z0-9_\.#@]+)', re.IGNORECASE)
def_rx = re.compile(r'^\s*([A-Z_][A-Z0-9_\.#@]*):(?!\s*macro)', re.IGNORECASE)
ref_rx = re.compile(r'^\s+(call|jmp|jp|jr|dw|dwb)\s+(?:(z|nz|c|nc)\s*,\s*)?([A-Z0-9_\.]+)', re.IGNORECASE)
far_rx = re.compile(r'^\s+(?:farcall|farjp|callfar|callba|callab)\s+([A-Z0-9_\.]+)', re.IGNORECASE)
ram_rx = re.compile(r'^[vswh][A-Z]')

suppress = 'far-ok'

exclude = {
'data/text/unused_sweet_honey.asm',
'engine/games/memory_game.asm',
'gfx/pokemon/frame_pointers.asm',
'ram/wram0.asm',
'ram/wramx.asm',
}

if len(sys.argv) != 2:
	print(f'Usage: {sys.argv[0]} polishedcrystal.sym', file=sys.stderr)
	exit(1)

sym_banks = {}
rst_addrs = (0x00, 0x08, 0x10, 0x18, 0x20, 0x28, 0x30, 0x38)
rst_funcs = {}

with open(sys.argv[1], 'r') as f:
	for line in f:
		if (m := re.match(sym_rx, line)):
			bank, addr, label = m.groups()
			bank, addr = int(bank, 16), int(addr, 16)
			sym_banks[label] = bank
			if addr in rst_addrs:
				rst_funcs[label] = addr

def get_label_bank(m, n=1):
	label = m.group(n)
	if label.startswith('.') and cur_label is not None:
		label = cur_label + label
	bank = sym_banks.get(label, None)
	return (label, bank)

for filename in iglob('**/*.asm', recursive=True):
	if filename in exclude:
		continue
	cur_label = None
	cur_bank = None
	suppressing = False
	with open(filename, 'r') as f:
		for i, line in enumerate(f, 1):
			if (m := re.match(def_rx, line)):
				label, bank = get_label_bank(m)
				cur_label = label
				suppressing = False
				if bank is not None:
					cur_bank = bank
				else:
					print(f"{filename}:{i}: cannot get bank of '{label}'", file=sys.stderr)
				if ';' in line:
					comment = line.split(';', 1)[1].strip()
					if suppress in comment:
						suppressing = True
			elif (m := re.match(ref_rx, line)):
				label, bank = get_label_bank(m, 3)
				if bank is not None and bank != cur_bank and bank != 0 and not re.match(ram_rx, label):
					code, *comment = line.split(';', 1)
					code = code.strip()
					comment = comment[0].strip() if comment else ''
					if suppress not in comment and not suppressing:
						print(f"{filename}:{i}: '{code}' in bank {cur_bank:02X} references '{label}' in bank {bank:02X}")
				if label in rst_funcs and m.group(1) == 'call' and not m.group(2):
					code, *comment = line.split(';', 1)
					code = code.strip()
					comment = comment[0].strip() if comment else ''
					if suppress not in comment and not suppressing:
						print(f"{filename}:{i}: '{code}' can use 'rst ${rst_funcs[label]:02x}'")
			elif (m := re.match(far_rx, line)):
				label, bank = get_label_bank(m)
				if bank is not None and bank == cur_bank:
					code = line.split(';', 1)[0].strip()
					print(f"{filename}:{i}: '{code}' in bank {cur_bank:02X} references '{label}' already in bank {bank:02X}")
