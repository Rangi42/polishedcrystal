#!/usr/bin/env python

"""
Transposes the bytes of the metatiles.bin and palette_map.asm files for a
particular tileset.
"""

from __future__ import print_function

import sys

from itertools import izip_longest

def chunk(L, n, fillvalue=None):
	return izip_longest(*[iter(L)] * n, fillvalue=fillvalue)

def build_map(mapfile):
	mapping = {}
	revmap = {}
	with open(mapfile, 'r') as f:
		for line in f:
			if '<->' in line:
				a, b = line.split('<->')
				a, b = int(a, 16), int(b, 16)
				mapping[a], mapping[b] = b, a
				revmap[b], revmap[a] = a, b
			elif '->' in line:
				a, b = line.split('->')
				a, b = int(a, 16), int(b, 16)
				mapping[a] = b
				revmap[b] = a
	return (mapping, revmap)

def transpose_metatiles(metatiles, mapping):
	data = []
	with open(metatiles, 'rb') as f:
		for a in f.read():
			data.append(chr(mapping.get(ord(a), ord(a))))
	with open(metatiles, 'wb') as f:
		f.write(''.join(data))

def transpose_palette(palette, revmap):
	data = []
	with open(palette, 'r') as f:
		for line in f:
			line = line.strip()
			if not line.startswith('tilepal '):
				continue
			parts = [p.strip() for p in line.split(',')]
			data.extend(parts[1:])
	data.extend(['TEXT'] * (0x100 - len(data)))
	new_data = [data[revmap.get(i, i)] for i in range(0x100)]
	while new_data and new_data[-1] == 'TEXT':
		new_data.pop()
	if len(new_data) % 2:
		new_data.append('TEXT')
	with open(palette, 'wb') as f:
		n = 0
		while new_data:
			row, new_data = new_data[:8], new_data[8:]
			seg = 0 if n < 0x80 else 1
			line = '\ttilepal %d, %s\n' % (seg, ', '.join(row))
			f.write(line)
			n += len(row)

def main():
	if len(sys.argv) < 3:
		print('Usage: %s map.txt tilesetID' % sys.argv[0])
		print('       Transpose metatiles.bin and palette_map.asm')
		sys.exit(1)

	mapfile = sys.argv[1]
	tilesetID = sys.argv[2]
	metatiles = 'tilesets/%s_metatiles.bin' % tilesetID
	palette = 'tilesets/%s_palette_map.asm' % tilesetID

	mapping, revmap = build_map(mapfile)
	transpose_metatiles(metatiles, mapping)
	transpose_palette(palette, revmap)

if __name__ == '__main__':
	main()
