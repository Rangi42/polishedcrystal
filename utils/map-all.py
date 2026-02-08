#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Generate images of all the maps. Takes an optional whitelist of tilesets.
"""

from __future__ import print_function

import sys
import os
from collections import OrderedDict

code_directory       = './'
tileset_filename     = 'constants/tileset_constants.asm'
maps_filename        = 'constants/map_constants.asm'
map_headers_filename = 'data/maps/maps.asm'
block_data_filename  = 'data/maps/blocks.asm'
block_filename_fmt   = 'maps/%s.ablk'

tileset_names = [
	'johto_traditional', 'johto_modern', 'battle_tower_outside', 'johto_overcast',
	'kanto', 'indigo_plateau', 'shamouti_island', 'valencia_island', 'faraway_island',
	'johto_house', 'kanto_house', 'traditional_house', 'pokecenter', 'pokecom_center',
	'mart', 'gate', 'gym', 'magnet_train', 'champions_room', 'port', 'lab',
	'facility', 'celadon_mansion', 'game_corner', 'home_decor_store', 'museum',
	'hotel', 'sprout_tower', 'battle_tower_inside', 'radio_tower', 'lighthouse',
	'underground', 'cave', 'quiet_cave', 'ice_path', 'tunnel', 'forest', 'park',
	'safari_zone', 'ruins_of_alph', 'alph_word_room', 'pokemon_mansion'
]

# {'TILESET_PC_JOHTO_1': 1, ...}
tileset_ids = {}
# {'NEW_BARK_TOWN': 10, ...}
map_widths = OrderedDict()
# {'NewBarkTown': 'TILESET_PC_JOHTO_1', ...}
map_tilesets = OrderedDict()
# {'NewBarkTown': 'NewBarkTown.ablk', ...}
map_block_data_exceptions = {}

def read_tileset_ids():
	tileset_id = 1
	with open(code_directory + tileset_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('const PAL_BG_'):
				break
			elif line.startswith('const_def '):
				parts = line.split()
				tileset_id = int(parts[1])
			elif line.startswith('const '):
				parts = line.split()
				tileset_const = parts[1]
				tileset_ids[tileset_const] = tileset_id
				tileset_id += 1

def read_map_widths():
	with open(code_directory + maps_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('map_const '):
				parts = line[10:].split(',')
				map_const = parts[0].strip()
				map_width = int(parts[1])
				map_widths[map_const] = map_width

def read_map_tilesets():
	with open(code_directory + map_headers_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('map '):
				parts = line[4:].split(',')
				map_name = parts[0].strip()
				map_tileset = parts[1].strip()
				map_tilesets[map_name] = map_tileset

def read_map_block_data():
	with open(code_directory + block_data_filename, 'r') as f:
		map_names = []
		for line in f:
			line = line.strip()
			if line.endswith('_BlockData:'):
				map_names.append(line[:-11])
			elif line.startswith('INCBIN "maps/') and line.endswith('.ablk.lz"'):
				block_data_name = line[13:-9]
				for map_name in map_names:
					if map_name != block_data_name:
						map_block_data_exceptions[map_name] = block_data_name
				map_names[:] = []

def render_map_images(valid_tilesets):
	rendered = set()
	for map_const, map_name in sorted(zip(map_widths, map_tilesets)):
		map_width = map_widths[map_const]
		tileset_id = tileset_ids[map_tilesets[map_name]]
		tileset_name = tileset_names[tileset_id - 1] if tileset_id <= len(tileset_names) else None
		if tileset_name and (not valid_tilesets or tileset_name in valid_tilesets):
			block_data_name = map_block_data_exceptions.get(map_name, map_name)
			if block_data_name in rendered:
				continue
			command = 'python utils/map.py %s %d %s' % (block_filename_fmt % block_data_name, map_width, tileset_name)
			print()
			print(command)
			os.system(command)
			rendered.add(block_data_name)

def main():
	valid_tilesets = sys.argv[1:]
	print('Reading tileset IDs from %s...' % tileset_filename, file=sys.stderr)
	read_tileset_ids()
	print('Reading map widths from %s...' % maps_filename, file=sys.stderr)
	read_map_widths()
	print('Reading map tilesets from %s...' % map_headers_filename, file=sys.stderr)
	read_map_tilesets()
	print('Reading map block data from %s...' % block_data_filename, file=sys.stderr)
	read_map_block_data()
	print('Rendering map images from each %s...'% (block_filename_fmt % '<name>'), file=sys.stderr)
	render_map_images(valid_tilesets)

if __name__ == '__main__':
	main()
