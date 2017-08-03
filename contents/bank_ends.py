#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Find free space per bank.
Taken from Pokémon Prism.
"""

from __future__ import print_function

import sys

bank_diff = 0x4000
num_banks = 0x80
bank_ends = []
bank_space = []
rom_name = sys.argv[1]

with open(rom_name + '.gbc', 'rb') as f1, open(rom_name + '-0xff.gbc', 'rb') as f2:
	for bank in range(num_banks):
		empty_bank = True
		for i in range(bank_diff):
			f1.seek((bank + 1) * bank_diff - i - 1)
			f2.seek((bank + 1) * bank_diff - i - 1)
			if f1.read(1) == f2.read(1):
				bank_space.append(i)
				bank_ends.append(bank_diff * (1 + (bank != 0)) - i)
				empty_bank = False
				break
		if empty_bank:
			bank_space.append(bank_diff)
			bank_ends.append(bank_diff)

for bank, end, space in zip(range(num_banks), bank_ends, bank_space):
	print('Bank ${:02x}: ${:04x} (${:04x})'.format(bank, end, space))
print()

free_banks = sorted(range(num_banks), key = bank_space.__getitem__, reverse = True)
for bank in free_banks:
	space = bank_space[bank]
	print('Bank ${:02x} has ${:04x} bytes of free space'.format(bank, space))
print()

total_size = bank_diff * num_banks
free_space = sum(bank_space)
pct_free = free_space * 100.0 / total_size
print('Free space: {:.0f}/{:.0f} ({:.2f}%)'.format(free_space, total_size, pct_free))
