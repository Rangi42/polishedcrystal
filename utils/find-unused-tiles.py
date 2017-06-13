#!/usr/bin/env python

"""
Find unused tiles and blocks.
Usage: utils/find-unused-tiles.py > unused-tiles.txt
"""

from __future__ import print_function

import sys
from collections import defaultdict

code_directory         = './'
tileset_filename       = 'constants/tilemap_constants.asm'
map_headers_filename   = 'maps/map_headers.asm'
map_headers_2_filename = 'maps/second_map_headers.asm'
block_data_filenames   = {'maps/blockdata_1.asm', 'maps/blockdata_2.asm',
                          'maps/blockdata_3.asm', 'maps/blockdata_4.asm',
                          'maps/blockdata_5.asm', 'maps/blockdata_6.asm'}
block_filename_fmt     = 'maps/%s.blk'
metatile_filename_fmt  = 'tilesets/%s_metatiles.bin'

tileset_names = ['johto1', 'johto2', 'kanto1', 'johto3', 'house1', 'house2',
                 'pokecenter', 'gate', 'port', 'lab', 'facility', 'mart',
                 'mansion', 'game_corner', 'gym1', 'house3', 'gym2', 'gym3',
                 'lighthouse', 'kanto2', 'pokecom', 'battle_tower', 'tower',
                 'cave', 'park', 'ruins', 'radio_tower', 'warehouse',
                 'ice_path', 'forest', 'safari', 'alph', 'pokemon_mansion',
                 'faraway', 'tunnel', 'decor', 'shamouti', 'museum', 'hotel',
                 'quiet_cave', 'valencia']

# {'TILESET_JOHTO_1': 'johto1', ...}
tileset_ids = {}
# {'NewBarkTown': 'johto1', ...}
map_tilesets = {}
# {'johto1': {'NewBarkTown', ...}, ...}
tileset_maps = defaultdict(lambda: set())

# {'OlivineTimsHouse': 'House1', ...}
map_block_data_exceptions = {}

# {tileset 'johto1': {tile '01', tile '02', tile '03', ...}, ...}
tileset_used_tile_ids = defaultdict(lambda: set())
# {tileset 'johto1': {block '01', block '02', block '03', ...}, ...}
tileset_used_block_ids = defaultdict(lambda: set())

# {tileset 'johto1': {tile '01', tile '02', tile '03', ...}, ...}
tileset_unused_tile_ids = defaultdict(lambda: set())
# {tileset 'johto1': {block '01', block '02', block '03', ...}, ...}
tileset_unused_block_ids = defaultdict(lambda: set())

def pretty(n):
	return hex(n)[2:].zfill(2)

def pretty_join(s, g, x='none!'):
	return g.join(sorted(s)) if s else x

def build_unused_ids(used_ids, domain=None, limit=0xff):
	domain = set(range(limit + 1)) if domain is None else domain
	unused_ids = set()
	first, last = None, None
	for id in sorted(domain - used_ids):
		if first is None:
			first = last = id
			continue
		if last == id - 1:
			last = id
			continue
		if last - first < 2:
			unused_ids.add(pretty(first))
			unused_ids.add(pretty(last))
		else:
			if last == limit:
				unused_ids.add(pretty(first) + '+')
			else:
				unused_ids.add(pretty(first) + '-' + pretty(last))
		first = last = id
	if first is not None:
		if last - first < 2:
			unused_ids.add(pretty(first))
			unused_ids.add(pretty(last))
		else:
			if last == limit:
				unused_ids.add(pretty(first) + '+')
			else:
				unused_ids.add(pretty(first) + '-' + pretty(last))
	return unused_ids

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
				tileset_name = parts[1]
				tileset_ids[tileset_name] = tileset_names[tileset_id - 1]
				tileset_id += 1
			elif line.startswith('const_def'):
				break

def read_map_tilesets():
	with open(code_directory + map_headers_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('map_header '):
				parts = line.split()
				map_name = parts[1].rstrip(',')
				tileset_name = parts[2].rstrip(',')
				tileset_id = tileset_ids[tileset_name]
				map_tilesets[map_name] = tileset_id
				tileset_maps[tileset_id].add(map_name)

def read_block_filenames():
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

def read_used_block_ids():
	for map_name, tileset_id in map_tilesets.items():
		block_data_name = map_block_data_exceptions.get(map_name, map_name)
		with open(code_directory + block_filename_fmt % block_data_name, 'rb') as f:
			used_block_ids = {ord(b) for b in f.read()}
			tileset_used_block_ids[tileset_id].update(used_block_ids)

def read_used_block_ids_2():
	with open(code_directory + map_headers_2_filename, 'r') as f:
		for line in f:
			line = line.strip()
			if line.startswith('map_header_2 '):
				parts = line.split()
				map_name = parts[1].rstrip(',')
				used_block_id = parts[3].rstrip(',')
				if used_block_id.startswith('$'):
					used_block_id = int(used_block_id[1:], 16)
				else:
					used_block_id = int(used_block_id)
				tileset_id = map_tilesets[map_name]
				tileset_used_block_ids[tileset_id].add(used_block_id)

def read_used_tile_ids():
	for tileset_id in tileset_ids.values():
		with open(code_directory + metatile_filename_fmt % tileset_id, 'rb') as f:
			block_id = 0
			while True:
				used_tile_ids = [ord(b) for b in f.read(16)]
				if not used_tile_ids:
					break
				if block_id in tileset_used_block_ids[tileset_id]:
					tileset_used_tile_ids[tileset_id].update(used_tile_ids)
				block_id += 1

def find_unused_block_ids():
	for tileset_id, used_block_ids in tileset_used_block_ids.items():
		try:
			unused_block_ids = build_unused_ids(used_block_ids)
		except ValueError:
			unused_block_ids = set()
		tileset_unused_block_ids[tileset_id].update(unused_block_ids)

def find_unused_tile_ids():
	for tileset_id, used_tile_ids in tileset_used_tile_ids.items():
		domain = set(range(0x00, 0x70)) | set(range(0x80, 0x100))
		unused_tile_ids = build_unused_ids(used_tile_ids, domain)
		tileset_unused_tile_ids[tileset_id].update(unused_tile_ids)

def main():
	print('Reading tileset IDs from %s...' % tileset_filename, file=sys.stderr)
	read_tileset_ids()
	print('Reading map tilesets from %s...' % map_headers_filename, file=sys.stderr)
	read_map_tilesets()
	print('Reading block file names from %s...' % ', '.join(block_data_filenames), file=sys.stderr)
	read_block_filenames()
	print('Reading used block IDs from each %s...' % (block_filename_fmt % '<name>'), file=sys.stderr)
	read_used_block_ids()
	print('Reading used block IDs from %s...' % map_headers_2_filename, file=sys.stderr)
	read_used_block_ids_2()
	print('Reading used tile IDs from each %s...' % (metatile_filename_fmt % '##'), file=sys.stderr)
	read_used_tile_ids()
	print('Finding unused block IDs...', file=sys.stderr)
	find_unused_block_ids()
	print('Finding unused tile IDs...', file=sys.stderr)
	find_unused_tile_ids()
	print('Printing results...', file=sys.stderr)
	for tileset_id in sorted(tileset_unused_tile_ids, key=tileset_names.index):
		print('tileset %s:' % tileset_id)
		print('\tmaps = %s' % pretty_join(tileset_maps[tileset_id], ', '))
		print('\tunused tiles = %s' % pretty_join(tileset_unused_tile_ids[tileset_id], ' '))
		print('\tunused blocks = %s' % pretty_join(tileset_unused_block_ids[tileset_id], ' '))
		print()

if __name__ == '__main__':
	main()
