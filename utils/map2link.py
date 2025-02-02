#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Usage: python map2link.py pokecrystal.map > layout.link

Outputs a linker script to reproduce all the sections defined in a map file.
"""

import sys
import re

def main():
	if len(sys.argv) != 2:
		print(f'Usage: {sys.argv[0]} pokecrystal.map > layout.link', file=sys.stderr)
		sys.exit(1)

	bank_rx = re.compile(r'^(ROM0|ROMX|VRAM|SRAM|WRAM0|WRAMX|OAM|HRAM) bank #([0-9]+):$')
	section_rx = re.compile(r'^\tSECTION: (\$[0-9a-f]+).+\[(".+")\]$')

	filename = sys.argv[1]
	with open(filename, 'r', encoding='utf-8') as file:
		print(f'; Generated from {filename}')
		for line in file:
			if (m := re.match(bank_rx, line)):
				kind, bank = m.group(1), m.group(2)
				print(f'{kind} {bank}')
			elif (m := re.match(section_rx, line)):
				addr, name = m.group(1), m.group(2)
				print(f'\torg {addr}\n\t{name}')

if __name__ == '__main__':
	main()
