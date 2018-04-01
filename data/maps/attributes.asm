map_attributes: MACRO
; label, map, border block, connections
CURRENT_MAP_WIDTH = \2_WIDTH
CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_SecondMapHeader::
	db \3
	db \2_HEIGHT, \2_WIDTH
	db BANK(\1_BlockData)
	dw \1_BlockData
	db BANK(\1_MapScriptHeader)
	dw \1_MapScriptHeader
	db \4
ENDM

connection: MACRO
;\1: direction
;\2: map label
;\3: map id
;\4: x (east/west) or y (north/south)
;\5: offset?
;\6: strip length
if "\1" == "north"
	map_id \3
	dw \2_BlockData + \3_WIDTH * (\3_HEIGHT - 3) + \5
	dw OverworldMap + \4 + 3
	db \6
	db \3_WIDTH
	db \3_HEIGHT * 2 - 1
	db (\4 - \5) * -2
	dw OverworldMap + \3_HEIGHT * (\3_WIDTH + 6) + 1
elif "\1" == "south"
	map_id \3
	dw \2_BlockData + \5
	dw OverworldMap + (CURRENT_MAP_HEIGHT + 3) * (CURRENT_MAP_WIDTH + 6) + \4 + 3
	db \6
	db \3_WIDTH
	db 0
	db (\4 - \5) * -2
	dw OverworldMap + \3_WIDTH + 7
elif "\1" == "west"
	map_id \3
	dw \2_BlockData + (\3_WIDTH * \5) + \3_WIDTH - 3
	dw OverworldMap + (CURRENT_MAP_WIDTH + 6) * (\4 + 3)
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db \3_WIDTH * 2 - 1
	dw OverworldMap + \3_WIDTH * 2 + 6
elif "\1" == "east"
	map_id \3
	dw \2_BlockData + (\3_WIDTH * \5)
	dw OverworldMap + (CURRENT_MAP_WIDTH + 6) * (\4 + 3 + 1) - 3
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db 0
	dw OverworldMap + \3_WIDTH + 7
endc
ENDM


	map_attributes NewBarkTown, NEW_BARK_TOWN, $5, WEST | EAST
	connection west, Route29, ROUTE_29, 0, 0, 9
	connection east, Route27, ROUTE_27, 0, 0, 9

	map_attributes CherrygroveCity, CHERRYGROVE_CITY, $35, NORTH | WEST | EAST
	connection north, Route30, ROUTE_30, 5, 0, 10
	connection west, CherrygroveBay, CHERRYGROVE_BAY, -1, 14, 10
	connection east, Route29, ROUTE_29, 0, 0, 9

	map_attributes VioletCity, VIOLET_CITY, $5, NORTH | SOUTH | WEST | EAST
	connection north, VioletOutskirts, VIOLET_OUTSKIRTS, 0, 0, 20
	connection south, Route32, ROUTE_32, 0, 0, 10
	connection west, Route36, ROUTE_36, 0, -2, 9
	connection east, Route31, ROUTE_31, 11, 0, 9

	map_attributes AzaleaTown, AZALEA_TOWN, $5, WEST | EAST
	connection west, Route34, ROUTE_34, -3, 15, 12
	connection east, Route33, ROUTE_33, 0, 0, 9

	map_attributes CianwoodCity, CIANWOOD_CITY, $35, EAST
	connection east, Route41, ROUTE_41, 0, 0, 27

	map_attributes GoldenrodCity, GOLDENROD_CITY, $35, NORTH | SOUTH | EAST
	connection north, Route35, ROUTE_35, 5, 0, 12
	connection south, Route34, ROUTE_34, 7, 0, 10
	connection east, MagnetTunnelWest, MAGNET_TUNNEL_WEST, 0, 0, 11

	map_attributes OlivineCity, OLIVINE_CITY, $35, NORTH | SOUTH | WEST
	connection north, Route39, ROUTE_39, 5, 0, 10
	connection south, Route35Coast, ROUTE_35_COAST, 0, -7, 32
	connection west, Route40, ROUTE_40, 7, 0, 12

	map_attributes EcruteakCity, ECRUTEAK_CITY, $5, SOUTH | WEST | EAST
	connection south, Route37, ROUTE_37, 5, 0, 10
	connection west, Route38, ROUTE_38, 5, 0, 9
	connection east, Route42, ROUTE_42, 9, 0, 9

	map_attributes MahoganyTown, MAHOGANY_TOWN, $71, NORTH | WEST | EAST
	connection north, Route43, ROUTE_43, 0, 0, 10
	connection west, Route42, ROUTE_42, 0, 0, 9
	connection east, Route44, ROUTE_44, 0, 0, 9

	map_attributes LakeofRage, LAKE_OF_RAGE, $5, SOUTH
	connection south, Route43, ROUTE_43, 5, 0, 10

	map_attributes BlackthornCity, BLACKTHORN_CITY, $71, SOUTH
	connection south, Route45, ROUTE_45, -2, 0, 12

	map_attributes SilverCaveOutside, SILVER_CAVE_OUTSIDE, $71, EAST
	connection east, Route28, ROUTE_28, 6, 0, 9

	map_attributes Route26, ROUTE_26, $5, WEST
	connection west, Route27, ROUTE_27, 45, 0, 9

	map_attributes Route27, ROUTE_27, $35, WEST | EAST
	connection west, NewBarkTown, NEW_BARK_TOWN, 0, 0, 9
	connection east, Route26, ROUTE_26, -3, 42, 12

	map_attributes Route28, ROUTE_28, $71, WEST
	connection west, SilverCaveOutside, SILVER_CAVE_OUTSIDE, -3, 3, 12

	map_attributes Route29, ROUTE_29, $5, NORTH | WEST | EAST
	connection north, Route46, ROUTE_46, 10, 0, 10
	connection west, CherrygroveCity, CHERRYGROVE_CITY, 0, 0, 9
	connection east, NewBarkTown, NEW_BARK_TOWN, 0, 0, 9

	map_attributes Route30, ROUTE_30, $5, NORTH | SOUTH
	connection north, Route31, ROUTE_31, -3, 7, 13
	connection south, CherrygroveCity, CHERRYGROVE_CITY, -3, 2, 16

	map_attributes Route31, ROUTE_31, $5, SOUTH | WEST
	connection south, Route30, ROUTE_30, 10, 0, 10
	connection west, VioletCity, VIOLET_CITY, -2, 6, 12

	map_attributes Route32, ROUTE_32, $5, NORTH | SOUTH | WEST | EAST
	connection north, VioletCity, VIOLET_CITY, 0, 0, 13
	connection south, Route33, ROUTE_33, 0, 0, 10
	connection west, MagnetTunnelEast, MAGNET_TUNNEL_EAST, 9, 0, 11
	connection east, CherrygroveBay, CHERRYGROVE_BAY, 12, 0, 26

	map_attributes Route33, ROUTE_33, $5, NORTH | WEST
	connection north, Route32, ROUTE_32, 0, 0, 10
	connection west, AzaleaTown, AZALEA_TOWN, 0, 0, 9

	map_attributes Route34, ROUTE_34, $5, NORTH | WEST | EAST
	connection north, GoldenrodCity, GOLDENROD_CITY, -3, 4, 16
	connection west, Route34Coast, ROUTE_34_COAST, 0, 0, 27
	connection east, AzaleaTown, AZALEA_TOWN, 18, 0, 9

	map_attributes Route34Coast, ROUTE_34_COAST, $35, SOUTH | EAST
	connection south, StormyBeach, STORMY_BEACH, 0, 0, 9
	connection east, Route34, ROUTE_34, 0, 0, 27

	map_attributes StormyBeach, STORMY_BEACH, $35, NORTH
	connection north, Route34Coast, ROUTE_34_COAST, 0, 0, 9

	map_attributes Route35, ROUTE_35, $5, NORTH | SOUTH
	connection north, Route36, ROUTE_36, 0, 0, 14
	connection south, GoldenrodCity, GOLDENROD_CITY, -2, 3, 16

	map_attributes Route35Coast, ROUTE_35_COAST, $35, NORTH | SOUTH
	connection north, OlivineCity, OLIVINE_CITY, 0, 7, 32
	connection south, GoldenrodHarbor, GOLDENROD_HARBOR, 0, 0, 24

	map_attributes Route36, ROUTE_36, $5, NORTH | SOUTH | EAST
	connection north, Route37, ROUTE_37, 12, 0, 10
	connection south, Route35, ROUTE_35, 0, 0, 12
	connection east, VioletCity, VIOLET_CITY, -2, 0, 12

	map_attributes Route37, ROUTE_37, $5, NORTH | SOUTH
	connection north, EcruteakCity, ECRUTEAK_CITY, -3, 2, 16
	connection south, Route36, ROUTE_36, -3, 9, 16

	map_attributes Route38, ROUTE_38, $5, WEST | EAST
	connection west, Route39, ROUTE_39, 0, 0, 12
	connection east, EcruteakCity, ECRUTEAK_CITY, -3, 2, 15

	map_attributes Route39, ROUTE_39, $5, SOUTH | EAST
	connection south, OlivineCity, OLIVINE_CITY, -3, 2, 16
	connection east, Route38, ROUTE_38, 0, 0, 9

	map_attributes Route40, ROUTE_40, $35, SOUTH | EAST
	connection south, Route41, ROUTE_41, -3, 12, 13
	connection east, OlivineCity, OLIVINE_CITY, -3, 4, 12

	map_attributes Route41, ROUTE_41, $35, NORTH | WEST | EAST
	connection north, Route40, ROUTE_40, 15, 0, 10
	connection west, CianwoodCity, CIANWOOD_CITY, 0, 0, 27
	connection east, GoldenrodHarbor, GOLDENROD_HARBOR, 3, 0, 20

	map_attributes Route42, ROUTE_42, $5, SOUTH | WEST | EAST
	connection south, VioletOutskirts, VIOLET_OUTSKIRTS, 5, 0, 14
	connection west, EcruteakCity, ECRUTEAK_CITY, -3, 6, 12
	connection east, MahoganyTown, MAHOGANY_TOWN, 0, 0, 9

	map_attributes Route43, ROUTE_43, $5, NORTH | SOUTH
	connection north, LakeofRage, LAKE_OF_RAGE, -3, 2, 16
	connection south, MahoganyTown, MAHOGANY_TOWN, 0, 0, 10

	map_attributes Route44, ROUTE_44, $71, WEST
	connection west, MahoganyTown, MAHOGANY_TOWN, 0, 0, 9

	map_attributes Route45, ROUTE_45, $71, NORTH | WEST
	connection north, BlackthornCity, BLACKTHORN_CITY, 1, -1, 12
	connection west, Route46, ROUTE_46, 37, 0, 12

	map_attributes Route46, ROUTE_46, $5, SOUTH | EAST
	connection south, Route29, ROUTE_29, -3, 7, 16
	connection east, Route45, ROUTE_45, -3, 34, 12

	map_attributes PewterCity, PEWTER_CITY, $f, SOUTH | EAST
	connection south, Route2North, ROUTE_2_NORTH, 5, 0, 10
	connection east, Route3, ROUTE_3, 5, 0, 9

	map_attributes Route2North, ROUTE_2_NORTH, $f, NORTH | SOUTH
	connection north, PewterCity, PEWTER_CITY, -3, 2, 16
	connection south, Route2South, ROUTE_2_SOUTH, 0, 0, 10

	map_attributes Route2South, ROUTE_2_SOUTH, $f, NORTH | SOUTH | EAST
	connection north, Route2North, ROUTE_2_NORTH, 0, 0, 10
	connection south, ViridianCity, VIRIDIAN_CITY, -3, 2, 16
	connection east, Route16West, ROUTE_16_WEST, 8, 0, 10

	map_attributes ViridianCity, VIRIDIAN_CITY, $f, NORTH | SOUTH | WEST
	connection north, Route2South, ROUTE_2_SOUTH, 5, 0, 10
	connection south, Route1, ROUTE_1, 9, 0, 10
	connection west, Route22, ROUTE_22, 4, 0, 9

	map_attributes Route22, ROUTE_22, $2c, EAST
	connection east, ViridianCity, VIRIDIAN_CITY, -3, 1, 15

	map_attributes Route1, ROUTE_1, $f, NORTH | SOUTH
	connection north, ViridianCity, VIRIDIAN_CITY, -3, 6, 13
	connection south, PalletTown, PALLET_TOWN, 1, 0, 10

	map_attributes PalletTown, PALLET_TOWN, $f, NORTH | SOUTH
	connection north, Route1, ROUTE_1, -1, 0, 10
	connection south, Route21, ROUTE_21, 0, 0, 10

	map_attributes Route21, ROUTE_21, $43, NORTH | SOUTH | EAST
	connection north, PalletTown, PALLET_TOWN, 0, 0, 10
	connection south, CinnabarIsland, CINNABAR_ISLAND, 0, 0, 10
	connection east, UragaChannelWest, URAGA_CHANNEL_WEST, 19, 0, 15

	map_attributes CinnabarIsland, CINNABAR_ISLAND, $43, NORTH | EAST
	connection north, Route21, ROUTE_21, 0, 0, 10
	connection east, Route20, ROUTE_20, 2, 0, 9

	map_attributes Route20, ROUTE_20, $43, WEST | EAST
	connection west, CinnabarIsland, CINNABAR_ISLAND, -2, 0, 11
	connection east, Route19, ROUTE_19, -3, 17, 12

	map_attributes Route19, ROUTE_19, $43, NORTH | WEST
	connection north, FuchsiaCity, FUCHSIA_CITY, 0, 0, 13
	connection west, Route20, ROUTE_20, 20, 0, 9

	map_attributes FuchsiaCity, FUCHSIA_CITY, $f, SOUTH | WEST | EAST
	connection south, Route19, ROUTE_19, 0, 0, 10
	connection west, Route18East, ROUTE_18_EAST, 7, 0, 11
	connection east, Route15, ROUTE_15, 9, 0, 9

	map_attributes Route18East, ROUTE_18_EAST, $43, WEST | EAST
	connection west, Route18West, ROUTE_18_WEST, 0, 0, 11
	connection east, FuchsiaCity, FUCHSIA_CITY, -3, 4, 14

	map_attributes Route18West, ROUTE_18_WEST, $43, NORTH | WEST | EAST
	connection north, Route17, ROUTE_17, 0, 0, 10
	connection west, UragaChannelEast, URAGA_CHANNEL_EAST, 0, 0, 9
	connection east, Route18East, ROUTE_18_EAST, 0, 0, 11

	map_attributes UragaChannelEast, URAGA_CHANNEL_EAST, $43, WEST | EAST
	connection west, UragaChannelWest, URAGA_CHANNEL_WEST, 0, 0, 9
	connection east, Route18West, ROUTE_18_WEST, 0, 0, 9

	map_attributes UragaChannelWest, URAGA_CHANNEL_WEST, $43, WEST | EAST
	connection west, Route21, ROUTE_21, -3, 16, 15
	connection east, UragaChannelEast, URAGA_CHANNEL_EAST, 0, 0, 9

	map_attributes Route17, ROUTE_17, $43, NORTH | SOUTH
	connection north, Route16South, ROUTE_16_SOUTH, 0, 0, 10
	connection south, Route18West, ROUTE_18_WEST, 0, 0, 10

	map_attributes Route16South, ROUTE_16_SOUTH, $f, SOUTH
	connection south, Route17, ROUTE_17, 0, 0, 10

	map_attributes Route16Northeast, ROUTE_16_NORTHEAST, $f, WEST | EAST
	connection west, Route16West, ROUTE_16_WEST, 0, 0, 11
	connection east, CeladonCity, CELADON_CITY, -3, 7, 10

	map_attributes Route16Northwest, ROUTE_16_NORTHWEST, $f, WEST | EAST
	connection west, Route16West, ROUTE_16_WEST, 0, 0, 11
	connection east, CeladonCity, CELADON_CITY, -3, 7, 10

	map_attributes Route16West, ROUTE_16_WEST, $f, WEST | EAST
	connection west, Route2South, ROUTE_2_SOUTH, -3, 5, 10
	connection east, Route16Northwest, ROUTE_16_NORTHWEST, 0, 0, 11

	map_attributes CeladonCity, CELADON_CITY, $f, WEST | EAST
	connection west, Route16Northeast, ROUTE_16_NORTHEAST, 10, 0, 8
	connection east, Route7, ROUTE_7, 5, 0, 9

	map_attributes Route7, ROUTE_7, $f, NORTH | WEST | EAST
	connection north, CeladonOutskirts, CELADON_OUTSKIRTS, 0, 0, 10
	connection west, CeladonCity, CELADON_CITY, -3, 2, 15
	connection east, SaffronCity, SAFFRON_CITY, -3, 3, 12

	map_attributes LuckyIsland, LUCKY_ISLAND, $43, NORTH | WEST
	connection north, Route13East, ROUTE_13_EAST, 0, 0, 23
	connection west, Route14, ROUTE_14, 0, 0, 17

	map_attributes Route15, ROUTE_15, $f, WEST | EAST
	connection west, FuchsiaCity, FUCHSIA_CITY, -3, 6, 12
	connection east, Route14, ROUTE_14, -3, 7, 12

	map_attributes Route14, ROUTE_14, $43, NORTH | WEST | EAST
	connection north, Route13West, ROUTE_13_WEST, 0, 0, 12
	connection west, Route15, ROUTE_15, 10, 0, 9
	connection east, LuckyIsland, LUCKY_ISLAND, 0, 0, 15

	map_attributes Route13East, ROUTE_13_EAST, $43, NORTH | SOUTH | WEST
	connection north, Route12South, ROUTE_12_SOUTH, 13, 0, 10
	connection south, LuckyIsland, LUCKY_ISLAND, 0, 0, 23
	connection west, Route13West, ROUTE_13_WEST, 0, 0, 10

	map_attributes Route13West, ROUTE_13_WEST, $43, SOUTH | EAST
	connection south, Route14, ROUTE_14, 0, 0, 12
	connection east, Route13East, ROUTE_13_EAST, 0, 0, 10

	map_attributes Route12North, ROUTE_12_NORTH, $43, NORTH | SOUTH
	connection north, LavenderTown, LAVENDER_TOWN, 0, 0, 10
	connection south, Route12South, ROUTE_12_SOUTH, 0, 0, 10

	map_attributes Route12South, ROUTE_12_SOUTH, $43, NORTH | SOUTH | WEST
	connection north, Route12North, ROUTE_12_NORTH, 0, 0, 10
	connection south, Route13East, ROUTE_13_EAST, 0, 13, 10
	connection west, Route11, ROUTE_11, 17, 0, 9

	map_attributes Route11, ROUTE_11, $f, WEST | EAST
	connection west, VermilionCity, VERMILION_CITY, -3, 2, 15
	connection east, Route12South, ROUTE_12_SOUTH, -3, 14, 15

	map_attributes LavenderTown, LAVENDER_TOWN, $2c, NORTH | SOUTH | WEST
	connection north, Route10South, ROUTE_10_SOUTH, 0, 0, 10
	connection south, Route12North, ROUTE_12_NORTH, 0, 0, 10
	connection west, Route8, ROUTE_8, 0, 0, 11

	map_attributes VermilionCity, VERMILION_CITY, $43, NORTH | EAST
	connection north, Route6, ROUTE_6, 3, 0, 15
	connection east, Route11, ROUTE_11, 5, 0, 9

	map_attributes Route6, ROUTE_6, $f, NORTH | SOUTH
	connection north, SaffronCity, SAFFRON_CITY, -3, 0, 18
	connection south, VermilionCity, VERMILION_CITY, -3, 0, 18

	map_attributes SaffronCity, SAFFRON_CITY, $f, NORTH | SOUTH | WEST | EAST
	connection north, Route5, ROUTE_5, 5, 0, 10
	connection south, Route6, ROUTE_6, 3, 0, 15
	connection west, Route7, ROUTE_7, 6, 0, 9
	connection east, Route8, ROUTE_8, 4, 0, 11

	map_attributes Route5, ROUTE_5, $f, NORTH | SOUTH
	connection north, CeruleanCity, CERULEAN_CITY, -3, 2, 16
	connection south, SaffronCity, SAFFRON_CITY, -3, 2, 16

	map_attributes CeruleanCity, CERULEAN_CITY, $f, NORTH | SOUTH | WEST | EAST
	connection north, Route24, ROUTE_24, 0, 0, 14
	connection south, Route5, ROUTE_5, 5, 0, 10
	connection west, Route4, ROUTE_4, 2, 0, 10
	connection east, Route9, ROUTE_9, 4, 0, 9

	map_attributes Route24, ROUTE_24, $2c, SOUTH | EAST
	connection south, CeruleanCity, CERULEAN_CITY, 0, 0, 14
	connection east, Route25, ROUTE_25, 0, 0, 21

	map_attributes Route25, ROUTE_25, $2c, WEST | EAST
	connection west, Route24, ROUTE_24, 0, 0, 20
	connection east, CeruleanCape, CERULEAN_CAPE, 0, 0, 19

	map_attributes CeruleanCape, CERULEAN_CAPE, $2c, WEST
	connection west, Route25, ROUTE_25, 0, 0, 20

	map_attributes Route3, ROUTE_3, $2c, WEST
	connection west, PewterCity, PEWTER_CITY, -3, 2, 15

	map_attributes Route4, ROUTE_4, $2c, EAST
	connection east, CeruleanCity, CERULEAN_CITY, -2, 0, 16

	map_attributes Route8, ROUTE_8, $2c, WEST | EAST
	connection west, SaffronCity, SAFFRON_CITY, -2, 2, 14
	connection east, LavenderTown, LAVENDER_TOWN, 0, 0, 10

	map_attributes Route9, ROUTE_9, $2c, WEST | EAST
	connection west, CeruleanCity, CERULEAN_CITY, -3, 1, 12
	connection east, Route10North, ROUTE_10_NORTH, 0, 6, 12

	map_attributes Route10North, ROUTE_10_NORTH, $2c, SOUTH | WEST
	connection south, Route10South, ROUTE_10_SOUTH, 0, 0, 10
	connection west, Route9, ROUTE_9, 6, 0, 12

	map_attributes Route10South, ROUTE_10_SOUTH, $2c, NORTH | SOUTH
	connection north, Route10North, ROUTE_10_NORTH, 0, 0, 10
	connection south, LavenderTown, LAVENDER_TOWN, 0, 0, 10

	map_attributes Route47, ROUTE_47, $35, NORTH
	connection north, Route48, ROUTE_48, 0, 0, 36

	map_attributes Route48, ROUTE_48, $35, SOUTH
	connection south, Route47, ROUTE_47, 0, 0, 36

	map_attributes CherrygroveBay, CHERRYGROVE_BAY, $35, SOUTH | WEST | EAST
	connection south, Route32Coast, ROUTE_32_COAST, 0, 0, 15
	connection west, Route32, ROUTE_32, -2, 10, 26
	connection east, CherrygroveCity, CHERRYGROVE_CITY, 15, 0, 10

	map_attributes Route32Coast, ROUTE_32_COAST, $35, NORTH
	connection north, CherrygroveBay, CHERRYGROVE_BAY, 0, 0, 15

	map_attributes VioletOutskirts, VIOLET_OUTSKIRTS, $5, NORTH | SOUTH
	connection north, Route42, ROUTE_42, -3, 2, 20
	connection south, VioletCity, VIOLET_CITY, 0, 0, 20

	map_attributes RuinsofAlphOutside, RUINS_OF_ALPH_OUTSIDE, $5, SOUTH
	connection south, MagnetTunnelEast, MAGNET_TUNNEL_EAST, -2, 0, 10

	map_attributes GoldenrodHarbor, GOLDENROD_HARBOR, $35, NORTH | WEST
	connection north, Route35Coast, ROUTE_35_COAST, 0, 0, 24
	connection west, Route41, ROUTE_41, -3, 0, 20

	map_attributes MagnetTunnelEast, MAGNET_TUNNEL_EAST, $5, NORTH | EAST
	connection north, RuinsofAlphOutside, RUINS_OF_ALPH_OUTSIDE, 2, 0, 11
	connection east, Route32, ROUTE_32, -1, 8, 13

	map_attributes MagnetTunnelWest, MAGNET_TUNNEL_WEST, $5, WEST
	connection west, GoldenrodCity, GOLDENROD_CITY, 0, 0, 11

	map_attributes CeladonOutskirts, CELADON_OUTSKIRTS, $f, SOUTH
	connection south, Route7, ROUTE_7, 0, 0, 10

	map_attributes Route23, ROUTE_23, $f, NORTH
	connection north, IndigoPlateau, INDIGO_PLATEAU, 0, 0, 10

	map_attributes IndigoPlateau, INDIGO_PLATEAU, $2c, SOUTH
	connection south, Route23, ROUTE_23, 0, 0, 10

	map_attributes ShamoutiIsland, SHAMOUTI_ISLAND, $35, NORTH | EAST
	connection north, RockyBeach, ROCKY_BEACH, 0, 0, 18
	connection east, BeautifulBeach, BEAUTIFUL_BEACH, 0, 0, 15

	map_attributes BeautifulBeach, BEAUTIFUL_BEACH, $35, WEST
	connection west, ShamoutiIsland, SHAMOUTI_ISLAND, 0, 0, 15

	map_attributes WarmBeach, WARM_BEACH, $35, SOUTH
	connection south, ShamoutiCoast, SHAMOUTI_COAST, 0, 0, 12

	map_attributes ShamoutiCoast, SHAMOUTI_COAST, $35, NORTH
	connection north, WarmBeach, WARM_BEACH, 0, 0, 12

	map_attributes RockyBeach, ROCKY_BEACH, $35, SOUTH
	connection south, ShamoutiIsland, SHAMOUTI_ISLAND, 0, 0, 18

	map_attributes ValenciaIsland, VALENCIA_ISLAND, $0, WEST
	connection west, Route49, ROUTE_49, 0, 2, 9

	map_attributes Route49, ROUTE_49, $0, EAST
	connection east, ValenciaIsland, VALENCIA_ISLAND, 2, 0, 9

	map_attributes SproutTower1F, SPROUT_TOWER_1F, $0, 0
	map_attributes SproutTower2F, SPROUT_TOWER_2F, $0, 0
	map_attributes SproutTower3F, SPROUT_TOWER_3F, $0, 0
	map_attributes TinTower1F, TIN_TOWER_1F, $0, 0
	map_attributes TinTower2F, TIN_TOWER_2F, $0, 0
	map_attributes TinTower3F, TIN_TOWER_3F, $0, 0
	map_attributes TinTower4F, TIN_TOWER_4F, $0, 0
	map_attributes TinTower5F, TIN_TOWER_5F, $0, 0
	map_attributes TinTower6F, TIN_TOWER_6F, $0, 0
	map_attributes TinTower7F, TIN_TOWER_7F, $0, 0
	map_attributes TinTower8F, TIN_TOWER_8F, $0, 0
	map_attributes TinTower9F, TIN_TOWER_9F, $0, 0
	map_attributes TinTower10F, TIN_TOWER_10F, $0, 0
	map_attributes BurnedTower1F, BURNED_TOWER_1F, $0, 0
	map_attributes BurnedTowerB1F, BURNED_TOWER_B1F, $9, 0
	map_attributes NationalPark, NATIONAL_PARK, $0, 0
	map_attributes NationalParkBugContest, NATIONAL_PARK_BUG_CONTEST, $0, 0
	map_attributes RadioTower1F, RADIO_TOWER_1F, $0, 0
	map_attributes RadioTower2F, RADIO_TOWER_2F, $0, 0
	map_attributes RadioTower3F, RADIO_TOWER_3F, $0, 0
	map_attributes RadioTower4F, RADIO_TOWER_4F, $0, 0
	map_attributes RadioTower5F, RADIO_TOWER_5F, $0, 0
	map_attributes RuinsofAlphHoOhChamber, RUINS_OF_ALPH_HO_OH_CHAMBER, $0, 0
	map_attributes RuinsofAlphKabutoChamber, RUINS_OF_ALPH_KABUTO_CHAMBER, $0, 0
	map_attributes RuinsofAlphOmanyteChamber, RUINS_OF_ALPH_OMANYTE_CHAMBER, $0, 0
	map_attributes RuinsofAlphAerodactylChamber, RUINS_OF_ALPH_AERODACTYL_CHAMBER, $0, 0
	map_attributes RuinsofAlphEntranceChamber, RUINS_OF_ALPH_ENTRANCE_CHAMBER, $0, 0
	map_attributes RuinsofAlphInnerChamber, RUINS_OF_ALPH_INNER_CHAMBER, $0, 0
	map_attributes RuinsofAlphResearchCenter, RUINS_OF_ALPH_RESEARCH_CENTER, $0, 0
	map_attributes RuinsofAlphHoOhItemRoom, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, $0, 0
	map_attributes RuinsofAlphKabutoItemRoom, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, $0, 0
	map_attributes RuinsofAlphOmanyteItemRoom, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, $0, 0
	map_attributes RuinsofAlphAerodactylItemRoom, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, $0, 0
	map_attributes RuinsofAlphHoOhWordRoom, RUINS_OF_ALPH_HO_OH_WORD_ROOM, $0, 0
	map_attributes RuinsofAlphKabutoWordRoom, RUINS_OF_ALPH_KABUTO_WORD_ROOM, $0, 0
	map_attributes RuinsofAlphOmanyteWordRoom, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, $0, 0
	map_attributes RuinsofAlphAerodactylWordRoom, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, $0, 0
	map_attributes RuinsofAlphSinjohChamber, RUINS_OF_ALPH_SINJOH_CHAMBER, $0, 0
	map_attributes Route22Past, ROUTE_22_PAST, $2c, 0
	map_attributes UnionCave1F, UNION_CAVE_1F, $9, 0
	map_attributes UnionCaveB1FNorth, UNION_CAVE_B1F_NORTH, $9, 0
	map_attributes UnionCaveB1FSouth, UNION_CAVE_B1F_SOUTH, $9, 0
	map_attributes UnionCaveB2F, UNION_CAVE_B2F, $9, 0
	map_attributes SlowpokeWellB1F, SLOWPOKE_WELL_B1F, $9, 0
	map_attributes SlowpokeWellB2F, SLOWPOKE_WELL_B2F, $9, 0
	map_attributes OlivineLighthouse1F, OLIVINE_LIGHTHOUSE_1F, $0, 0
	map_attributes OlivineLighthouse2F, OLIVINE_LIGHTHOUSE_2F, $0, 0
	map_attributes OlivineLighthouse3F, OLIVINE_LIGHTHOUSE_3F, $0, 0
	map_attributes OlivineLighthouse4F, OLIVINE_LIGHTHOUSE_4F, $0, 0
	map_attributes OlivineLighthouse5F, OLIVINE_LIGHTHOUSE_5F, $0, 0
	map_attributes OlivineLighthouse6F, OLIVINE_LIGHTHOUSE_6F, $0, 0
	map_attributes OlivineLighthouseRoof, OLIVINE_LIGHTHOUSE_ROOF, $c, 0
	map_attributes MahoganyMart1F, MAHOGANY_MART_1F, $0, 0
	map_attributes TeamRocketBaseB1F, TEAM_ROCKET_BASE_B1F, $0, 0
	map_attributes TeamRocketBaseB2F, TEAM_ROCKET_BASE_B2F, $0, 0
	map_attributes TeamRocketBaseB3F, TEAM_ROCKET_BASE_B3F, $0, 0
	map_attributes IlexForest, ILEX_FOREST, $35, 0
	map_attributes MurkySwamp, MURKY_SWAMP, $35, 0
	map_attributes MagnetTunnelInside, MAGNET_TUNNEL_INSIDE, $9, 0
	map_attributes WarehouseEntrance, WAREHOUSE_ENTRANCE, $0, 0
	map_attributes UndergroundPathSwitchRoomEntrances, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, $0, 0
	map_attributes GoldenrodDeptStoreB1F, GOLDENROD_DEPT_STORE_B1F, $0, 0
	map_attributes UndergroundWarehouse, UNDERGROUND_WAREHOUSE, $0, 0
	map_attributes MountMortar1FOutside, MOUNT_MORTAR_1F_OUTSIDE, $9, 0
	map_attributes MountMortar1FInside, MOUNT_MORTAR_1F_INSIDE, $9, 0
	map_attributes MountMortar2FInside, MOUNT_MORTAR_2F_INSIDE, $9, 0
	map_attributes MountMortarB1F, MOUNT_MORTAR_B1F, $9, 0
	map_attributes IcePath1F, ICE_PATH_1F, $9, 0
	map_attributes IcePathB1F, ICE_PATH_B1F, $19, 0
	map_attributes IcePathB2FMahoganySide, ICE_PATH_B2F_MAHOGANY_SIDE, $19, 0
	map_attributes IcePathB2FBlackthornSide, ICE_PATH_B2F_BLACKTHORN_SIDE, $19, 0
	map_attributes IcePathB3F, ICE_PATH_B3F, $19, 0
	map_attributes WhirlIslandNW, WHIRL_ISLAND_NW, $9, 0
	map_attributes WhirlIslandNE, WHIRL_ISLAND_NE, $9, 0
	map_attributes WhirlIslandSW, WHIRL_ISLAND_SW, $9, 0
	map_attributes WhirlIslandCave, WHIRL_ISLAND_CAVE, $9, 0
	map_attributes WhirlIslandSE, WHIRL_ISLAND_SE, $f, 0
	map_attributes WhirlIslandB1F, WHIRL_ISLAND_B1F, $9, 0
	map_attributes WhirlIslandB2F, WHIRL_ISLAND_B2F, $2e, 0
	map_attributes WhirlIslandLugiaChamber, WHIRL_ISLAND_LUGIA_CHAMBER, $f, 0
	map_attributes SilverCaveRoom1, SILVER_CAVE_ROOM_1, $9, 0
	map_attributes SilverCaveRoom2, SILVER_CAVE_ROOM_2, $9, 0
	map_attributes SilverCaveRoom3, SILVER_CAVE_ROOM_3, $0, 0
	map_attributes SilverCaveItemRooms, SILVER_CAVE_ITEM_ROOMS, $9, 0
	map_attributes DarkCaveVioletEntrance, DARK_CAVE_VIOLET_ENTRANCE, $9, 0
	map_attributes DarkCaveBlackthornEntrance, DARK_CAVE_BLACKTHORN_ENTRANCE, $9, 0
	map_attributes DragonsDen1F, DRAGONS_DEN_1F, $9, 0
	map_attributes DragonsDenB1F, DRAGONS_DEN_B1F, $71, 0
	map_attributes DragonShrine, DRAGON_SHRINE, $0, 0
	map_attributes TohjoFalls, TOHJO_FALLS, $9, 0
	map_attributes GiovannisCave, GIOVANNIS_CAVE, $9, 0
	map_attributes OlivinePokeCenter1F, OLIVINE_POKECENTER_1F, $0, 0
	map_attributes OlivineGym, OLIVINE_GYM, $0, 0
	map_attributes OlivineTimsHouse, OLIVINE_TIMS_HOUSE, $0, 0
	map_attributes OlivinePunishmentSpeechHouse, OLIVINE_PUNISHMENT_SPEECH_HOUSE, $0, 0
	map_attributes OlivineGoodRodHouse, OLIVINE_GOOD_ROD_HOUSE, $0, 0
	map_attributes OlivineCafe, OLIVINE_CAFE, $0, 0
	map_attributes OlivineMart, OLIVINE_MART, $0, 0
	map_attributes Route38EcruteakGate, ROUTE_38_ECRUTEAK_GATE, $0, 0
	map_attributes Route39Barn, ROUTE_39_BARN, $0, 0
	map_attributes Route39Farmhouse, ROUTE_39_FARMHOUSE, $0, 0
	map_attributes MahoganyRedGyaradosSpeechHouse, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, $0, 0
	map_attributes MahoganyGym, MAHOGANY_GYM, $0, 0
	map_attributes MahoganyPokeCenter1F, MAHOGANY_POKECENTER_1F, $0, 0
	map_attributes Route42EcruteakGate, ROUTE_42_ECRUTEAK_GATE, $0, 0
	map_attributes DiglettsCave, DIGLETTS_CAVE, $9, 0
	map_attributes MountMoon1F, MOUNT_MOON_1F, $9, 0
	map_attributes MountMoonB1F, MOUNT_MOON_B1F, $9, 0
	map_attributes MountMoonB2F, MOUNT_MOON_B2F, $9, 0
	map_attributes Underground, UNDERGROUND, $0, 0
	map_attributes RockTunnel1F, ROCK_TUNNEL_1F, $9, 0
	map_attributes RockTunnelB1F, ROCK_TUNNEL_B1F, $9, 0
	map_attributes RockTunnel2F, ROCK_TUNNEL_2F, $9, 0
	map_attributes VictoryRoad1F, VICTORY_ROAD_1F, $9, 0
	map_attributes VictoryRoad2F, VICTORY_ROAD_2F, $9, 0
	map_attributes VictoryRoad3F, VICTORY_ROAD_3F, $9, 0
	map_attributes EcruteakHouse, ECRUTEAK_HOUSE, $0, 0
	map_attributes WiseTriosRoom, WISE_TRIOS_ROOM, $0, 0
	map_attributes EcruteakPokeCenter1F, ECRUTEAK_POKECENTER_1F, $0, 0
	map_attributes EcruteakLugiaSpeechHouse, ECRUTEAK_LUGIA_SPEECH_HOUSE, $0, 0
	map_attributes DanceTheatre, DANCE_THEATRE, $0, 0
	map_attributes EcruteakMart, ECRUTEAK_MART, $0, 0
	map_attributes EcruteakGym, ECRUTEAK_GYM, $0, 0
	map_attributes EcruteakItemfinderHouse, ECRUTEAK_ITEMFINDER_HOUSE, $0, 0
	map_attributes ValeriesHouse, VALERIES_HOUSE, $0, 0
	map_attributes EcruteakCherishBallHouse, ECRUTEAK_CHERISH_BALL_HOUSE, $0, 0
	map_attributes EcruteakDestinyKnotHouse, ECRUTEAK_DESTINY_KNOT_HOUSE, $0, 0
	map_attributes EcruteakShrineOutside, ECRUTEAK_SHRINE_OUTSIDE, $5, 0
	map_attributes EcruteakShrineInside, ECRUTEAK_SHRINE_INSIDE, $0, 0
	map_attributes BlackthornGym1F, BLACKTHORN_GYM_1F, $0, 0
	map_attributes BlackthornGym2F, BLACKTHORN_GYM_2F, $0, 0
	map_attributes BlackthornDragonSpeechHouse, BLACKTHORN_DRAGON_SPEECH_HOUSE, $0, 0
	map_attributes BlackthornEmysHouse, BLACKTHORN_EMYS_HOUSE, $0, 0
	map_attributes BlackthornMart, BLACKTHORN_MART, $0, 0
	map_attributes BlackthornPokeCenter1F, BLACKTHORN_POKECENTER_1F, $0, 0
	map_attributes MoveDeletersHouse, MOVE_DELETERS_HOUSE, $0, 0
	map_attributes CinnabarPokeCenter1F, CINNABAR_POKECENTER_1F, $0, 0
	map_attributes Route19FuchsiaGate, ROUTE_19_FUCHSIA_GATE, $0, 0
	map_attributes SeafoamIslands1F, SEAFOAM_ISLANDS_1F, $9, 0
	map_attributes SeafoamGym, SEAFOAM_GYM, $9, 0
	map_attributes SeafoamIslandsB1F, SEAFOAM_ISLANDS_B1F, $9, 0
	map_attributes SeafoamIslandsB2F, SEAFOAM_ISLANDS_B2F, $9, 0
	map_attributes SeafoamIslandsB3F, SEAFOAM_ISLANDS_B3F, $9, 0
	map_attributes SeafoamIslandsB4F, SEAFOAM_ISLANDS_B4F, $9, 0
	map_attributes CeruleanGymBadgeSpeechHouse, CERULEAN_GYM_BADGE_SPEECH_HOUSE, $0, 0
	map_attributes CeruleanPoliceStation, CERULEAN_POLICE_STATION, $0, 0
	map_attributes CeruleanTradeSpeechHouse, CERULEAN_TRADE_SPEECH_HOUSE, $0, 0
	map_attributes CeruleanPokeCenter1F, CERULEAN_POKECENTER_1F, $0, 0
	map_attributes CeruleanGym, CERULEAN_GYM, $0, 0
	map_attributes CeruleanMart, CERULEAN_MART, $0, 0
	map_attributes CeruleanBikeShop, CERULEAN_BIKE_SHOP, $0, 0
	map_attributes CeruleanBerryPowderHouse, CERULEAN_BERRY_POWDER_HOUSE, $0, 0
	map_attributes CeruleanCoupleHouse, CERULEAN_COUPLE_HOUSE, $0, 0
	map_attributes CeruleanWaterShowSpeechHouse, CERULEAN_WATER_SHOW_SPEECH_HOUSE, $0, 0
	map_attributes Route3PokeCenter1F, ROUTE_3_POKECENTER_1F, $0, 0
	map_attributes Route10PokeCenter1F, ROUTE_10_POKECENTER_1F, $0, 0
	map_attributes PowerPlant, POWER_PLANT, $0, 0
	map_attributes BillsHouse, BILLS_HOUSE, $0, 0
	map_attributes AzaleaPokeCenter1F, AZALEA_POKECENTER_1F, $0, 0
	map_attributes CharcoalKiln, CHARCOAL_KILN, $0, 0
	map_attributes AzaleaMart, AZALEA_MART, $0, 0
	map_attributes KurtsHouse, KURTS_HOUSE, $0, 0
	map_attributes AzaleaGym, AZALEA_GYM, $0, 0
	map_attributes LakeofRageHiddenPowerHouse, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, $0, 0
	map_attributes LakeofRageMagikarpHouse, LAKE_OF_RAGE_MAGIKARP_HOUSE, $0, 0
	map_attributes Route43MahoganyGate, ROUTE_43_MAHOGANY_GATE, $0, 0
	map_attributes Route43Gate, ROUTE_43_GATE, $0, 0
	map_attributes SinjohRuins, SINJOH_RUINS, $d5, 0
	map_attributes SinjohRuinsHouse, SINJOH_RUINS_HOUSE, $0, 0
	map_attributes MystriStage, MYSTRI_STAGE, $0, 0
	map_attributes EmbeddedTower, EMBEDDED_TOWER, $0, 0
	map_attributes VioletMart, VIOLET_MART, $0, 0
	map_attributes VioletGym, VIOLET_GYM, $0, 0
	map_attributes EarlsPokemonAcademy, EARLS_POKEMON_ACADEMY, $0, 0
	map_attributes VioletNicknameSpeechHouse, VIOLET_NICKNAME_SPEECH_HOUSE, $0, 0
	map_attributes VioletPokeCenter1F, VIOLET_POKECENTER_1F, $0, 0
	map_attributes VioletOnixTradeHouse, VIOLET_ONIX_TRADE_HOUSE, $0, 0
	map_attributes Route32RuinsofAlphGate, ROUTE_32_RUINS_OF_ALPH_GATE, $0, 0
	map_attributes Route32PokeCenter1F, ROUTE_32_POKECENTER_1F, $0, 0
	map_attributes Route32CoastHouse, ROUTE_32_COAST_HOUSE, $0, 0
	map_attributes Route35GoldenrodGate, ROUTE_35_GOLDENROD_GATE, $0, 0
	map_attributes Route35NationalParkGate, ROUTE_35_NATIONAL_PARK_GATE, $0, 0
	map_attributes Route36RuinsofAlphGate, ROUTE_36_RUINS_OF_ALPH_GATE, $0, 0
	map_attributes Route36NationalParkGate, ROUTE_36_NATIONAL_PARK_GATE, $0, 0
	map_attributes Route36VioletGate, ROUTE_36_VIOLET_GATE, $0, 0
	map_attributes GoldenrodGym, GOLDENROD_GYM, $0, 0
	map_attributes GoldenrodBikeShop, GOLDENROD_BIKE_SHOP, $0, 0
	map_attributes GoldenrodHappinessRater, GOLDENROD_HAPPINESS_RATER, $0, 0
	map_attributes GoldenrodBillsHouse, GOLDENROD_BILLS_HOUSE, $0, 0
	map_attributes GoldenrodMagnetTrainStation, GOLDENROD_MAGNET_TRAIN_STATION, $0, 0
	map_attributes GoldenrodFlowerShop, GOLDENROD_FLOWER_SHOP, $0, 0
	map_attributes GoldenrodPPSpeechHouse, GOLDENROD_PP_SPEECH_HOUSE, $0, 0
	map_attributes GoldenrodNameRater, GOLDENROD_NAME_RATER, $0, 0
	map_attributes GoldenrodDeptStore1F, GOLDENROD_DEPT_STORE_1F, $0, 0
	map_attributes GoldenrodDeptStore2F, GOLDENROD_DEPT_STORE_2F, $0, 0
	map_attributes GoldenrodDeptStore3F, GOLDENROD_DEPT_STORE_3F, $0, 0
	map_attributes GoldenrodDeptStore4F, GOLDENROD_DEPT_STORE_4F, $0, 0
	map_attributes GoldenrodDeptStore5F, GOLDENROD_DEPT_STORE_5F, $0, 0
	map_attributes GoldenrodDeptStore6F, GOLDENROD_DEPT_STORE_6F, $0, 0
	map_attributes GoldenrodDeptStoreElevator, GOLDENROD_DEPT_STORE_ELEVATOR, $0, 0
	map_attributes GoldenrodDeptStoreRoof, GOLDENROD_DEPT_STORE_ROOF, $24, 0
	map_attributes GoldenrodGameCorner, GOLDENROD_GAME_CORNER, $0, 0
	map_attributes GoldenrodPokeComCenter1F, GOLDENROD_POKECOM_CENTER_1F, $0, 0
	map_attributes GoldenrodPokeComCenterOffice, GOLDENROD_POKECOM_CENTER_OFFICE, $0, 0
	map_attributes GoldenrodHarborGate, GOLDENROD_HARBOR_GATE, $0, 0
	map_attributes IlexForestAzaleaGate, ILEX_FOREST_AZALEA_GATE, $0, 0
	map_attributes Route34IlexForestGate, ROUTE_34_ILEX_FOREST_GATE, $0, 0
	map_attributes DayCare, DAYCARE, $0, 0
	map_attributes GoldenrodHPUpHouse, GOLDENROD_HP_UP_HOUSE, $0, 0
	map_attributes GoldenrodNetBallHouse, GOLDENROD_NET_BALL_HOUSE, $0, 0
	map_attributes GoldenrodBandHouse, GOLDENROD_BAND_HOUSE, $0, 0
	map_attributes GoldenrodMuseum1F, GOLDENROD_MUSEUM_1F, $0, 0
	map_attributes GoldenrodMuseum2F, GOLDENROD_MUSEUM_2F, $0, 0
	map_attributes VermilionHouseFishingSpeechHouse, VERMILION_HOUSE_FISHING_SPEECH_HOUSE, $0, 0
	map_attributes VermilionPokeCenter1F, VERMILION_POKECENTER_1F, $0, 0
	map_attributes PokemonFanClub, POKEMON_FAN_CLUB, $0, 0
	map_attributes VermilionMagnetTrainSpeechHouse, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, $0, 0
	map_attributes VermilionMart, VERMILION_MART, $0, 0
	map_attributes VermilionHouseDiglettsCaveSpeechHouse, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE, $0, 0
	map_attributes VermilionGym, VERMILION_GYM, $0, 0
	map_attributes Route6SaffronGate, ROUTE_6_SAFFRON_GATE, $0, 0
	map_attributes Route6UndergroundEntrance, ROUTE_6_UNDERGROUND_ENTRANCE, $0, 0
	map_attributes Route11Gate, ROUTE_11_GATE, $0, 0
	map_attributes Route11Gate2F, ROUTE_11_GATE_2F, $0, 0
	map_attributes VermilionPollutionSpeechHouse, VERMILION_POLLUTION_SPEECH_HOUSE, $0, 0
	map_attributes VermilionSSAnneSpeechHouse, VERMILION_S_S_ANNE_SPEECH_HOUSE, $0, 0
	map_attributes RedsHouse1F, REDS_HOUSE_1F, $0, 0
	map_attributes RedsHouse2F, REDS_HOUSE_2F, $0, 0
	map_attributes BluesHouse1F, BLUES_HOUSE_1F, $0, 0
	map_attributes BluesHouse2F, BLUES_HOUSE_2F, $0, 0
	map_attributes OaksLab, OAKS_LAB, $0, 0
	map_attributes PewterNidoranSpeechHouse, PEWTER_NIDORAN_SPEECH_HOUSE, $0, 0
	map_attributes PewterGym, PEWTER_GYM, $0, 0
	map_attributes PewterMart, PEWTER_MART, $0, 0
	map_attributes PewterPokeCenter1F, PEWTER_POKECENTER_1F, $0, 0
	map_attributes PewterSnoozeSpeechHouse, PEWTER_SNOOZE_SPEECH_HOUSE, $0, 0
	map_attributes OlivinePort, OLIVINE_PORT, $a, 0
	map_attributes VermilionPort, VERMILION_PORT, $a, 0
	map_attributes FastShip1F, FAST_SHIP_1F, $0, 0
	map_attributes FastShipCabins_NNW_NNE_NE, FAST_SHIP_CABINS_NNW_NNE_NE, $0, 0
	map_attributes FastShipCabins_SW_SSW_NW, FAST_SHIP_CABINS_SW_SSW_NW, $0, 0
	map_attributes FastShipCabins_SE_SSE_CaptainsCabin, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, $0, 0
	map_attributes FastShipB1F, FAST_SHIP_B1F, $0, 0
	map_attributes OlivinePortPassage, OLIVINE_PORT_PASSAGE, $0, 0
	map_attributes VermilionPortPassage, VERMILION_PORT_PASSAGE, $0, 0
	map_attributes MountMoonSquare, MOUNT_MOON_SQUARE, $2d, 0
	map_attributes MountMoonGiftShop, MOUNT_MOON_GIFT_SHOP, $0, 0
	map_attributes TinTowerRoof, TIN_TOWER_ROOF, $1, 0
	map_attributes IndigoPlateauPokeCenter1F, INDIGO_PLATEAU_POKECENTER_1F, $0, 0
	map_attributes WillsRoom, WILLS_ROOM, $0, 0
	map_attributes KogasRoom, KOGAS_ROOM, $0, 0
	map_attributes BrunosRoom, BRUNOS_ROOM, $0, 0
	map_attributes KarensRoom, KARENS_ROOM, $0, 0
	map_attributes LancesRoom, LANCES_ROOM, $0, 0
	map_attributes HallOfFame, HALL_OF_FAME, $0, 0
	map_attributes FuchsiaMart, FUCHSIA_MART, $0, 0
	map_attributes FuchsiaGym, FUCHSIA_GYM, $0, 0
	map_attributes FuchsiaBillSpeechHouse, FUCHSIA_BILL_SPEECH_HOUSE, $0, 0
	map_attributes FuchsiaSafariBallHouse, FUCHSIA_SAFARI_BALL_HOUSE, $0, 0
	map_attributes FuchsiaPokeCenter1F, FUCHSIA_POKECENTER_1F, $0, 0
	map_attributes SafariZoneWardensHome, SAFARI_ZONE_WARDENS_HOME, $0, 0
	map_attributes Route12Gate, ROUTE_12_GATE, $0, 0
	map_attributes Route12Gate2F, ROUTE_12_GATE_2F, $0, 0
	map_attributes Route15FuchsiaGate, ROUTE_15_FUCHSIA_GATE, $0, 0
	map_attributes Route15FuchsiaGate2F, ROUTE_15_FUCHSIA_GATE_2F, $0, 0
	map_attributes LavenderPokeCenter1F, LAVENDER_POKECENTER_1F, $0, 0
	map_attributes MrFujisHouse, MR_FUJIS_HOUSE, $0, 0
	map_attributes LavenderTownSpeechHouse, LAVENDER_TOWN_SPEECH_HOUSE, $0, 0
	map_attributes LavenderNameRater, LAVENDER_NAME_RATER, $0, 0
	map_attributes LavenderMart, LAVENDER_MART, $0, 0
	map_attributes SoulHouse, SOUL_HOUSE, $0, 0
	map_attributes SoulHouseB1F, SOUL_HOUSE_B1F, $0, 0
	map_attributes SoulHouseB2F, SOUL_HOUSE_B2F, $0, 0
	map_attributes SoulHouseB3F, SOUL_HOUSE_B3F, $0, 0
	map_attributes LavRadioTower1F, LAV_RADIO_TOWER_1F, $0, 0
	map_attributes LavRadioTower2F, LAV_RADIO_TOWER_2F, $0, 0
	map_attributes LavRadioTower3F, LAV_RADIO_TOWER_3F, $0, 0
	map_attributes LavRadioTower4F, LAV_RADIO_TOWER_3F, $0, 0
	map_attributes LavRadioTower5F, LAV_RADIO_TOWER_5F, $0, 0
	map_attributes HauntedRadioTower2F, HAUNTED_RADIO_TOWER_2F, $0, 0
	map_attributes HauntedRadioTower3F, HAUNTED_RADIO_TOWER_3F, $0, 0
	map_attributes HauntedRadioTower4F, HAUNTED_RADIO_TOWER_4F, $0, 0
	map_attributes HauntedRadioTower5F, HAUNTED_RADIO_TOWER_5F, $0, 0
	map_attributes HauntedRadioTower6F, HAUNTED_RADIO_TOWER_6F, $0, 0
	map_attributes Route8SaffronGate, ROUTE_8_SAFFRON_GATE, $0, 0
	map_attributes Route12SuperRodHouse, ROUTE_12_SUPER_ROD_HOUSE, $0, 0
	map_attributes SilverCavePokeCenter1F, SILVER_CAVE_POKECENTER_1F, $0, 0
	map_attributes Route28FamousSpeechHouse, ROUTE_28_FAMOUS_SPEECH_HOUSE, $0, 0
	map_attributes PokeCenter2F, POKECENTER_2F, $0, 0
	map_attributes TradeCenter, TRADE_CENTER, $0, 0
	map_attributes Colosseum, COLOSSEUM, $0, 0
	map_attributes HiddenTreeGrotto, HIDDEN_TREE_GROTTO, $35, 0
	map_attributes HiddenCaveGrotto, HIDDEN_CAVE_GROTTO, $9, 0
	map_attributes CeladonDeptStore1F, CELADON_DEPT_STORE_1F, $0, 0
	map_attributes CeladonDeptStore2F, CELADON_DEPT_STORE_2F, $0, 0
	map_attributes CeladonDeptStore3F, CELADON_DEPT_STORE_3F, $0, 0
	map_attributes CeladonDeptStore4F, CELADON_DEPT_STORE_4F, $0, 0
	map_attributes CeladonDeptStore5F, CELADON_DEPT_STORE_5F, $0, 0
	map_attributes CeladonDeptStore6F, CELADON_DEPT_STORE_6F, $0, 0
	map_attributes CeladonDeptStoreElevator, CELADON_DEPT_STORE_ELEVATOR, $0, 0
	map_attributes CeladonMansion1F, CELADON_MANSION_1F, $0, 0
	map_attributes CeladonMansion2F, CELADON_MANSION_2F, $0, 0
	map_attributes CeladonMansion3F, CELADON_MANSION_3F, $0, 0
	map_attributes CeladonMansionRoof, CELADON_MANSION_ROOF, $1, 0
	map_attributes CeladonMansionRoofHouse, CELADON_MANSION_ROOF_HOUSE, $0, 0
	map_attributes CeladonPokeCenter1F, CELADON_POKECENTER_1F, $0, 0
	map_attributes CeladonGameCorner, CELADON_GAME_CORNER, $0, 0
	map_attributes CeladonGameCornerPrizeRoom, CELADON_GAME_CORNER_PRIZE_ROOM, $0, 0
	map_attributes CeladonGym, CELADON_GYM, $0, 0
	map_attributes CeladonCafe, CELADON_CAFE, $0, 0
	map_attributes CeladonChiefHouse, CELADON_CHIEF_HOUSE, $0, 0
	map_attributes CeladonHotel1F, CELADON_HOTEL_1F, $0, 0
	map_attributes CeladonHotel2F, CELADON_HOTEL_2F, $0, 0
	map_attributes CeladonHotelRoom1, CELADON_HOTEL_ROOM_1, $0, 0
	map_attributes CeladonHotelRoom2, CELADON_HOTEL_ROOM_2, $0, 0
	map_attributes CeladonHotelRoom3, CELADON_HOTEL_ROOM_3, $0, 0
	map_attributes CeladonHotelPool, CELADON_HOTEL_POOL, $0, 0
	map_attributes EusinesHouse, EUSINES_HOUSE, $0, 0
	map_attributes PsychicInversHouse, PSYCHIC_INVERS_HOUSE, $0, 0
	map_attributes CeladonOldManSpeechHouse, CELADON_OLD_MAN_SPEECH_HOUSE, $0, 0
	map_attributes CeladonDevelopmentSpeechHouse, CELADON_DEVELOPMENT_SPEECH_HOUSE, $0, 0
	map_attributes Route16FuchsiaSpeechHouse, ROUTE_16_FUCHSIA_SPEECH_HOUSE, $0, 0
	map_attributes Route16Gate, ROUTE_16_GATE, $0, 0
	map_attributes Route1617Gate, ROUTE_16_17_GATE, $0, 0
	map_attributes Route1617Gate2F, ROUTE_16_17_GATE_2F, $0, 0
	map_attributes Route7SaffronGate, ROUTE_7_SAFFRON_GATE, $0, 0
	map_attributes Route18Gate, ROUTE_18_GATE, $0, 0
	map_attributes Route18Gate2F, ROUTE_18_GATE_2F, $0, 0
	map_attributes CeladonHomeDecorStore1F, CELADON_HOME_DECOR_STORE_1F, $0, 0
	map_attributes CeladonHomeDecorStore2F, CELADON_HOME_DECOR_STORE_2F, $0, 0
	map_attributes CeladonHomeDecorStore3F, CELADON_HOME_DECOR_STORE_3F, $0, 0
	map_attributes CeladonHomeDecorStore4F, CELADON_HOME_DECOR_STORE_4F, $0, 0
	map_attributes CeladonUniversity1F, CELADON_UNIVERSITY_1F, $0, 0
	map_attributes CeladonUniversity2F, CELADON_UNIVERSITY_2F, $0, 0
	map_attributes CeladonUniversityLibrary1F, CELADON_UNIVERSITY_LIBRARY_1F, $0, 0
	map_attributes CeladonUniversityLibrary2F, CELADON_UNIVERSITY_LIBRARY_2F, $0, 0
	map_attributes CeladonUniversityPrincipalsOffice, CELADON_UNIVERSITY_PRINCIPALS_OFFICE, $0, 0
	map_attributes CeladonUniversityWestwoodsOffice, CELADON_UNIVERSITY_WESTWOODS_OFFICE, $0, 0
	map_attributes CeladonUniversityWillowsOffice, CELADON_UNIVERSITY_WILLOWS_OFFICE, $0, 0
	map_attributes CeladonUniversityLounge, CELADON_UNIVERSITY_LOUNGE, $0, 0
	map_attributes CeladonUniversityCafeteria, CELADON_UNIVERSITY_CAFETERIA, $0, 0
	map_attributes CeladonUniversityHyperTestRoom, CELADON_UNIVERSITY_HYPER_TEST_ROOM, $0, 0
	map_attributes CeladonUniversityPool, CELADON_UNIVERSITY_POOL, $0, 0
	map_attributes CeladonUniversityClassroom1, CELADON_UNIVERSITY_CLASSROOM_1, $0, 0
	map_attributes CeladonUniversityClassroom2, CELADON_UNIVERSITY_CLASSROOM_2, $0, 0
	map_attributes CeladonUniversityClassroom3, CELADON_UNIVERSITY_CLASSROOM_3, $0, 0
	map_attributes CeladonUniversityClassroom4, CELADON_UNIVERSITY_CLASSROOM_4, $0, 0
	map_attributes ManiasHouse, MANIAS_HOUSE, $0, 0
	map_attributes CianwoodGym, CIANWOOD_GYM, $0, 0
	map_attributes CianwoodPokeCenter1F, CIANWOOD_POKECENTER_1F, $0, 0
	map_attributes CianwoodPharmacy, CIANWOOD_PHARMACY, $0, 0
	map_attributes CianwoodCityPhotoStudio, CIANWOOD_CITY_PHOTO_STUDIO, $0, 0
	map_attributes CianwoodLugiaSpeechHouse, CIANWOOD_LUGIA_SPEECH_HOUSE, $0, 0
	map_attributes StatsJudgesHouse, STATS_JUDGES_HOUSE, $0, 0
	map_attributes BattleTower1F, BATTLE_TOWER_1F, $0, 0
	map_attributes BattleTower2F, BATTLE_TOWER_2F, $0, 0
	map_attributes BattleTowerBattleRoom, BATTLE_TOWER_BATTLE_ROOM, $0, 0
	map_attributes BattleTowerElevator, BATTLE_TOWER_ELEVATOR, $0, 0
	map_attributes BattleTowerHallway, BATTLE_TOWER_HALLWAY, $0, 0
	map_attributes Route40BattleTowerGate, ROUTE_40_BATTLE_TOWER_GATE, $0, 0
	map_attributes BattleTowerOutside, BATTLE_TOWER_OUTSIDE, $5, 0
	map_attributes CliffEdgeGate, CLIFF_EDGE_GATE, $9, 0
	map_attributes CliffCave, CLIFF_CAVE, $9, 0
	map_attributes ViridianGym, VIRIDIAN_GYM, $0, 0
	map_attributes ViridianNicknameSpeechHouse, VIRIDIAN_NICKNAME_SPEECH_HOUSE, $0, 0
	map_attributes ViridianSchoolHouse, VIRIDIAN_SCHOOL_HOUSE, $0, 0
	map_attributes TrainerHouse1F, TRAINER_HOUSE_1F, $0, 0
	map_attributes TrainerHouseB1F, TRAINER_HOUSE_B1F, $0, 0
	map_attributes ViridianMart, VIRIDIAN_MART, $0, 0
	map_attributes ViridianPokeCenter1F, VIRIDIAN_POKECENTER_1F, $0, 0
	map_attributes Route2NuggetSpeechHouse, ROUTE_2_NUGGET_SPEECH_HOUSE, $0, 0
	map_attributes Route2Gate, ROUTE_2_GATE, $0, 0
	map_attributes PokemonLeagueGate, POKEMON_LEAGUE_GATE, $0, 0
	map_attributes ElmsLab, ELMS_LAB, $0, 0
	map_attributes KrissHouse1F, KRISS_HOUSE_1F, $0, 0
	map_attributes KrissHouse2F, KRISS_HOUSE_2F, $0, 0
	map_attributes KrissNeighborsHouse, KRISS_NEIGHBORS_HOUSE, $0, 0
	map_attributes LyrasHouse1F, LYRAS_HOUSE_1F, $0, 0
	map_attributes LyrasHouse2F, LYRAS_HOUSE_2F, $0, 0
	map_attributes ElmsHouse, ELMS_HOUSE, $0, 0
	map_attributes Route26HealSpeechHouse, ROUTE_26_HEAL_SPEECH_HOUSE, $0, 0
	map_attributes Route26DayofWeekSiblingsHouse, ROUTE_26_DAY_OF_WEEK_SIBLINGS_HOUSE, $0, 0
	map_attributes Route27RestHouse, ROUTE_27_REST_HOUSE, $0, 0
	map_attributes Route2946Gate, ROUTE_29_46_GATE, $0, 0
	map_attributes FightingDojo, FIGHTING_DOJO, $0, 0
	map_attributes SaffronGym, SAFFRON_GYM, $0, 0
	map_attributes SaffronMart, SAFFRON_MART, $0, 0
	map_attributes SaffronPokeCenter1F, SAFFRON_POKECENTER_1F, $0, 0
	map_attributes MrPsychicsHouse, MR_PSYCHICS_HOUSE, $0, 0
	map_attributes SaffronTrainStation, SAFFRON_TRAIN_STATION, $0, 0
	map_attributes SilphCo1F, SILPH_CO_1F, $0, 0
	map_attributes SilphCo2F, SILPH_CO_2F, $0, 0
	map_attributes SilphCo3F, SILPH_CO_3F, $0, 0
	map_attributes CopycatsHouse1F, COPYCATS_HOUSE_1F, $0, 0
	map_attributes CopycatsHouse2F, COPYCATS_HOUSE_2F, $0, 0
	map_attributes Route5UndergroundEntrance, ROUTE_5_UNDERGROUND_ENTRANCE, $0, 0
	map_attributes Route5SaffronCityGate, ROUTE_5_SAFFRON_CITY_GATE, $0, 0
	map_attributes Route5CleanseTagSpeechHouse, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE, $0, 0
	map_attributes PokemonTrainerFanClub, POKEMON_TRAINER_FAN_CLUB, $0, 0
	map_attributes SaffronHitmontopKidHouse, SAFFRON_HITMONTOP_KID_HOUSE, $0, 0
	map_attributes SaffronBookSpeechHouse, SAFFRON_BOOK_SPEECH_HOUSE, $0, 0
	map_attributes SaffronOrreSpeechHouse, SAFFRON_ORRE_SPEECH_HOUSE, $0, 0
	map_attributes SaffronRichSpeechHouse, SAFFRON_RICH_SPEECH_HOUSE, $0, 0
	map_attributes CherrygroveMart, CHERRYGROVE_MART, $0, 0
	map_attributes CherrygrovePokeCenter1F, CHERRYGROVE_POKECENTER_1F, $0, 0
	map_attributes CherrygroveGymSpeechHouse, CHERRYGROVE_GYM_SPEECH_HOUSE, $0, 0
	map_attributes GuideGentsHouse, GUIDE_GENTS_HOUSE, $0, 0
	map_attributes CherrygroveEvolutionSpeechHouse, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, $0, 0
	map_attributes Route30BerrySpeechHouse, ROUTE_30_BERRY_SPEECH_HOUSE, $0, 0
	map_attributes MrPokemonsHouse, MR_POKEMONS_HOUSE, $0, 0
	map_attributes Route31VioletGate, ROUTE_31_VIOLET_GATE, $0, 0
	map_attributes BellchimeTrail, BELLCHIME_TRAIL, $5, 0
	map_attributes PewterMuseumOfScience1F, PEWTER_MUSEUM_OF_SCIENCE_1F, $0, 0
	map_attributes PewterMuseumOfScience2F, PEWTER_MUSEUM_OF_SCIENCE_2F, $0, 0
	map_attributes ViridianForest, VIRIDIAN_FOREST, $45, 0
	map_attributes ViridianForestViridianGate, VIRIDIAN_FOREST_VIRIDIAN_GATE, $0, 0
	map_attributes ViridianForestPewterGate, VIRIDIAN_FOREST_PEWTER_GATE, $0, 0
	map_attributes Route1ViridianGate, ROUTE_1_VIRIDIAN_GATE, $0, 0
	map_attributes CeruleanCave1F, CERULEAN_CAVE_1F, $9, 0
	map_attributes CeruleanCave2F, CERULEAN_CAVE_2F, $9, 0
	map_attributes CeruleanCaveB1F, CERULEAN_CAVE_B1F, $9, 0
	map_attributes YellowForestGate, YELLOW_FOREST_GATE, $0, 0
	map_attributes YellowForest, YELLOW_FOREST, $55, 0
	map_attributes QuietCave1F, QUIET_CAVE_1F, $9, 0
	map_attributes QuietCaveB1F, QUIET_CAVE_B1F, $9, 0
	map_attributes QuietCaveB2F, QUIET_CAVE_B2F, $9, 0
	map_attributes QuietCaveB3F, QUIET_CAVE_B3F, $9, 0
	map_attributes DimCave1F, DIM_CAVE_1F, $9, 0
	map_attributes DimCave2F, DIM_CAVE_2F, $9, 0
	map_attributes DimCave3F, DIM_CAVE_3F, $9, 0
	map_attributes DimCave4F, DIM_CAVE_4F, $9, 0
	map_attributes DimCave5F, DIM_CAVE_5F, $9, 0
	map_attributes CinnabarVolcano1F, CINNABAR_VOLCANO_1F, $9, 0
	map_attributes CinnabarVolcanoB1F, CINNABAR_VOLCANO_B1F, $9, 0
	map_attributes CinnabarVolcanoB2F, CINNABAR_VOLCANO_B2F, $9, 0
	map_attributes SafariZoneFuchsiaGate, SAFARI_ZONE_FUCHSIA_GATE, $0, 0
	map_attributes SafariZoneHub, SAFARI_ZONE_HUB, $0, 0
	map_attributes SafariZoneEast, SAFARI_ZONE_EAST, $0, 0
	map_attributes SafariZoneNorth, SAFARI_ZONE_NORTH, $0, 0
	map_attributes SafariZoneWest, SAFARI_ZONE_WEST, $0, 0
	map_attributes SafariZoneHubRestHouse, SAFARI_ZONE_HUB_REST_HOUSE, $0, 0
	map_attributes SafariZoneEastRestHouse, SAFARI_ZONE_EAST_REST_HOUSE, $0, 0
	map_attributes SafariZoneNorthRestHouse, SAFARI_ZONE_NORTH_REST_HOUSE, $0, 0
	map_attributes SafariZoneWestRestHouse1, SAFARI_ZONE_WEST_REST_HOUSE_1, $0, 0
	map_attributes SafariZoneWestRestHouse2, SAFARI_ZONE_WEST_REST_HOUSE_2, $0, 0
	map_attributes NavelRockOutside, NAVEL_ROCK_OUTSIDE, $35, 0
	map_attributes NavelRockInside, NAVEL_ROCK_INSIDE, $9, 0
	map_attributes NavelRockRoof, NAVEL_ROCK_ROOF, $1, 0
	map_attributes FarawayIsland, FARAWAY_ISLAND, $6, 0
	map_attributes FarawayJungle, FARAWAY_JUNGLE, $17, 0
	map_attributes SeagallopFerryVermilionGate, SEAGALLOP_FERRY_VERMILION_GATE, $0, 0
	map_attributes SeagallopFerryNavelGate, SEAGALLOP_FERRY_NAVEL_GATE, $0, 0
	map_attributes SeagallopFerryShamoutiGate, SEAGALLOP_FERRY_SHAMOUTI_GATE, $0, 0
	map_attributes PokemonMansion1F, POKEMON_MANSION_1F, $0, 0
	map_attributes PokemonMansionB1F, POKEMON_MANSION_B1F, $45, 0
	map_attributes CinnabarLab, CINNABAR_LAB, $0, 0
	map_attributes ScaryCave1F, SCARY_CAVE_1F, $9, 0
	map_attributes ScaryCaveB1F, SCARY_CAVE_B1F, $9, 0
	map_attributes ScaryCaveShipwreck, SCARY_CAVE_SHIPWRECK, $9, 0
	map_attributes Route19BeachHouse, ROUTE_19_BEACH_HOUSE, $0, 0
	map_attributes ShamoutiTunnel, SHAMOUTI_TUNNEL, $9, 0
	map_attributes NoisyForest, NOISY_FOREST, $0, 0
	map_attributes ShamoutiShrineRuins, SHAMOUTI_SHRINE_RUINS, $37, 0
	map_attributes ShamoutiPokeCenter1F, SHAMOUTI_POKECENTER_1F, $0, 0
	map_attributes ShamoutiHotel1F, SHAMOUTI_HOTEL_1F, $0, 0
	map_attributes ShamoutiHotel2F, SHAMOUTI_HOTEL_2F, $0, 0
	map_attributes ShamoutiHotel3F, SHAMOUTI_HOTEL_3F, $0, 0
	map_attributes ShamoutiHotelRoom2A, SHAMOUTI_HOTEL_ROOM_2A, $0, 0
	map_attributes ShamoutiHotelRoom2B, SHAMOUTI_HOTEL_ROOM_2B, $0, 0
	map_attributes ShamoutiHotelRoom3B, SHAMOUTI_HOTEL_ROOM_3B, $0, 0
	map_attributes ShamoutiHotelRoom3C, SHAMOUTI_HOTEL_ROOM_3C, $0, 0
	map_attributes ShamoutiHotelRestaurant, SHAMOUTI_HOTEL_RESTAURANT, $0, 0
	map_attributes ShamoutiTouristCenter, SHAMOUTI_TOURIST_CENTER, $0, 0
	map_attributes ShamoutiMerchant, SHAMOUTI_MERCHANT, $0, 0
	map_attributes ShamoutiHouse, SHAMOUTI_HOUSE, $0, 0
	map_attributes BeautifulBeachVilla, BEAUTIFUL_BEACH_VILLA, $0, 0
	map_attributes WarmBeachShack, WARM_BEACH_SHACK, $0, 0
	map_attributes WarmBeachHouse, WARM_BEACH_HOUSE, $0, 0
	map_attributes RockyBeachHouse, ROCKY_BEACH_HOUSE, $0, 0
	map_attributes FireIsland, FIRE_ISLAND, $9, 0
	map_attributes FireIslandRoof, FIRE_ISLAND_ROOF, $35, 0
	map_attributes IceIsland, ICE_ISLAND, $9, 0
	map_attributes IceIslandRoof, ICE_ISLAND_ROOF, $35, 0
	map_attributes LightningIsland, LIGHTNING_ISLAND, $9, 0
	map_attributes LightningIslandRoof, LIGHTNING_ISLAND_ROOF, $35, 0
	map_attributes IvysLab, IVYS_LAB, $0, 0
	map_attributes IvysHouse, IVYS_HOUSE, $0, 0
	map_attributes ValenciaHouse, VALENCIA_HOUSE, $0, 0
	map_attributes ValenciaPort, VALENCIA_PORT, $0, 0
