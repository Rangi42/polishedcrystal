#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Find egg moves that require chain-breeding, Sketch-breeding, or that cannot be
legitimately bred.

False positive conditions:
 * If a Pokémon can only learn a move in special circumstances (with an RBY TM,
   from an event giveaway, etc) it does not count for that Pokémon's learnset.
 * Baby Pokémon are in the NO_EGGS group, so their moves are misread. Try
   temporarily putting them in their evolved forms' egg groups.

False negative conditions:
 * If two Pokémon in an egg group share an egg move, that move may be reported
   as chain-breedable but not actually be learnable by either one.
"""

from __future__ import print_function

import os
import glob
from collections import defaultdict

# ['bulbasaur', 'ivysaur', ..., 'mr__mime', ..., 'celebi']
ordered_mons = []
# {'bulbasaur': 'bulbasaur', 'mrmime': 'mr__mime', ...}
underscore_names = {}
# {'MONSTER': {'bulbasaur', ...}, 'PLANT': {'bulbasaur', ...}, ...}
group_mons = defaultdict(lambda: set())
# {'bulbasaur': {'MONSTER', 'PLANT'}, ...}
mon_groups = defaultdict(lambda: set())
# {'bulbasaur': {'TACKLE', 'GROWL', ...}, ...}
learnset_moves = defaultdict(lambda: set())
# {'bulbasaur': {'LIGHT_SCREEN', 'SKULL_BASH', ...}, ...}
egg_moves = defaultdict(lambda: set())
# {'FIELD'}
sketchable_groups = set()

def get_ordered_mons():
	# Read constants/pokemon_constants.asm
	with open('constants/pokemon_constants.asm', 'r') as file:
		for line in file:
			# Assume that Pokémon constants are defined first in this file
			if line.startswith('\tconst '):
				# '\tconst MR__MIME   ; $7a' => 'mr__mime'
				mon = line[7:].split(';')[0].strip().lower()
				ordered_mons.append(mon)
				simple_name = mon.replace('_', '')
				underscore_names[simple_name] = mon
			# Assume that NUM_POKEMON is defined right after all the Pokémon
			if line.startswith('NUM_POKEMON'):
				break

def get_egg_groups(mon):
	# Read data/pokemon/base_stats/<mon>.asm
	filename = 'data/pokemon/base_stats/%s.asm' % mon
	with open(filename, 'r') as file:
		for line in file:
			line = line.rstrip()
			# Assume that egg groups are correctly commented
			if line.endswith('; egg groups'):
				# '\tdn MONSTER, PLANT ; egg groups' => ['MONSTER', 'PLANT']
				groups = [g.strip() for g in line[4:].split(';')[0].split(',')]
				assert len(groups) == 2
				for group in groups:
					group_mons[group].add(mon)
					mon_groups[mon].add(group)
				return
	raise RuntimeError('no egg group data for %s' % mon)

def get_level_up_moves():
	# Read data/evos_attacks.asm
	with open('data/pokemon/evos_attacks.asm', 'r') as file:
		current_mon = None
		reading_moves = False
		for line in file:
			line = line.rstrip()
			# Assume that evo/attack data is labeled consistently
			if line.endswith('EvosAttacks:'):
				# 'MrMimeEvosAttacks:' => 'mrmime'
				simple_name = line[:-12].lower()
				if simple_name not in underscore_names:
					raise RuntimeError('bad EvosAttacks name: %s' % simple_name)
				current_mon = underscore_names[simple_name]
				continue
			# Assume that level-up moves are terminated consistently
			if line.endswith('no more level-up moves'):
				current_mon = None
				reading_moves = False
				continue
			# Assume that evolutions are terminated consistently
			if line.endswith('no more evolutions'):
				reading_moves = True
				continue
			if not current_mon or not reading_moves:
				continue
			# 'db 1, TACKLE ; comment' => 'TACKLE'
			move = line.split(';')[0].split(',')[-1].strip()
			learnset_moves[current_mon].add(move)

def get_tm_moves(mon):
	# Read data/base_stats/<mon>.asm
	filename = 'data/pokemon/base_stats/%s.asm' % mon
	with open(filename, 'r') as file:
		for line in file:
			line = line.rstrip()
			# Assume that TM/HM moves are correctly commented
			if line.startswith('\ttmhm'):
				# '\ttmhm HEADBUTT, CURSE' => ['HEADBUTT', 'CURSE']
				moves = [m.strip() for m in line[5:].split(',')]
				for move in moves:
					learnset_moves[mon].add(move)
				return
	raise RuntimeError('no tmhm data for %s' % mon)

def get_egg_moves():
	# Read data/egg_moves.asm
	with open('data/pokemon/egg_moves.asm', 'r') as file:
		current_mon = None
		for line in file:
			line = line.rstrip()
			# Skip the trivial case
			if line.startswith('NoEggMoves'):
				continue
			# Assume that egg move data is labeled consistently
			if line.endswith('EggMoves:'):
				# 'MrMimeEggMoves:' => 'mrmime'
				simple_name = line[:-9].lower()
				if simple_name not in underscore_names:
					raise RuntimeError('bad EggMoves name: %s' % simple_name)
				current_mon = underscore_names[simple_name]
				continue
			# Assume that egg moves are terminated consistently
			if line.endswith('db $ff') or line.endswith('db -1'):
				current_mon = None
				continue
			if not current_mon:
				continue
			# Assume that egg moves are defined consistently
			if not line.startswith('\tdb '):
				continue
			# '\tdb LIGHT_SCREEN' => 'LIGHT_SCREEN'
			move = line.split(';')[0].strip().split()[-1]
			egg_moves[current_mon].add(move)

def get_sketchable_groups():
	# A Pokémon with Sketch can breed any move into its egg groups
	for mon, moves in learnset_moves.items():
		if 'SKETCH' in moves:
			for group in mon_groups[mon]:
				sketchable_groups.add(group)

def find_bad_egg_moves(mon, allow_chain=False, allow_sketch=False):
	sketchable = any(group in sketchable_groups for group in mon_groups[mon])
	# Build movepools
	others_movepool = set()
	others_chain_movepool = set()
	for move in learnset_moves[mon]:
		others_movepool.add(move)
	for group in mon_groups[mon]:
		for other_mon in group_mons[group]:
			if other_mon == mon:
				continue
			for move in learnset_moves[other_mon]:
				others_movepool.add(move)
			for move in egg_moves[other_mon]:
				others_chain_movepool.add(move)
	# Print bad egg moves
	for move in egg_moves[mon]:
		if move not in others_movepool:
			chainable = move in others_chain_movepool
			if allow_chain:
				if chainable:
					print(' * %s: %s' % (mon, move))
			elif allow_sketch:
				if not chainable and sketchable:
					print(' * %s: %s' % (mon, move))
			else:
				if not chainable and not sketchable:
					print(' * %s: %s' % (mon, move))

def main():
	get_ordered_mons()
	for mon in ordered_mons:
		get_egg_groups(mon)
	get_level_up_moves()
	for mon in ordered_mons:
		get_tm_moves(mon)
	get_egg_moves()
	get_sketchable_groups()
	print('These egg moves must be chain-bred:')
	for mon in ordered_mons:
		find_bad_egg_moves(mon, allow_chain=True)
	print('These egg moves must be Sketch-bred:')
	for mon in ordered_mons:
		find_bad_egg_moves(mon, allow_sketch=True)
	print('These egg moves cannot be legitimately bred:')
	for mon in ordered_mons:
		find_bad_egg_moves(mon)

if __name__ == '__main__':
	main()
