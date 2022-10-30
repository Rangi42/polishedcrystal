#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

tileset_maps = {
'johto_traditional': 'BellchimeTrail CherrygroveBay CherrygroveCity DragonsDenB1F EcruteakCity MagnetTunnelEast MahoganyTown NewBarkTown Route26 Route27 Route28 Route29 Route30 Route31 Route32 Route32Coast Route35 Route36 Route37 Route42 Route44 SilverCaveOutside VioletCity VioletOutskirts'.split(),
'johto_modern': 'CianwoodCity GoldenrodCity GoldenrodHarbor MagnetTunnelWest OlivineCity OlivineCityRoute35CoastDual Route34 Route34Coast Route35CoastNorth Route35CoastSouth Route38 Route39 Route40 Route41 StormyBeach'.split(),
'johto_overcast': 'AzaleaTown AzaleaTownRaining BlackthornCity LakeOfRage LakeOfRageFlooded Route33 Route33Raining Route43 Route43Raining Route45 Route46 Route47 Route48 RuggedRoadNorth RuggedRoadSouth RuinsOfAlphOutside SinjohRuins SnowtopMountainInside'.split(),
'ecruteak_shrine': 'EcruteakShrineOutside'.split(),
'battle_tower_outside': 'BattleTowerOutside'.split(),
}

for (tileset, maps) in tileset_maps.items():
	with open(f'data/tilesets/{tileset}_metatiles.bin', 'rb') as file:
		num_blocks = len(file.read()) // 16
	used_blocks = set()
	for map in maps:
		with open(f'maps/{map}.ablk', 'rb') as file:
			used_blocks.update(file.read())
	unused_blocks = set(range(1, num_blocks)) - used_blocks
	print(f'# {tileset}: {" ".join(f"{v:02x}" for v in sorted(unused_blocks))}')
