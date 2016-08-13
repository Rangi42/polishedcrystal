#!/usr/bin/env python

"""
Find unused tiles and blocks.
Usage: utils/find-unused-tiles.py > unused-tiles.txt
"""

from sys import stderr
from collections import defaultdict

code_directory         = './'
tileset_filename       = 'constants/tilemap_constants.asm'
map_headers_filename   = 'maps/map_headers.asm'
map_headers_2_filename = 'maps/second_map_headers.asm'
block_data_filenames   = ['maps/blockdata_1.asm', 'maps/blockdata_2.asm',
                          'maps/blockdata_3.asm', 'maps/blockdata_4.asm']
block_filename_fmt     = 'maps/%s.blk'
metatile_filename_fmt  = 'tilesets/%s_metatiles.bin'

# {'TILESET_JOHTO_1': '01', ...}
tileset_ids = {}
# {'OlivinePokeCenter1F': '01', ...}
map_tilesets = {}

# {tileset '01': {tile '01', tile '02', tile '03', ...}, ...}
tileset_used_tile_ids = defaultdict(lambda: set())
# {tileset '01': {block '01', block '02', block '03', ...}, ...}
tileset_used_block_ids = defaultdict(lambda: set())

# {tileset '01': {tile '01', tile '02', tile '03', ...}, ...}
tileset_unused_tile_ids = defaultdict(lambda: set())
# {tileset '01': {block '01', block '02', block '03', ...}, ...}
tileset_unused_block_ids = defaultdict(lambda: set())

def pretty(n):
	return hex(n)[2:].zfill(2)

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
				tileset_ids[tileset_name] = str(tileset_id).zfill(2)
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

def read_used_block_ids():
	for map_name, tileset_id in map_tilesets.items():
		block_data_name = map_block_data_exceptions.get(map_name, map_name)
		with open(code_directory + block_filename_fmt % block_data_name, 'rb') as f:
			used_block_ids = {pretty(ord(b)) for b in f.read()}
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
					used_block_id = pretty(int(used_block_id[1:], 16))
				else:
					used_block_id = pretty(int(used_block_id))
				tileset_id = map_tilesets[map_name]
				tileset_used_block_ids[tileset_id].add(used_block_id)

def read_used_tile_ids():
	for tileset_id in tileset_ids.values():
		with open(code_directory + metatile_filename_fmt % tileset_id, 'rb') as f:
			block_id = 0
			while True:
				used_tile_ids = [pretty(ord(b)) for b in f.read(16)]
				if not used_tile_ids:
					break
				if pretty(block_id) in tileset_used_block_ids[tileset_id]:
					tileset_used_tile_ids[tileset_id].update(used_tile_ids)
				block_id += 1

def find_unused_block_ids():
	for tileset_id, used_block_ids in tileset_used_block_ids.items():
		limit = int(max(used_block_ids), 16) + 1
		domain = set(pretty(b) for b in range(limit))
		unused_block_ids = domain - used_block_ids
		unused_block_ids.add(pretty(limit) + '+')
		tileset_unused_block_ids[tileset_id].update(unused_block_ids)

def find_unused_tile_ids():
	for tileset_id, used_tile_ids in tileset_used_tile_ids.items():
		domain = {pretty(b) for b in set(range(0x00, 0x60)) | set(range(0x80, 0xE0))}
		unused_tile_ids = domain - used_tile_ids
		offsets = set(range(0x00, 0x60, 0x10)) | set(range(0x80, 0xE0, 0x10))
		stripes = sum([[{pretty(b) for b in range(d, d + span)} for d in offsets]
			for span in range(0x60, 0x00, -0x10)], [])
		for stripe in stripes:
			if stripe.issubset(unused_tile_ids):
				unused_tile_ids -= stripe
				marker = min(stripe) + '-' + max(stripe)
				unused_tile_ids.add(marker)
		tileset_unused_tile_ids[tileset_id].update(unused_tile_ids)

def main():
	print >> stderr, 'Reading tileset IDs from %s...' % tileset_filename
	read_tileset_ids()
	print >> stderr, 'Reading tileset IDs from %s...' % ', '.join(block_data_filenames)
	read_map_tilesets()
	print >> stderr, 'Reading used block IDs from each %s...' % (block_filename_fmt % '<name>')
	read_used_block_ids()
	print >> stderr, 'Reading used block IDs from %s...' % map_headers_2_filename
	read_used_block_ids_2()
	print >> stderr, 'Reading used tile IDs from each %s...' % (metatile_filename_fmt % '##')
	read_used_tile_ids()
	print >> stderr, 'Finding unused block IDs...'
	find_unused_block_ids()
	print >> stderr, 'Finding unused tile IDs...'
	find_unused_tile_ids()
	print >> stderr, 'Printing results...'
	for tileset_id in sorted(tileset_unused_tile_ids):
		print 'tileset %s:' % tileset_id
		print '\tunused tiles = %s' % ' '.join(sorted(tileset_unused_tile_ids[tileset_id]))
		print '\tunused blocks = %s' % ' '.join(sorted(tileset_unused_block_ids[tileset_id]))
		print

map_block_data_exceptions = {
'OlivineTimsHouse': 'House1',
'OlivinePunishmentSpeechHouse': 'House1',
'OlivineGoodRodHouse': 'House1',
'Route39Farmhouse': 'House1',
'MahoganyRedGyaradosSpeechHouse': 'House1',
'BlackthornDragonSpeechHouse': 'House1',
'BlackthornEmysHouse': 'House1',
'MoveDeletersHouse': 'House1',
'CeruleanGymBadgeSpeechHouse': 'House1',
'CeruleanPoliceStation': 'House1',
'CeruleanTradeSpeechHouse': 'House1',
'BillsHouse': 'House1',
'CharcoalKiln': 'House1',
'LakeofRageHiddenPowerHouse': 'House1',
'LakeofRageMagikarpHouse': 'House1',
'GoldenrodHappinessRater': 'House1',
'GoldenrodBillsHouse': 'House1',
'GoldenrodPPSpeechHouse': 'House1',
'GoldenrodNameRater': 'House1',
'VermilionHouseFishingSpeechHouse': 'House1',
'VermilionMagnetTrainSpeechHouse': 'House1',
'VermilionHouseDiglettsCaveSpeechHouse': 'House1',
'BluesHouse': 'House1',
'PewterNidoranSpeechHouse': 'House1',
'PewterSnoozeSpeechHouse': 'House1',
'FuchsiaBillSpeechHouse': 'House1',
'LavenderTownSpeechHouse': 'House1',
'LavenderNameRater': 'House1',
'Route12SuperRodHouse': 'House1',
'Route28FamousSpeechHouse': 'House1',
'CeladonMansionRoofHouse': 'House1',
'Route16FuchsiaSpeechHouse': 'House1',
'ManiasHouse': 'House1',
'CianwoodPharmacy': 'House1',
'CianwoodCityPhotoStudio': 'House1',
'CianwoodLugiaSpeechHouse': 'House1',
'PokeSeersHouse': 'House1',
'ViridianNicknameSpeechHouse': 'House1',
'Route2NuggetSpeechHouse': 'House1',
'KrissNeighborsHouse': 'House1',
'Route26HealSpeechHouse': 'House1',
'Route26DayofWeekSiblingsHouse': 'House1',
'Route27SandstormHouse': 'House1',
'MrPsychicsHouse': 'House1',
'Route5CleanseTagSpeechHouse': 'House1',
'CherrygroveGymSpeechHouse': 'House1',
'GuideGentsHouse': 'House1',
'CherrygroveEvolutionSpeechHouse': 'House1',
'Route30BerrySpeechHouse': 'House1',
'Route19FuchsiaGate': 'NorthSouthGate',
'Route43MahoganyGate': 'NorthSouthGate',
'Route43Gate': 'NorthSouthGate',
'Route35Goldenrodgate': 'NorthSouthGate',
'Route36RuinsofAlphgate': 'NorthSouthGate',
'Route34IlexForestGate': 'NorthSouthGate',
'Route6SaffronGate': 'NorthSouthGate',
'Route40BattleTowerGate': 'NorthSouthGate',
'Route2Gate': 'NorthSouthGate',
'Route2946Gate': 'NorthSouthGate',
'Route5SaffronCityGate': 'NorthSouthGate',
'ViridianForestViridianGate': 'NorthSouthGate',
'ViridianForestPewterGate': 'NorthSouthGate',
'YellowForestGate': 'NorthSouthGate',
'SafariZoneFuchsiaGate': 'NorthSouthGate',
'Route38EcruteakGate': 'EastWestGate',
'Route42EcruteakGate': 'EastWestGate',
'Route32RuinsofAlphGate': 'EastWestGate',
'Route36VioletGate': 'EastWestGate',
'IlexForestAzaleaGate': 'EastWestGate',
'Route15FuchsiaGate': 'EastWestGate',
'Route8SaffronGate': 'EastWestGate',
'Route11Gate': 'EastWestGate',
'Route16Gate': 'EastWestGate',
'Route7SaffronGate': 'EastWestGate',
'Route1718Gate': 'EastWestGate',
'Route31VioletGate': 'EastWestGate',
'OlivineMart': 'Mart',
'EcruteakMart': 'Mart',
'BlackthornMart': 'Mart',
'CeruleanMart': 'Mart',
'AzaleaMart': 'Mart',
'VioletMart': 'Mart',
'VermilionMart': 'Mart',
'PewterMart': 'Mart',
'FuchsiaMart': 'Mart',
'LavenderMart': 'Mart',
'ViridianMart': 'Mart',
'SaffronMart': 'Mart',
'CherrygroveMart': 'Mart',
'OlivinePokeCenter1F': 'PokeCenter1F',
'MahoganyPokeCenter1F': 'PokeCenter1F',
'EcruteakPokeCenter1F': 'PokeCenter1F',
'BlackthornPokeCenter1F': 'PokeCenter1F',
'CinnabarPokeCenter1F': 'PokeCenter1F',
'CeruleanPokeCenter1F': 'PokeCenter1F',
'Route10PokeCenter1F': 'PokeCenter1F',
'AzaleaPokeCenter1F': 'PokeCenter1F',
'VioletPokeCenter1F': 'PokeCenter1F',
'Route32PokeCenter1F': 'PokeCenter1F',
'VermilionPokeCenter1F': 'PokeCenter1F',
'PewterPokeCenter1F': 'PokeCenter1F',
'FuchsiaPokeCenter1F': 'PokeCenter1F',
'LavenderPokeCenter1F': 'PokeCenter1F',
'SilverCavePokeCenter1F': 'PokeCenter1F',
'CeladonPokeCenter1F': 'PokeCenter1F',
'CianwoodPokeCenter1F': 'PokeCenter1F',
'ViridianPokeCenter1F': 'PokeCenter1F',
'SaffronPokeCenter1F': 'PokeCenter1F',
'CherrygrovePokeCenter1F': 'PokeCenter1F',
'GoldenrodDeptStore1F': 'DeptStore1F',
'CeladonDeptStore1F': 'DeptStore1F',
'GoldenrodDeptStore2F': 'DeptStore2F',
'CeladonDeptStore2F': 'DeptStore2F',
'GoldenrodDeptStore3F': 'DeptStore3F',
'CeladonDeptStore3F': 'DeptStore3F',
'GoldenrodDeptStore4F': 'DeptStore4F',
'CeladonDeptStore4F': 'DeptStore4F',
'GoldenrodDeptStore5F': 'DeptStore5F',
'CeladonDeptStore5F': 'DeptStore5F',
'GoldenrodDeptStore6F': 'DeptStore6F',
'CeladonDeptStore6F': 'DeptStore6F',
'GoldenrodDeptStoreElevator': 'DeptStoreElevator',
'CeladonDeptStoreElevator': 'DeptStoreElevator',
'TimeCapsule': 'TradeCenter',
'EcruteakLugiaSpeechHouse': 'House2',
'EcruteakItemfinderHouse': 'House2',
'VioletNicknameSpeechHouse': 'House2',
'VioletOnixTradeHouse': 'House2',
'NationalParkBugContest': 'NationalPark',
'Route6UndergroundEntrance': 'UndergroundPathEntrance',
'Route5UndergroundEntrance': 'UndergroundPathEntrance',
'RuinsofAlphHoOhChamber': 'RuinsofAlphPuzzleChamber',
'RuinsofAlphKabutoChamber': 'RuinsofAlphPuzzleChamber',
'RuinsofAlphOmanyteChamber': 'RuinsofAlphPuzzleChamber',
'RuinsofAlphAerodactylChamber': 'RuinsofAlphPuzzleChamber',
'MahoganyMart1F': 'GiftShop',
'MountMoonGiftShop': 'GiftShop',
'SafariZoneMainOffice': 'OlivineCafe',
'SafariZoneWardensHome': 'PokemonFanClub',
'OlivinePortPassage': 'PortPassage',
'VermilionPortPassage': 'PortPassage',
'RuinsofAlphHoOhItemRoom': 'RuinsofAlphItemRoom',
'RuinsofAlphKabutoItemRoom': 'RuinsofAlphItemRoom',
'RuinsofAlphOmanyteItemRoom': 'RuinsofAlphItemRoom',
'RuinsofAlphAerodactylItemRoom': 'RuinsofAlphItemRoom',
'SafariZoneHubRestHouse': 'SafariZoneRestHouse',
'SafariZoneEastRestHouse': 'SafariZoneRestHouse',
'SafariZoneNorthRestHouse': 'SafariZoneRestHouse',
'SeagallopFerryVermilionGate': 'SeagallopFerryGate',
'SeagallopFerryNavelGate': 'SeagallopFerryGate',
}

if __name__ == '__main__':
	main()
