#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

import png

def rgb5_pixels(row):
	yield from (tuple(c // 8 for c in row[x:x+3]) for x in range(0, len(row), 4))

def gray_pixels(row):
	yield from (pixel[0] // 10 for pixel in row)

def rows_to_tiles(rows, width, height):
	assert len(rows) == height and len(rows[0]) == width
	yield from (tuple(tuple(row[x:x+8]) for row in rows[y:y+8])
		for y in range(0, height, 8) for x in range(0, width, 8))

def tiles_to_rows(tiles, width, height):
	assert width % 8 == 0 and height % 8 == 0
	width, height = width // 8, height // 8
	tiles = list(tiles)
	assert len(tiles) == width * height
	tile_rows = (tiles[y:y+width] for y in range(0, width * height, width))
	yield from ([tile[y][x] for tile in tile_row for x in range(8)]
		for tile_row in tile_rows for y in range(8))

for name in sys.argv[1:]:
	png_name  = f'gfx/tilesets/{name}.png'
	meta_name = f'data/tilesets/{name}_metatiles.bin'
	attr_name = f'data/tilesets/{name}_attributes.bin'

	try:
		with open(png_name, 'rb') as png_file:
			width, height, png_rows = png.Reader(png_file).asRGBA8()[:3]
			png_rows = [list(rgb5_pixels(row)) for row in png_rows]
		with open(meta_name, 'rb') as meta_file:
			tile_ids = bytearray(meta_file.read())
		with open(attr_name, 'rb') as attr_file:
			tile_attrs = bytearray(attr_file.read())
	except IOError as err:
		print(err, file=sys.stderr)
		continue

	assert width % 8 == 0 and height % 8 == 0
	assert len(tile_ids) % 16 == 0 and len(tile_ids) == len(tile_attrs)

	blank = tuple(tuple([(31, 31, 31)] * 8) for _ in range(8))

	duplicate = [[(0, 0, 0)] * 8 for _ in range(8)]
	for y in range(8):
		duplicate[y][y] = duplicate[y][7 - y] = (31, 31, 31)
	duplicate = tuple(tuple(row) for row in duplicate)

	tiles = []
	tile_lookup = {}
	for (index, tile) in enumerate(rows_to_tiles(png_rows, width, height)):
		if index == 0x7F and tile == blank:
			tiles.append(tile)
			continue
		if tile not in tile_lookup:
			tiles.append(tile)
			id = index & 0x7F
			bank = 0x08 if 0x80 <= index < 0x180 else 0x00
			xy_tile = tuple(row[::-1] for row in tile[::-1])
			tile_lookup[xy_tile] = (id, 0x60 | bank)
			y_tile = tile[::-1]
			tile_lookup[y_tile] = (id, 0x40 | bank)
			x_tile = tuple(row[::-1] for row in tile)
			tile_lookup[x_tile] = (id, 0x20 | bank)
			tile_lookup[tile] = (id, bank)
			continue
		tiles.append(duplicate if tile != blank else blank)
		dedup_id, dedup_attr = tile_lookup[tile]
		for i in range(len(tile_ids)):
			tile_index = (tile_ids[i] + 0x80 if (tile_attrs[i] & 0x08) else
				tile_ids[i] + (tile_ids[i] & 0x80) * 2)
			if tile_index == index:
				tile_ids[i] = dedup_id
				tile_attrs[i] = dedup_attr | (tile_attrs[i] & 0x97)

	rows = [list(gray_pixels(row)) for row in tiles_to_rows(tiles, width, height)]
	writer = png.Writer(width, height, greyscale=True, bitdepth=2, compression=9)
	with open(png_name, 'wb') as png_file:
		writer.write(png_file, rows)
	with open(meta_name, 'wb') as meta_file:
		meta_file.write(tile_ids)
	with open(attr_name, 'wb') as attr_file:
		attr_file.write(tile_attrs)
