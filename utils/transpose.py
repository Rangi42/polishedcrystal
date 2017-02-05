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
	with open(mapfile, 'r') as f:
		for line in f:
			if '<->' in line:
				a, b = line.split('<->')
				a = int(a, 16)
				b = int(b, 16)
				mapping[a] = b
				mapping[b] = a
			elif '->' in line:
				a, b = line.split('->')
				a = int(a, 16)
				b = int(b, 16)
				mapping[a] = b
	return mapping

def transpose_metatiles(metatiles, mapping):
	data = []
	with open(metatiles, 'rb') as f:
		for a in f.read():
			data.append(chr(mapping.get(ord(a), ord(a))))
	with open(metatiles, 'wb') as f:
		f.write(''.join(data))

def transpose_palette(palette, mapping):
	data = []
	with open(palette, 'r') as f:
		for line in f:
			line = line.strip()
			if not line.startswith('tilepal '):
				continue
			parts = [p.strip() for p in line.split(',')]
			data.extend(parts[1:9])
			if len(data) == 0x60:
				data.extend(['ROOF'] * 0x20)
	data.extend(['ROOF'] * (0x100 - len(data)))
	with open(palette, 'wb') as f:
		for i in range(28):
			if i == 12:
				f.write('\nrept 16\n\tdb $ff\nendr\n\n')
				continue
			elif i in [13, 14, 15]:
				continue
			seg = 0 if i < 12 else 1
			row = [mapping.get(i*8+j, i*8+j) for j in range(8)]
			line = '\ttilepal %d, %s\n' % (seg, ', '.join(data[b] for b in row))
			f.write(line)

def main():
	if len(sys.argv) < 3:
		print('Usage: %s map.txt tilesetID' % sys.argv[0])
		print('       Transpose metatiles.bin and palette_map.asm')
		sys.exit(1)

	mapfile = sys.argv[1]
	tilesetID = sys.argv[2]
	metatiles = 'tilesets/%s_metatiles.bin' % tilesetID
	palette = 'tilesets/%s_palette_map.asm' % tilesetID

	mapping = build_map(mapfile)
	transpose_metatiles(metatiles, mapping)
	transpose_palette(palette, mapping)

if __name__ == '__main__':
	main()
