#!/usr/bin/env python3

from PIL import Image

name = 'johto_traditional'

print(name)

def adjust_pixel(px):
	r, g, b = px
	assert r == g == b
	return r // 8

def read_tiles(filename):
	with Image.open(filename) as img:
		img = img.convert('RGB')
		assert img.width % 8 == 0 and img.height % 8 == 0
		return [tuple(adjust_pixel(img.getpixel((col * 8 + x, row * 8 + y)))
			for y in range(8) for x in range(8))
			for row in range(img.height // 8) for col in range(img.width // 8)]

old_tiles = read_tiles(f'gfx/tilesets/{name}.png')
new_tiles = read_tiles(f'gfx/tilesets/johto_common.png') + read_tiles(f'gfx/tilesets/{name}2.png')

new_idxs = {}
for (old_idx, old_tile) in enumerate(old_tiles):
	try:
		new_idxs[old_idx] = new_tiles.index(old_tile)
	except ValueError:
		print(f'warning: old idx ${old_idx:02x} has no new tile')
		new_idxs[old_idx] = 0

def idx_to_id(idx):
	return idx if idx < 0x80 else idx - 0x80 if idx < 0x180 else idx - 0x100

def idx_to_bank(idx, attr):
	return ((1 if 0x80 <= idx < 0x180 else 0) << 3) | (attr & 0b1111_0111)

def id_to_idx(id, attr):
	bank = attr & (1 << 3)
	return id + ((0x80 if bank else 0x0) if id < 0x80 else (0x100 if bank else 0x180))

meta_filename = f'data/tilesets/{name}_metatiles.bin'
attr_filename = f'data/tilesets/{name}_attributes.bin'
with open(meta_filename, 'rb') as file:
	old_metatiles = file.read()
with open(attr_filename, 'rb') as file:
	old_attributes = file.read()

def old_id_to_new_idx(old_id, old_attr):
	old_idx = id_to_idx(old_id, old_attr)
	if old_idx not in new_idxs:
		print(f'warning: old idx ${old_idx:02x} has no new idx')
		return 0
	return new_idxs[old_idx]

new_metatiles, new_attributes = zip(*((
	idx_to_id(old_id_to_new_idx(old_id, old_attr)),
	idx_to_bank(old_id_to_new_idx(old_id, old_attr), old_attr))
	for (old_id, old_attr) in zip(old_metatiles, old_attributes)))

with open(meta_filename, 'wb') as file:
	file.write(bytearray(new_metatiles))
with open(attr_filename, 'wb') as file:
	file.write(bytearray(new_attributes))
