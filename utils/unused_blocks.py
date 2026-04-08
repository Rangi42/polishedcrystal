#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

tileset_maps = {
'johto_traditional': 'CherrygroveBay CherrygroveCity DragonsDenB1F EcruteakCity MagnetTunnelEast MahoganyTown NewBarkTown Route26 Route27 Route28 Route29 Route30 Route31 Route32 Route32Coast Route35 Route36 Route37 Route42 Route44 SilverCaveOutside VioletCity VioletOutskirts',
'johto_modern': 'GoldenrodCity MagnetTunnelWest Route34 Route34Coast StormyBeach',
'johto_coast': 'CianwoodCity GoldenrodHarbor OlivineCity OlivineCityRoute35CoastDual Route35CoastNorth Route35CoastSouth Route38 Route39 Route40 Route41',
'johto_outlands': 'AzaleaTown AzaleaTownRaining BlackthornCity LakeOfRage LakeOfRageFlooded Route33 Route33Raining Route43 Route43Raining Route45 Route46 Route47 Route48 RuggedRoadNorth RuggedRoadSouth SnowtopMountainInside',
'johto_ancient': 'RuinsOfAlphOutside SinjohRuins',
'ecruteak_shrine': 'BellchimeTrail EcruteakShrineOutside',
'battle_tower_outside': 'BattleTowerOutside',
'kanto': 'CeladonCity CinnabarIsland FuchsiaCity LavenderTown MountMoonSquare PalletTown PewterCity Route1 Route2North Route2South Route3 Route6 Route7 Route8 Route10South Route11 Route12North Route16East Route16West Route18East Route19 Route20 Route21 Route22 Route22Past SaffronCity UragaChannelWest VermilionCity ViridianCity',
'kanto_north': 'CeruleanCape CeruleanCity Route4 Route5 Route9 Route10North Route24 Route25',
'indigo_plateau': 'IndigoPlateau LuckyIsland LuckyIslandHidden Route12South Route13East Route13West Route14 Route15 Route17North Route17South Route18West Route23North Route23South UragaChannelEast',
'shamouti_island': 'BeautifulBeach ElementalIsland NavelRockOutside NoisyForest RockyBeach ShamoutiCoast ShamoutiIsland ShamoutiShrineRuins WarmBeach',
'valencia_island': 'Route49 ValenciaIsland',
}

for (tileset, maps) in tileset_maps.items():
	with open(f'data/tilesets/{tileset}_metatiles.bin', 'rb') as file:
		num_blocks = len(file.read()) // 16
	used_blocks = set()
	for map in maps.split():
		with open(f'maps/{map}.ablk', 'rb') as file:
			used_blocks.update(file.read())
	unused_blocks = set(range(1, num_blocks)) - used_blocks
	print(f'# {tileset}: {" ".join(f"{v:02x}" for v in sorted(unused_blocks))}')
