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

print('''
> Back in the day, the programming used up all the space on a cartridge, so if
> we wanted to add something new, we had to clean it up first... First we'd
> find enough space, then we could make what we wanted... It was a pain!
> 
> -- Morimoto, Pokémon Ultra Sun/Ultra Moon
> <https://www.serebii.net/ultrasunultramoon/virtualconsole.shtml>'''[1:])

print()

total_size = bank_diff * num_banks
free_space = sum(bank_space)
pct_free = free_space * 100.0 / total_size
print('Free space: {:.0f}/{:.0f} ({:.2f}%)'.format(free_space, total_size, pct_free))

print()

print('bank\tend\tfree')
for bank, end, space in zip(range(num_banks), bank_ends, bank_space):
	print('${:02x}\t${:04x}\t${:04x}'.format(bank, end, space))
