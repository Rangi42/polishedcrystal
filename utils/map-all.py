#!/usr/bin/env python

"""
Generate images of all the maps. Takes an optional whitelist of tilesets.
"""

from __future__ import print_function

import sys
import os
from collections import OrderedDict

code_directory         = './'
tileset_filename       = 'constants/tilemap_constants.asm'
maps_filename          = 'constants/map_constants.asm'
map_headers_filename   = 'maps/map_headers.asm'
block_data_filenames   = {'maps/blockdata_1.asm', 'maps/blockdata_2.asm',
                          'maps/blockdata_3.asm', 'maps/blockdata_4.asm',
                          'maps/blockdata_5.asm', 'maps/blockdata_6.asm'}
block_filename_fmt     = 'maps/%s.blk'

tileset_names = ['johto1', 'johto2', 'kanto1', 'johto3', 'house1', 'house2',
                 'pokecenter', 'gate', 'port', 'lab', 'facility', 'mart',
                 'mansion', 'game_corner', 'gym1', 'house3', 'gym2', 'gym3',
                 'lighthouse', 'kanto2', 'pokecom', 'battle_tower', 'tower',
                 'cave', 'park', 'ruins', 'radio_tower', 'warehouse',
                 'ice_path', 'forest', 'safari', 'alph', 'pokemon_mansion',
                 'faraway', 'tunnel', 'decor', 'shamouti', 'museum', 'hotel',
                 'quiet_cave', 'valencia']

# {'TILESET_JOHTO_1': 1, ...}
tileset_ids = {}
# {'NEW_BARK_TOWN': 9, ...}
map_heights = OrderedDict()
# {'NewBarkTown': 'TILESET_JOHTO_1', ...}
map_tilesets = OrderedDict()
# {'NewBarkTown': 'NewBarkTown.blk', ...}
map_block_data_exceptions = {}

def read_tileset_ids():
	tileset_id = 1
	with open(code_directory + tileset_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('const_value '):
				parts = line.split()
				tileset_id = int(parts[2])
			elif line.startswith('const '):
				parts = line.split()
				tileset_const = parts[1]
				tileset_ids[tileset_const] = tileset_id
				tileset_id += 1
			elif line.startswith('const_def'):
				break

def read_map_heights():
	with open(code_directory + maps_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('mapgroup '):
				parts = line[9:].split(',')
				map_const = parts[0].strip()
				map_height = int(parts[1])
				map_heights[map_const] = map_height

def read_map_tilesets():
	with open(code_directory + map_headers_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('map_header '):
				parts = line[11:].split(',')
				map_name = parts[0].strip()
				map_tileset = parts[1].strip()
				map_tilesets[map_name] = map_tileset

def read_map_block_data():
	for block_data_filename in block_data_filenames:
		with open(code_directory + block_data_filename, 'r') as f:
			map_names = []
			for line in f:
				line = line.strip()
				if line.endswith('_BlockData:'):
					map_names.append(line[:-11])
				elif line.startswith('INCBIN "maps/') and line.endswith('.blk"'):
					block_data_name = line[13:-5]
					for map_name in map_names:
						if map_name != block_data_name:
							map_block_data_exceptions[map_name] = block_data_name
					map_names[:] = []

def render_map_images(valid_tilesets):
	rendered = set()
	for map_const, map_name in sorted(zip(map_heights, map_tilesets)):
		map_height = map_heights[map_const]
		tileset_name = tileset_names[tileset_ids[map_tilesets[map_name]] - 1]
		if not valid_tilesets or tileset_name in valid_tilesets:
			block_data_name = map_block_data_exceptions.get(map_name, map_name)
			if block_data_name in rendered:
				continue
			command = 'python utils/map.py %s %d %s' % (block_filename_fmt % block_data_name, map_height, tileset_name)
			print()
			print(command)
			os.system(command)
			rendered.add(block_data_name)

def main():
	valid_tilesets = sys.argv[1:]
	print('Reading tileset IDs from %s...' % tileset_filename, file=sys.stderr)
	read_tileset_ids()
	print('Reading map heights from %s...' % maps_filename, file=sys.stderr)
	read_map_heights()
	print('Reading map tilesets from %s...' % map_headers_filename, file=sys.stderr)
	read_map_tilesets()
	print('Reading map block data from %s...' % ', '.join(block_data_filenames), file=sys.stderr)
	read_map_block_data()
	print('Rendering map images from each %s...'% (block_filename_fmt % '<name>'), file=sys.stderr)
	render_map_images(valid_tilesets)

if __name__ == '__main__':
	main()
