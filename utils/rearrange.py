#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

name = 'mart'
rearrange = {
	# 0xB_ID: 0xB_ID,
}

meta_name = f'data/tilesets/{name}_metatiles.bin'
attr_name = f'data/tilesets/{name}_attributes.bin'

try:
	with open(meta_name, 'rb') as meta_file:
		tile_ids = bytearray(meta_file.read())
	with open(attr_name, 'rb') as attr_file:
		tile_attrs = bytearray(attr_file.read())
except IOError as err:
	print(err, file=sys.stderr)
	sys.exit(1)

assert len(tile_ids) % 16 == 0 and len(tile_ids) == len(tile_attrs)

for i in range(len(tile_ids)):
	index = tile_ids[i] + (0x100 if (tile_attrs[i] & 0x08) else 0)
	if index in rearrange:
		index = rearrange[index]
		tile_ids[i] = index & 0xff
		tile_attrs[i] = (tile_attrs[i] & 0xf7) | (0x08 if index >= 0x100 else 0)

with open(meta_name, 'wb') as meta_file:
	meta_file.write(tile_ids)
with open(attr_name, 'wb') as attr_file:
	attr_file.write(tile_attrs)
