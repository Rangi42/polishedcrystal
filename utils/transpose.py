#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

"""
Transposes the bytes of the metatiles.bin and attributes.bin files.
"""

# {'tileset name': {old block id: new block id, ...}, ...}
tilesets_moved = {}

tileset_maps = {
'johto_traditional': ['NewBarkTown'],
}

BANK1 = 1 << 3
XFLIP = 1 << 5
YFLIP = 1 << 6

for tileset_name in sorted(tileset_maps.keys()):
	for map_name in sorted(tileset_maps[tileset_name]):
		moved = tilesets_moved.get(tileset_name, {})

		print(map_name)

		map_path = 'maps/%s.ablk' % map_name

		with open(map_path, 'rb') as f:
			map_data = map(ord, f.read())

		for i, bid in enumerate(map_data):
			if bid in moved:
				bid2 = moved[bid]
				map_data[i] = bid2

		with open(map_path, 'wb') as f:
			for v in map_data:
				f.write(chr(v))


def chunks(s, n):
	return [s[i:i+n] for i in range(0, len(s), n)]


for tileset_name in sorted(tileset_maps.keys()):
	moved = tilesets_moved.get(tileset_name, {})
	inv_moved = {v: k for k, v in moved.items()}

	print(tileset_name)

	metatiles_path = 'data/tilesets/%s_metatiles.bin' % tileset_name
	attributes_path = 'data/tilesets/%s_attributes.bin' % tileset_name
	collisions_path = 'data/tilesets/%s_collision.asm' % tileset_name

	with open(metatiles_path, 'rb') as f:
		metatile_data = chunks(map(ord, f.read()), 16)
	with open(attributes_path, 'rb') as f:
		attribute_data = chunks(map(ord, f.read()), 16)
	with open(collisions_path, 'r') as f:
		collision_data = f.readlines()

	metatile_data_2 = []
	attribute_data_2 = []
	collision_data_2 = []

	for bid in range(len(metatile_data)):
		if bid in inv_moved:
			bid = inv_moved[bid]
			if bid >= len(metatile_data):
				bid = 0x00
		metatile_data_2.append(metatile_data[bid])
		attribute_data_2.append(attribute_data[bid])
		collision_data_2.append(collision_data[bid])

	bid = len(metatile_data_2)
	while bid in inv_moved:
		bid = inv_moved[len(metatile_data)]
		if bid >= len(metatile_data):
			bid = 0x00
		metatile_data_2.append(metatile_data[bid])
		attribute_data_2.append(attribute_data[bid])
		collision_data_2.append(collision_data[bid])
		bid = len(metatile_data_2)

	with open(metatiles_path, 'wb') as f:
		for mt in metatile_data_2:
			for v in mt:
				f.write(chr(v))
	with open(attributes_path, 'wb') as f:
		for mt in attribute_data_2:
			for v in mt:
				f.write(chr(v))
	with open(collisions_path, 'w') as f:
		for line in collision_data_2:
			f.write(line)
