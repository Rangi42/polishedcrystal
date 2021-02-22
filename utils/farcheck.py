#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from glob import iglob

import sys
import re

sym_rx = re.compile(r'^([0-9A-F]{2}):([0-9A-F]{4}) ([A-Z0-9_\.#@]+)', re.IGNORECASE)
def_rx = re.compile(r'^\s*([A-Z_][A-Z0-9_\.#@]*):(?!\s*macro)', re.IGNORECASE)
ref_rx = re.compile(r'^\s+(?:call|jp|jr|dw|dwb)\s+(?:(?:z|nz|c|nc)\s*,\s*)?([A-Z0-9_\.]+)', re.IGNORECASE)
far_rx = re.compile(r'^\s+(?:farcall|farjp)\s+([A-Z0-9_\.]+)', re.IGNORECASE)
ram_rx = re.compile(r'^[vwh][A-Z]')

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

with open(sys.argv[1], 'r') as f:
	for line in f:
		if (m := re.match(sym_rx, line)):
			bank, addr, label = m.groups()
			sym_banks[label] = int(bank, 16)

for filename in iglob('**/*.asm', recursive=True):
	if filename in exclude:
		continue
	printed = False
	cur_label = None
	cur_bank = None
	# Read each file line by line
	with open(filename, 'r') as f:
		for i, line in enumerate(f, 1):
			if (m := re.match(def_rx, line)):
				label = m.group(1)
				cur_label = label
				bank = sym_banks.get(label, None)
				if bank is not None:
					cur_bank = bank
				else:
					print(f"{filename}:{i}: cannot get bank of '{label}'", file=sys.stderr)
					#sym_banks[label] = cur_bank
			elif (m := re.match(ref_rx, line)):
				label = m.group(1)
				if label.startswith('.') and cur_label is not None:
					label = cur_label + label
				bank = sym_banks.get(label, None)
				if bank is not None and bank != cur_bank and bank != 0 and not re.match(ram_rx, label):
					code = line.split(';', 1)[0].strip()
					print(f"{filename}:{i}: '{code}' in bank {cur_bank:02X} references '{label}' in bank {bank:02X}")
			elif (m := re.match(far_rx, line)):
				label = m.group(1)
				if label.startswith('.') and cur_label is not None:
					label = cur_label + label
				bank = sym_banks.get(label, None)
				if bank is not None and bank == cur_bank:
					code = line.split(';', 1)[0].strip()
					print(f"{filename}:{i}: '{code}' in bank {cur_bank:02X} references '{label}' already in bank {bank:02X}")
