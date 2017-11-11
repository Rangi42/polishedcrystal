	map_header_2 NewBarkTown, NEW_BARK_TOWN, $5, WEST | EAST
	connection west, ROUTE_29, Route29, 0, 0, 9
	connection east, ROUTE_27, Route27, 0, 0, 9

	map_header_2 CherrygroveCity, CHERRYGROVE_CITY, $35, NORTH | WEST | EAST
	connection north, ROUTE_30, Route30, 5, 0, 10
	connection west, CHERRYGROVE_BAY, CherrygroveBay, -1, 14, 10
	connection east, ROUTE_29, Route29, 0, 0, 9

	map_header_2 VioletCity, VIOLET_CITY, $5, NORTH | SOUTH | WEST | EAST
	connection north, VIOLET_OUTSKIRTS, VioletOutskirts, 0, 0, 20
	connection south, ROUTE_32, Route32, 0, 0, 10
	connection west, ROUTE_36, Route36, 0, -2, 9
	connection east, ROUTE_31, Route31, 11, 0, 9

	map_header_2 AzaleaTown, AZALEA_TOWN, $5, WEST | EAST
	connection west, ROUTE_34, Route34, -3, 15, 12
	connection east, ROUTE_33, Route33, 0, 0, 9

	map_header_2 CianwoodCity, CIANWOOD_CITY, $35, EAST
	connection east, ROUTE_41, Route41, 0, 0, 27

	map_header_2 GoldenrodCity, GOLDENROD_CITY, $35, NORTH | SOUTH | EAST
	connection north, ROUTE_35, Route35, 5, 0, 12
	connection south, ROUTE_34, Route34, 7, 0, 10
	connection east, MAGNET_TUNNEL_WEST, MagnetTunnelWest, 0, 0, 11

	map_header_2 OlivineCity, OLIVINE_CITY, $35, NORTH | SOUTH | WEST
	connection north, ROUTE_39, Route39, 5, 0, 10
	connection south, ROUTE_35_COAST, Route35Coast, 0, -7, 32
	connection west, ROUTE_40, Route40, 7, 0, 12

	map_header_2 EcruteakCity, ECRUTEAK_CITY, $5, SOUTH | WEST | EAST
	connection south, ROUTE_37, Route37, 5, 0, 10
	connection west, ROUTE_38, Route38, 5, 0, 9
	connection east, ROUTE_42, Route42, 9, 0, 9

	map_header_2 MahoganyTown, MAHOGANY_TOWN, $71, NORTH | WEST | EAST
	connection north, ROUTE_43, Route43, 0, 0, 10
	connection west, ROUTE_42, Route42, 0, 0, 9
	connection east, ROUTE_44, Route44, 0, 0, 9

	map_header_2 LakeofRage, LAKE_OF_RAGE, $5, SOUTH
	connection south, ROUTE_43, Route43, 5, 0, 10

	map_header_2 BlackthornCity, BLACKTHORN_CITY, $71, SOUTH
	connection south, ROUTE_45, Route45, -2, 0, 12

	map_header_2 SilverCaveOutside, SILVER_CAVE_OUTSIDE, $71, EAST
	connection east, ROUTE_28, Route28, 6, 0, 9

	map_header_2 Route26, ROUTE_26, $5, WEST
	connection west, ROUTE_27, Route27, 45, 0, 9

	map_header_2 Route27, ROUTE_27, $35, WEST | EAST
	connection west, NEW_BARK_TOWN, NewBarkTown, 0, 0, 9
	connection east, ROUTE_26, Route26, -3, 42, 12

	map_header_2 Route28, ROUTE_28, $71, WEST
	connection west, SILVER_CAVE_OUTSIDE, SilverCaveOutside, -3, 3, 12

	map_header_2 Route29, ROUTE_29, $5, NORTH | WEST | EAST
	connection north, ROUTE_46, Route46, 10, 0, 10
	connection west, CHERRYGROVE_CITY, CherrygroveCity, 0, 0, 9
	connection east, NEW_BARK_TOWN, NewBarkTown, 0, 0, 9

	map_header_2 Route30, ROUTE_30, $5, NORTH | SOUTH
	connection north, ROUTE_31, Route31, -3, 7, 13
	connection south, CHERRYGROVE_CITY, CherrygroveCity, -3, 2, 16

	map_header_2 Route31, ROUTE_31, $5, SOUTH | WEST
	connection south, ROUTE_30, Route30, 10, 0, 10
	connection west, VIOLET_CITY, VioletCity, -2, 6, 12

	map_header_2 Route32, ROUTE_32, $5, NORTH | SOUTH | WEST | EAST
	connection north, VIOLET_CITY, VioletCity, 0, 0, 13
	connection south, ROUTE_33, Route33, 0, 0, 10
	connection west, MAGNET_TUNNEL_EAST, MagnetTunnelEast, 9, 0, 11
	connection east, CHERRYGROVE_BAY, CherrygroveBay, 12, 0, 26

	map_header_2 Route33, ROUTE_33, $5, NORTH | WEST
	connection north, ROUTE_32, Route32, 0, 0, 10
	connection west, AZALEA_TOWN, AzaleaTown, 0, 0, 9

	map_header_2 Route34, ROUTE_34, $5, NORTH | WEST | EAST
	connection north, GOLDENROD_CITY, GoldenrodCity, -3, 4, 16
	connection west, ROUTE_34_COAST, Route34Coast, 0, 0, 27
	connection east, AZALEA_TOWN, AzaleaTown, 18, 0, 9

	map_header_2 Route34Coast, ROUTE_34_COAST, $35, SOUTH | EAST
	connection south, STORMY_BEACH, StormyBeach, 0, 0, 9
	connection east, ROUTE_34, Route34, 0, 0, 27

	map_header_2 StormyBeach, STORMY_BEACH, $35, NORTH
	connection north, ROUTE_34_COAST, Route34Coast, 0, 0, 9

	map_header_2 Route35, ROUTE_35, $5, NORTH | SOUTH
	connection north, ROUTE_36, Route36, 0, 0, 14
	connection south, GOLDENROD_CITY, GoldenrodCity, -2, 3, 16

	map_header_2 Route35Coast, ROUTE_35_COAST, $35, NORTH | SOUTH
	connection north, OLIVINE_CITY, OlivineCity, 0, 7, 32
	connection south, GOLDENROD_HARBOR, GoldenrodHarbor, 0, 0, 24

	map_header_2 Route36, ROUTE_36, $5, NORTH | SOUTH | EAST
	connection north, ROUTE_37, Route37, 12, 0, 10
	connection south, ROUTE_35, Route35, 0, 0, 12
	connection east, VIOLET_CITY, VioletCity, -2, 0, 12

	map_header_2 Route37, ROUTE_37, $5, NORTH | SOUTH
	connection north, ECRUTEAK_CITY, EcruteakCity, -3, 2, 16
	connection south, ROUTE_36, Route36, -3, 9, 16

	map_header_2 Route38, ROUTE_38, $5, WEST | EAST
	connection west, ROUTE_39, Route39, 0, 0, 12
	connection east, ECRUTEAK_CITY, EcruteakCity, -3, 2, 15

	map_header_2 Route39, ROUTE_39, $5, SOUTH | EAST
	connection south, OLIVINE_CITY, OlivineCity, -3, 2, 16
	connection east, ROUTE_38, Route38, 0, 0, 9

	map_header_2 Route40, ROUTE_40, $35, SOUTH | EAST
	connection south, ROUTE_41, Route41, -3, 12, 13
	connection east, OLIVINE_CITY, OlivineCity, -3, 4, 12

	map_header_2 Route41, ROUTE_41, $35, NORTH | WEST | EAST
	connection north, ROUTE_40, Route40, 15, 0, 10
	connection west, CIANWOOD_CITY, CianwoodCity, 0, 0, 27
	connection east, GOLDENROD_HARBOR, GoldenrodHarbor, 3, 0, 20

	map_header_2 Route42, ROUTE_42, $5, SOUTH | WEST | EAST
	connection south, VIOLET_OUTSKIRTS, VioletOutskirts, 5, 0, 14
	connection west, ECRUTEAK_CITY, EcruteakCity, -3, 6, 12
	connection east, MAHOGANY_TOWN, MahoganyTown, 0, 0, 9

	map_header_2 Route43, ROUTE_43, $5, NORTH | SOUTH
	connection north, LAKE_OF_RAGE, LakeofRage, -3, 2, 16
	connection south, MAHOGANY_TOWN, MahoganyTown, 0, 0, 10

	map_header_2 Route44, ROUTE_44, $71, WEST
	connection west, MAHOGANY_TOWN, MahoganyTown, 0, 0, 9

	map_header_2 Route45, ROUTE_45, $71, NORTH | WEST
	connection north, BLACKTHORN_CITY, BlackthornCity, 1, -1, 12
	connection west, ROUTE_46, Route46, 37, 0, 12

	map_header_2 Route46, ROUTE_46, $5, SOUTH | EAST
	connection south, ROUTE_29, Route29, -3, 7, 16
	connection east, ROUTE_45, Route45, -3, 34, 12

	map_header_2 PewterCity, PEWTER_CITY, $f, SOUTH | EAST
	connection south, ROUTE_2_NORTH, Route2North, 5, 0, 10
	connection east, ROUTE_3, Route3, 5, 0, 9

	map_header_2 Route2North, ROUTE_2_NORTH, $f, NORTH | SOUTH
	connection north, PEWTER_CITY, PewterCity, -3, 2, 16
	connection south, ROUTE_2_SOUTH, Route2South, 0, 0, 10

	map_header_2 Route2South, ROUTE_2_SOUTH, $f, NORTH | SOUTH | EAST
	connection north, ROUTE_2_NORTH, Route2North, 0, 0, 10
	connection south, VIRIDIAN_CITY, ViridianCity, -3, 2, 16
	connection east, ROUTE_16_WEST, Route16West, 8, 0, 10

	map_header_2 ViridianCity, VIRIDIAN_CITY, $f, NORTH | SOUTH | WEST
	connection north, ROUTE_2_SOUTH, Route2South, 5, 0, 10
	connection south, ROUTE_1, Route1, 9, 0, 10
	connection west, ROUTE_22, Route22, 4, 0, 9

	map_header_2 Route22, ROUTE_22, $2c, EAST
	connection east, VIRIDIAN_CITY, ViridianCity, -3, 1, 15

	map_header_2 Route1, ROUTE_1, $f, NORTH | SOUTH
	connection north, VIRIDIAN_CITY, ViridianCity, -3, 6, 13
	connection south, PALLET_TOWN, PalletTown, 1, 0, 10

	map_header_2 PalletTown, PALLET_TOWN, $f, NORTH | SOUTH
	connection north, ROUTE_1, Route1, -1, 0, 10
	connection south, ROUTE_21, Route21, 0, 0, 10

	map_header_2 Route21, ROUTE_21, $43, NORTH | SOUTH | EAST
	connection north, PALLET_TOWN, PalletTown, 0, 0, 10
	connection south, CINNABAR_ISLAND, CinnabarIsland, 0, 0, 10
	connection east, URAGA_CHANNEL_WEST, UragaChannelWest, 19, 0, 15

	map_header_2 CinnabarIsland, CINNABAR_ISLAND, $43, NORTH | EAST
	connection north, ROUTE_21, Route21, 0, 0, 10
	connection east, ROUTE_20, Route20, 2, 0, 9

	map_header_2 Route20, ROUTE_20, $43, WEST | EAST
	connection west, CINNABAR_ISLAND, CinnabarIsland, -2, 0, 11
	connection east, ROUTE_19, Route19, -3, 17, 12

	map_header_2 Route19, ROUTE_19, $43, NORTH | WEST
	connection north, FUCHSIA_CITY, FuchsiaCity, 0, 0, 13
	connection west, ROUTE_20, Route20, 20, 0, 9

	map_header_2 FuchsiaCity, FUCHSIA_CITY, $f, SOUTH | WEST | EAST
	connection south, ROUTE_19, Route19, 0, 0, 10
	connection west, ROUTE_18_EAST, Route18East, 7, 0, 11
	connection east, ROUTE_15, Route15, 9, 0, 9

	map_header_2 Route18East, ROUTE_18_EAST, $43, WEST | EAST
	connection west, ROUTE_18_WEST, Route18West, 0, 0, 11
	connection east, FUCHSIA_CITY, FuchsiaCity, -3, 4, 14

	map_header_2 Route18West, ROUTE_18_WEST, $43, NORTH | WEST | EAST
	connection north, ROUTE_17, Route17, 0, 0, 10
	connection west, URAGA_CHANNEL_EAST, UragaChannelEast, 0, 0, 9
	connection east, ROUTE_18_EAST, Route18East, 0, 0, 11

	map_header_2 UragaChannelEast, URAGA_CHANNEL_EAST, $43, WEST | EAST
	connection west, URAGA_CHANNEL_WEST, UragaChannelWest, 0, 0, 9
	connection east, ROUTE_18_WEST, Route18West, 0, 0, 9

	map_header_2 UragaChannelWest, URAGA_CHANNEL_WEST, $43, WEST | EAST
	connection west, ROUTE_21, Route21, -3, 16, 15
	connection east, URAGA_CHANNEL_EAST, UragaChannelEast, 0, 0, 9

	map_header_2 Route17, ROUTE_17, $43, NORTH | SOUTH
	connection north, ROUTE_16_SOUTH, Route16South, 0, 0, 10
	connection south, ROUTE_18_WEST, Route18West, 0, 0, 10

	map_header_2 Route16South, ROUTE_16_SOUTH, $f, SOUTH
	connection south, ROUTE_17, Route17, 0, 0, 10

	map_header_2 Route16Northeast, ROUTE_16_NORTHEAST, $f, WEST | EAST
	connection west, ROUTE_16_WEST, Route16West, 0, 0, 11
	connection east, CELADON_CITY, CeladonCity, -3, 7, 10

	map_header_2 Route16Northwest, ROUTE_16_NORTHWEST, $f, WEST | EAST
	connection west, ROUTE_16_WEST, Route16West, 0, 0, 11
	connection east, CELADON_CITY, CeladonCity, -3, 7, 10

	map_header_2 Route16West, ROUTE_16_WEST, $f, WEST | EAST
	connection west, ROUTE_2_SOUTH, Route2South, -3, 5, 10
	connection east, ROUTE_16_NORTHWEST, Route16Northwest, 0, 0, 11

	map_header_2 CeladonCity, CELADON_CITY, $f, WEST | EAST
	connection west, ROUTE_16_NORTHEAST, Route16Northeast, 10, 0, 8
	connection east, ROUTE_7, Route7, 5, 0, 9

	map_header_2 Route7, ROUTE_7, $f, NORTH | WEST | EAST
	connection north, CELADON_OUTSKIRTS, CeladonOutskirts, 0, 0, 10
	connection west, CELADON_CITY, CeladonCity, -3, 2, 15
	connection east, SAFFRON_CITY, SaffronCity, -3, 3, 12

	map_header_2 LuckyIsland, LUCKY_ISLAND, $43, NORTH | WEST
	connection north, ROUTE_13_EAST, Route13East, 0, 0, 23
	connection west, ROUTE_14, Route14, 0, 0, 17

	map_header_2 Route15, ROUTE_15, $f, WEST | EAST
	connection west, FUCHSIA_CITY, FuchsiaCity, -3, 6, 12
	connection east, ROUTE_14, Route14, -3, 7, 12

	map_header_2 Route14, ROUTE_14, $43, NORTH | WEST | EAST
	connection north, ROUTE_13_WEST, Route13West, 0, 0, 12
	connection west, ROUTE_15, Route15, 10, 0, 9
	connection east, LUCKY_ISLAND, LuckyIsland, 0, 0, 15

	map_header_2 Route13East, ROUTE_13_EAST, $43, NORTH | SOUTH | WEST
	connection north, ROUTE_12_SOUTH, Route12South, 13, 0, 10
	connection south, LUCKY_ISLAND, LuckyIsland, 0, 0, 23
	connection west, ROUTE_13_WEST, Route13West, 0, 0, 10

	map_header_2 Route13West, ROUTE_13_WEST, $43, SOUTH | EAST
	connection south, ROUTE_14, Route14, 0, 0, 12
	connection east, ROUTE_13_EAST, Route13East, 0, 0, 10

	map_header_2 Route12North, ROUTE_12_NORTH, $43, NORTH | SOUTH
	connection north, LAVENDER_TOWN, LavenderTown, 0, 0, 10
	connection south, ROUTE_12_SOUTH, Route12South, 0, 0, 10

	map_header_2 Route12South, ROUTE_12_SOUTH, $43, NORTH | SOUTH | WEST
	connection north, ROUTE_12_NORTH, Route12North, 0, 0, 10
	connection south, ROUTE_13_EAST, Route13East, 0, 13, 10
	connection west, ROUTE_11, Route11, 17, 0, 9

	map_header_2 Route11, ROUTE_11, $f, WEST | EAST
	connection west, VERMILION_CITY, VermilionCity, -3, 2, 15
	connection east, ROUTE_12_SOUTH, Route12South, -3, 14, 15

	map_header_2 LavenderTown, LAVENDER_TOWN, $2c, NORTH | SOUTH | WEST
	connection north, ROUTE_10_SOUTH, Route10South, 0, 0, 10
	connection south, ROUTE_12_NORTH, Route12North, 0, 0, 10
	connection west, ROUTE_8, Route8, 0, 0, 11

	map_header_2 VermilionCity, VERMILION_CITY, $43, NORTH | EAST
	connection north, ROUTE_6, Route6, 3, 0, 15
	connection east, ROUTE_11, Route11, 5, 0, 9

	map_header_2 Route6, ROUTE_6, $f, NORTH | SOUTH
	connection north, SAFFRON_CITY, SaffronCity, -3, 0, 18
	connection south, VERMILION_CITY, VermilionCity, -3, 0, 18

	map_header_2 SaffronCity, SAFFRON_CITY, $f, NORTH | SOUTH | WEST | EAST
	connection north, ROUTE_5, Route5, 5, 0, 10
	connection south, ROUTE_6, Route6, 3, 0, 15
	connection west, ROUTE_7, Route7, 6, 0, 9
	connection east, ROUTE_8, Route8, 4, 0, 11

	map_header_2 Route5, ROUTE_5, $f, NORTH | SOUTH
	connection north, CERULEAN_CITY, CeruleanCity, -3, 2, 16
	connection south, SAFFRON_CITY, SaffronCity, -3, 2, 16

	map_header_2 CeruleanCity, CERULEAN_CITY, $f, NORTH | SOUTH | WEST | EAST
	connection north, ROUTE_24, Route24, 0, 0, 14
	connection south, ROUTE_5, Route5, 5, 0, 10
	connection west, ROUTE_4, Route4, 2, 0, 10
	connection east, ROUTE_9, Route9, 4, 0, 9

	map_header_2 Route24, ROUTE_24, $2c, SOUTH | EAST
	connection south, CERULEAN_CITY, CeruleanCity, 0, 0, 14
	connection east, ROUTE_25, Route25, 0, 0, 21

	map_header_2 Route25, ROUTE_25, $2c, WEST | EAST
	connection west, ROUTE_24, Route24, 0, 0, 20
	connection east, CERULEAN_CAPE, CeruleanCape, 0, 0, 19

	map_header_2 CeruleanCape, CERULEAN_CAPE, $2c, WEST
	connection west, ROUTE_25, Route25, 0, 0, 20

	map_header_2 Route3, ROUTE_3, $2c, WEST
	connection west, PEWTER_CITY, PewterCity, -3, 2, 15

	map_header_2 Route4, ROUTE_4, $2c, EAST
	connection east, CERULEAN_CITY, CeruleanCity, -2, 0, 16

	map_header_2 Route8, ROUTE_8, $2c, WEST | EAST
	connection west, SAFFRON_CITY, SaffronCity, -2, 2, 14
	connection east, LAVENDER_TOWN, LavenderTown, 0, 0, 10

	map_header_2 Route9, ROUTE_9, $2c, WEST | EAST
	connection west, CERULEAN_CITY, CeruleanCity, -3, 1, 12
	connection east, ROUTE_10_NORTH, Route10North, 0, 6, 12

	map_header_2 Route10North, ROUTE_10_NORTH, $2c, SOUTH | WEST
	connection south, ROUTE_10_SOUTH, Route10South, 0, 0, 10
	connection west, ROUTE_9, Route9, 6, 0, 12

	map_header_2 Route10South, ROUTE_10_SOUTH, $2c, NORTH | SOUTH
	connection north, ROUTE_10_NORTH, Route10North, 0, 0, 10
	connection south, LAVENDER_TOWN, LavenderTown, 0, 0, 10

	map_header_2 Route47, ROUTE_47, $35, NORTH
	connection north, ROUTE_48, Route48, 0, 0, 36

	map_header_2 Route48, ROUTE_48, $35, SOUTH
	connection south, ROUTE_47, Route47, 0, 0, 36

	map_header_2 CherrygroveBay, CHERRYGROVE_BAY, $35, SOUTH | WEST | EAST
	connection south, ROUTE_32_COAST, Route32Coast, 0, 0, 15
	connection west, ROUTE_32, Route32, -2, 10, 26
	connection east, CHERRYGROVE_CITY, CherrygroveCity, 15, 0, 10

	map_header_2 Route32Coast, ROUTE_32_COAST, $35, NORTH
	connection north, CHERRYGROVE_BAY, CherrygroveBay, 0, 0, 15

	map_header_2 VioletOutskirts, VIOLET_OUTSKIRTS, $5, NORTH | SOUTH
	connection north, ROUTE_42, Route42, -3, 2, 20
	connection south, VIOLET_CITY, VioletCity, 0, 0, 20

	map_header_2 GoldenrodHarbor, GOLDENROD_HARBOR, $35, NORTH | WEST
	connection north, ROUTE_35_COAST, Route35Coast, 0, 0, 24
	connection west, ROUTE_41, Route41, -3, 0, 20

	map_header_2 MagnetTunnelEast, MAGNET_TUNNEL_EAST, $5, EAST
	connection east, ROUTE_32, Route32, -1, 8, 13

	map_header_2 MagnetTunnelWest, MAGNET_TUNNEL_WEST, $5, WEST
	connection west, GOLDENROD_CITY, GoldenrodCity, 0, 0, 11

	map_header_2 CeladonOutskirts, CELADON_OUTSKIRTS, $f, SOUTH
	connection south, ROUTE_7, Route7, 0, 0, 10

	map_header_2 Route23, ROUTE_23, $f, NORTH
	connection north, INDIGO_PLATEAU, IndigoPlateau, 0, 0, 10

	map_header_2 IndigoPlateau, INDIGO_PLATEAU, $2c, SOUTH
	connection south, ROUTE_23, Route23, 0, 0, 10

	map_header_2 ShamoutiIsland, SHAMOUTI_ISLAND, $35, NORTH | EAST
	connection north, ROCKY_BEACH, RockyBeach, 0, 0, 18
	connection east, BEAUTIFUL_BEACH, BeautifulBeach, 0, 0, 15

	map_header_2 BeautifulBeach, BEAUTIFUL_BEACH, $35, WEST
	connection west, SHAMOUTI_ISLAND, ShamoutiIsland, 0, 0, 15

	map_header_2 WarmBeach, WARM_BEACH, $35, SOUTH
	connection south, SHAMOUTI_COAST, ShamoutiCoast, 0, 0, 12

	map_header_2 ShamoutiCoast, SHAMOUTI_COAST, $35, NORTH
	connection north, WARM_BEACH, WarmBeach, 0, 0, 12

	map_header_2 RockyBeach, ROCKY_BEACH, $35, SOUTH
	connection south, SHAMOUTI_ISLAND, ShamoutiIsland, 0, 0, 18

	map_header_2 ValenciaIsland, VALENCIA_ISLAND, $0, WEST
	connection west, ROUTE_49, Route49, 0, 2, 9

	map_header_2 Route49, ROUTE_49, $0, EAST
	connection east, VALENCIA_ISLAND, ValenciaIsland, 2, 0, 9

	map_header_2 SproutTower1F, SPROUT_TOWER_1F, $0, 0
	map_header_2 SproutTower2F, SPROUT_TOWER_2F, $0, 0
	map_header_2 SproutTower3F, SPROUT_TOWER_3F, $0, 0
	map_header_2 TinTower1F, TIN_TOWER_1F, $0, 0
	map_header_2 TinTower2F, TIN_TOWER_2F, $0, 0
	map_header_2 TinTower3F, TIN_TOWER_3F, $0, 0
	map_header_2 TinTower4F, TIN_TOWER_4F, $0, 0
	map_header_2 TinTower5F, TIN_TOWER_5F, $0, 0
	map_header_2 TinTower6F, TIN_TOWER_6F, $0, 0
	map_header_2 TinTower7F, TIN_TOWER_7F, $0, 0
	map_header_2 TinTower8F, TIN_TOWER_8F, $0, 0
	map_header_2 TinTower9F, TIN_TOWER_9F, $0, 0
	map_header_2 TinTower10F, TIN_TOWER_10F, $0, 0
	map_header_2 BurnedTower1F, BURNED_TOWER_1F, $0, 0
	map_header_2 BurnedTowerB1F, BURNED_TOWER_B1F, $9, 0
	map_header_2 NationalPark, NATIONAL_PARK, $0, 0
	map_header_2 NationalParkBugContest, NATIONAL_PARK_BUG_CONTEST, $0, 0
	map_header_2 RadioTower1F, RADIO_TOWER_1F, $0, 0
	map_header_2 RadioTower2F, RADIO_TOWER_2F, $0, 0
	map_header_2 RadioTower3F, RADIO_TOWER_3F, $0, 0
	map_header_2 RadioTower4F, RADIO_TOWER_4F, $0, 0
	map_header_2 RadioTower5F, RADIO_TOWER_5F, $0, 0
	map_header_2 RuinsofAlphOutside, RUINS_OF_ALPH_OUTSIDE, $5, 0
	map_header_2 RuinsofAlphHoOhChamber, RUINS_OF_ALPH_HO_OH_CHAMBER, $0, 0
	map_header_2 RuinsofAlphKabutoChamber, RUINS_OF_ALPH_KABUTO_CHAMBER, $0, 0
	map_header_2 RuinsofAlphOmanyteChamber, RUINS_OF_ALPH_OMANYTE_CHAMBER, $0, 0
	map_header_2 RuinsofAlphAerodactylChamber, RUINS_OF_ALPH_AERODACTYL_CHAMBER, $0, 0
	map_header_2 RuinsofAlphEntranceChamber, RUINS_OF_ALPH_ENTRANCE_CHAMBER, $0, 0
	map_header_2 RuinsofAlphInnerChamber, RUINS_OF_ALPH_INNER_CHAMBER, $0, 0
	map_header_2 RuinsofAlphResearchCenter, RUINS_OF_ALPH_RESEARCH_CENTER, $0, 0
	map_header_2 RuinsofAlphHoOhItemRoom, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, $0, 0
	map_header_2 RuinsofAlphKabutoItemRoom, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, $0, 0
	map_header_2 RuinsofAlphOmanyteItemRoom, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, $0, 0
	map_header_2 RuinsofAlphAerodactylItemRoom, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, $0, 0
	map_header_2 RuinsofAlphHoOhWordRoom, RUINS_OF_ALPH_HO_OH_WORD_ROOM, $0, 0
	map_header_2 RuinsofAlphKabutoWordRoom, RUINS_OF_ALPH_KABUTO_WORD_ROOM, $0, 0
	map_header_2 RuinsofAlphOmanyteWordRoom, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, $0, 0
	map_header_2 RuinsofAlphAerodactylWordRoom, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, $0, 0
	map_header_2 RuinsofAlphSinjohChamber, RUINS_OF_ALPH_SINJOH_CHAMBER, $0, 0
	map_header_2 Route22Past, ROUTE_22_PAST, $2c, 0
	map_header_2 UnionCave1F, UNION_CAVE_1F, $9, 0
	map_header_2 UnionCaveB1FNorth, UNION_CAVE_B1F_NORTH, $9, 0
	map_header_2 UnionCaveB1FSouth, UNION_CAVE_B1F_SOUTH, $9, 0
	map_header_2 UnionCaveB2F, UNION_CAVE_B2F, $9, 0
	map_header_2 SlowpokeWellB1F, SLOWPOKE_WELL_B1F, $9, 0
	map_header_2 SlowpokeWellB2F, SLOWPOKE_WELL_B2F, $9, 0
	map_header_2 OlivineLighthouse1F, OLIVINE_LIGHTHOUSE_1F, $0, 0
	map_header_2 OlivineLighthouse2F, OLIVINE_LIGHTHOUSE_2F, $0, 0
	map_header_2 OlivineLighthouse3F, OLIVINE_LIGHTHOUSE_3F, $0, 0
	map_header_2 OlivineLighthouse4F, OLIVINE_LIGHTHOUSE_4F, $0, 0
	map_header_2 OlivineLighthouse5F, OLIVINE_LIGHTHOUSE_5F, $0, 0
	map_header_2 OlivineLighthouse6F, OLIVINE_LIGHTHOUSE_6F, $0, 0
	map_header_2 OlivineLighthouseRoof, OLIVINE_LIGHTHOUSE_ROOF, $c, 0
	map_header_2 MahoganyMart1F, MAHOGANY_MART_1F, $0, 0
	map_header_2 TeamRocketBaseB1F, TEAM_ROCKET_BASE_B1F, $0, 0
	map_header_2 TeamRocketBaseB2F, TEAM_ROCKET_BASE_B2F, $0, 0
	map_header_2 TeamRocketBaseB3F, TEAM_ROCKET_BASE_B3F, $0, 0
	map_header_2 IlexForest, ILEX_FOREST, $35, 0
	map_header_2 MurkySwamp, MURKY_SWAMP, $35, 0
	map_header_2 MagnetTunnelInside, MAGNET_TUNNEL_INSIDE, $9, 0
	map_header_2 WarehouseEntrance, WAREHOUSE_ENTRANCE, $0, 0
	map_header_2 UndergroundPathSwitchRoomEntrances, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, $0, 0
	map_header_2 GoldenrodDeptStoreB1F, GOLDENROD_DEPT_STORE_B1F, $0, 0
	map_header_2 UndergroundWarehouse, UNDERGROUND_WAREHOUSE, $0, 0
	map_header_2 MountMortar1FOutside, MOUNT_MORTAR_1F_OUTSIDE, $9, 0
	map_header_2 MountMortar1FInside, MOUNT_MORTAR_1F_INSIDE, $9, 0
	map_header_2 MountMortar2FInside, MOUNT_MORTAR_2F_INSIDE, $9, 0
	map_header_2 MountMortarB1F, MOUNT_MORTAR_B1F, $9, 0
	map_header_2 IcePath1F, ICE_PATH_1F, $9, 0
	map_header_2 IcePathB1F, ICE_PATH_B1F, $19, 0
	map_header_2 IcePathB2FMahoganySide, ICE_PATH_B2F_MAHOGANY_SIDE, $19, 0
	map_header_2 IcePathB2FBlackthornSide, ICE_PATH_B2F_BLACKTHORN_SIDE, $19, 0
	map_header_2 IcePathB3F, ICE_PATH_B3F, $19, 0
	map_header_2 WhirlIslandNW, WHIRL_ISLAND_NW, $9, 0
	map_header_2 WhirlIslandNE, WHIRL_ISLAND_NE, $9, 0
	map_header_2 WhirlIslandSW, WHIRL_ISLAND_SW, $9, 0
	map_header_2 WhirlIslandCave, WHIRL_ISLAND_CAVE, $9, 0
	map_header_2 WhirlIslandSE, WHIRL_ISLAND_SE, $f, 0
	map_header_2 WhirlIslandB1F, WHIRL_ISLAND_B1F, $9, 0
	map_header_2 WhirlIslandB2F, WHIRL_ISLAND_B2F, $2e, 0
	map_header_2 WhirlIslandLugiaChamber, WHIRL_ISLAND_LUGIA_CHAMBER, $f, 0
	map_header_2 SilverCaveRoom1, SILVER_CAVE_ROOM_1, $9, 0
	map_header_2 SilverCaveRoom2, SILVER_CAVE_ROOM_2, $9, 0
	map_header_2 SilverCaveRoom3, SILVER_CAVE_ROOM_3, $0, 0
	map_header_2 SilverCaveItemRooms, SILVER_CAVE_ITEM_ROOMS, $9, 0
	map_header_2 DarkCaveVioletEntrance, DARK_CAVE_VIOLET_ENTRANCE, $9, 0
	map_header_2 DarkCaveBlackthornEntrance, DARK_CAVE_BLACKTHORN_ENTRANCE, $9, 0
	map_header_2 DragonsDen1F, DRAGONS_DEN_1F, $9, 0
	map_header_2 DragonsDenB1F, DRAGONS_DEN_B1F, $71, 0
	map_header_2 DragonShrine, DRAGON_SHRINE, $0, 0
	map_header_2 TohjoFalls, TOHJO_FALLS, $9, 0
	map_header_2 GiovannisCave, GIOVANNIS_CAVE, $9, 0
	map_header_2 OlivinePokeCenter1F, OLIVINE_POKECENTER_1F, $0, 0
	map_header_2 OlivineGym, OLIVINE_GYM, $0, 0
	map_header_2 OlivineTimsHouse, OLIVINE_TIMS_HOUSE, $0, 0
	map_header_2 OlivinePunishmentSpeechHouse, OLIVINE_PUNISHMENT_SPEECH_HOUSE, $0, 0
	map_header_2 OlivineGoodRodHouse, OLIVINE_GOOD_ROD_HOUSE, $0, 0
	map_header_2 OlivineCafe, OLIVINE_CAFE, $0, 0
	map_header_2 OlivineMart, OLIVINE_MART, $0, 0
	map_header_2 Route38EcruteakGate, ROUTE_38_ECRUTEAK_GATE, $0, 0
	map_header_2 Route39Barn, ROUTE_39_BARN, $0, 0
	map_header_2 Route39Farmhouse, ROUTE_39_FARMHOUSE, $0, 0
	map_header_2 MahoganyRedGyaradosSpeechHouse, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, $0, 0
	map_header_2 MahoganyGym, MAHOGANY_GYM, $0, 0
	map_header_2 MahoganyPokeCenter1F, MAHOGANY_POKECENTER_1F, $0, 0
	map_header_2 Route42EcruteakGate, ROUTE_42_ECRUTEAK_GATE, $0, 0
	map_header_2 DiglettsCave, DIGLETTS_CAVE, $9, 0
	map_header_2 MountMoon1F, MOUNT_MOON_1F, $9, 0
	map_header_2 MountMoonB1F, MOUNT_MOON_B1F, $9, 0
	map_header_2 MountMoonB2F, MOUNT_MOON_B2F, $9, 0
	map_header_2 Underground, UNDERGROUND, $0, 0
	map_header_2 RockTunnel1F, ROCK_TUNNEL_1F, $9, 0
	map_header_2 RockTunnelB1F, ROCK_TUNNEL_B1F, $9, 0
	map_header_2 RockTunnel2F, ROCK_TUNNEL_2F, $9, 0
	map_header_2 VictoryRoad1F, VICTORY_ROAD_1F, $9, 0
	map_header_2 VictoryRoad2F, VICTORY_ROAD_2F, $9, 0
	map_header_2 VictoryRoad3F, VICTORY_ROAD_3F, $9, 0
	map_header_2 EcruteakHouse, ECRUTEAK_HOUSE, $0, 0
	map_header_2 WiseTriosRoom, WISE_TRIOS_ROOM, $0, 0
	map_header_2 EcruteakPokeCenter1F, ECRUTEAK_POKECENTER_1F, $0, 0
	map_header_2 EcruteakLugiaSpeechHouse, ECRUTEAK_LUGIA_SPEECH_HOUSE, $0, 0
	map_header_2 DanceTheatre, DANCE_THEATRE, $0, 0
	map_header_2 EcruteakMart, ECRUTEAK_MART, $0, 0
	map_header_2 EcruteakGym, ECRUTEAK_GYM, $0, 0
	map_header_2 EcruteakItemfinderHouse, ECRUTEAK_ITEMFINDER_HOUSE, $0, 0
	map_header_2 ValeriesHouse, VALERIES_HOUSE, $0, 0
	map_header_2 EcruteakCherishBallHouse, ECRUTEAK_CHERISH_BALL_HOUSE, $0, 0
	map_header_2 EcruteakDestinyKnotHouse, ECRUTEAK_DESTINY_KNOT_HOUSE, $0, 0
	map_header_2 EcruteakShrineOutside, ECRUTEAK_SHRINE_OUTSIDE, $5, 0
	map_header_2 EcruteakShrineInside, ECRUTEAK_SHRINE_INSIDE, $0, 0
	map_header_2 BlackthornGym1F, BLACKTHORN_GYM_1F, $0, 0
	map_header_2 BlackthornGym2F, BLACKTHORN_GYM_2F, $0, 0
	map_header_2 BlackthornDragonSpeechHouse, BLACKTHORN_DRAGON_SPEECH_HOUSE, $0, 0
	map_header_2 BlackthornEmysHouse, BLACKTHORN_EMYS_HOUSE, $0, 0
	map_header_2 BlackthornMart, BLACKTHORN_MART, $0, 0
	map_header_2 BlackthornPokeCenter1F, BLACKTHORN_POKECENTER_1F, $0, 0
	map_header_2 MoveDeletersHouse, MOVE_DELETERS_HOUSE, $0, 0
	map_header_2 CinnabarPokeCenter1F, CINNABAR_POKECENTER_1F, $0, 0
	map_header_2 Route19FuchsiaGate, ROUTE_19_FUCHSIA_GATE, $0, 0
	map_header_2 SeafoamIslands1F, SEAFOAM_ISLANDS_1F, $9, 0
	map_header_2 SeafoamGym, SEAFOAM_GYM, $9, 0
	map_header_2 SeafoamIslandsB1F, SEAFOAM_ISLANDS_B1F, $9, 0
	map_header_2 SeafoamIslandsB2F, SEAFOAM_ISLANDS_B2F, $9, 0
	map_header_2 SeafoamIslandsB3F, SEAFOAM_ISLANDS_B3F, $9, 0
	map_header_2 SeafoamIslandsB4F, SEAFOAM_ISLANDS_B4F, $9, 0
	map_header_2 CeruleanGymBadgeSpeechHouse, CERULEAN_GYM_BADGE_SPEECH_HOUSE, $0, 0
	map_header_2 CeruleanPoliceStation, CERULEAN_POLICE_STATION, $0, 0
	map_header_2 CeruleanTradeSpeechHouse, CERULEAN_TRADE_SPEECH_HOUSE, $0, 0
	map_header_2 CeruleanPokeCenter1F, CERULEAN_POKECENTER_1F, $0, 0
	map_header_2 CeruleanGym, CERULEAN_GYM, $0, 0
	map_header_2 CeruleanMart, CERULEAN_MART, $0, 0
	map_header_2 CeruleanBikeShop, CERULEAN_BIKE_SHOP, $0, 0
	map_header_2 CeruleanBerryPowderHouse, CERULEAN_BERRY_POWDER_HOUSE, $0, 0
	map_header_2 CeruleanCoupleHouse, CERULEAN_COUPLE_HOUSE, $0, 0
	map_header_2 CeruleanWaterShowSpeechHouse, CERULEAN_WATER_SHOW_SPEECH_HOUSE, $0, 0
	map_header_2 Route3PokeCenter1F, ROUTE_3_POKECENTER_1F, $0, 0
	map_header_2 Route10PokeCenter1F, ROUTE_10_POKECENTER_1F, $0, 0
	map_header_2 PowerPlant, POWER_PLANT, $0, 0
	map_header_2 BillsHouse, BILLS_HOUSE, $0, 0
	map_header_2 AzaleaPokeCenter1F, AZALEA_POKECENTER_1F, $0, 0
	map_header_2 CharcoalKiln, CHARCOAL_KILN, $0, 0
	map_header_2 AzaleaMart, AZALEA_MART, $0, 0
	map_header_2 KurtsHouse, KURTS_HOUSE, $0, 0
	map_header_2 AzaleaGym, AZALEA_GYM, $0, 0
	map_header_2 LakeofRageHiddenPowerHouse, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, $0, 0
	map_header_2 LakeofRageMagikarpHouse, LAKE_OF_RAGE_MAGIKARP_HOUSE, $0, 0
	map_header_2 Route43MahoganyGate, ROUTE_43_MAHOGANY_GATE, $0, 0
	map_header_2 Route43Gate, ROUTE_43_GATE, $0, 0
	map_header_2 SinjohRuins, SINJOH_RUINS, $d9, 0
	map_header_2 SinjohRuinsHouse, SINJOH_RUINS_HOUSE, $0, 0
	map_header_2 MystriStage, MYSTRI_STAGE, $0, 0
	map_header_2 EmbeddedTower, EMBEDDED_TOWER, $0, 0
	map_header_2 VioletMart, VIOLET_MART, $0, 0
	map_header_2 VioletGym, VIOLET_GYM, $0, 0
	map_header_2 EarlsPokemonAcademy, EARLS_POKEMON_ACADEMY, $0, 0
	map_header_2 VioletNicknameSpeechHouse, VIOLET_NICKNAME_SPEECH_HOUSE, $0, 0
	map_header_2 VioletPokeCenter1F, VIOLET_POKECENTER_1F, $0, 0
	map_header_2 VioletOnixTradeHouse, VIOLET_ONIX_TRADE_HOUSE, $0, 0
	map_header_2 Route32RuinsofAlphGate, ROUTE_32_RUINS_OF_ALPH_GATE, $0, 0
	map_header_2 Route32PokeCenter1F, ROUTE_32_POKECENTER_1F, $0, 0
	map_header_2 Route32CoastHouse, ROUTE_32_COAST_HOUSE, $0, 0
	map_header_2 Route35GoldenrodGate, ROUTE_35_GOLDENROD_GATE, $0, 0
	map_header_2 Route35NationalParkGate, ROUTE_35_NATIONAL_PARK_GATE, $0, 0
	map_header_2 Route36RuinsofAlphGate, ROUTE_36_RUINS_OF_ALPH_GATE, $0, 0
	map_header_2 Route36NationalParkGate, ROUTE_36_NATIONAL_PARK_GATE, $0, 0
	map_header_2 Route36VioletGate, ROUTE_36_VIOLET_GATE, $0, 0
	map_header_2 GoldenrodGym, GOLDENROD_GYM, $0, 0
	map_header_2 GoldenrodBikeShop, GOLDENROD_BIKE_SHOP, $0, 0
	map_header_2 GoldenrodHappinessRater, GOLDENROD_HAPPINESS_RATER, $0, 0
	map_header_2 GoldenrodBillsHouse, GOLDENROD_BILLS_HOUSE, $0, 0
	map_header_2 GoldenrodMagnetTrainStation, GOLDENROD_MAGNET_TRAIN_STATION, $0, 0
	map_header_2 GoldenrodFlowerShop, GOLDENROD_FLOWER_SHOP, $0, 0
	map_header_2 GoldenrodPPSpeechHouse, GOLDENROD_PP_SPEECH_HOUSE, $0, 0
	map_header_2 GoldenrodNameRater, GOLDENROD_NAME_RATER, $0, 0
	map_header_2 GoldenrodDeptStore1F, GOLDENROD_DEPT_STORE_1F, $0, 0
	map_header_2 GoldenrodDeptStore2F, GOLDENROD_DEPT_STORE_2F, $0, 0
	map_header_2 GoldenrodDeptStore3F, GOLDENROD_DEPT_STORE_3F, $0, 0
	map_header_2 GoldenrodDeptStore4F, GOLDENROD_DEPT_STORE_4F, $0, 0
	map_header_2 GoldenrodDeptStore5F, GOLDENROD_DEPT_STORE_5F, $0, 0
	map_header_2 GoldenrodDeptStore6F, GOLDENROD_DEPT_STORE_6F, $0, 0
	map_header_2 GoldenrodDeptStoreElevator, GOLDENROD_DEPT_STORE_ELEVATOR, $0, 0
	map_header_2 GoldenrodDeptStoreRoof, GOLDENROD_DEPT_STORE_ROOF, $24, 0
	map_header_2 GoldenrodGameCorner, GOLDENROD_GAME_CORNER, $0, 0
	map_header_2 GoldenrodPokeComCenter1F, GOLDENROD_POKECOM_CENTER_1F, $0, 0
	map_header_2 GoldenrodPokeComCenterOffice, GOLDENROD_POKECOM_CENTER_OFFICE, $0, 0
	map_header_2 GoldenrodHarborGate, GOLDENROD_HARBOR_GATE, $0, 0
	map_header_2 IlexForestAzaleaGate, ILEX_FOREST_AZALEA_GATE, $0, 0
	map_header_2 Route34IlexForestGate, ROUTE_34_ILEX_FOREST_GATE, $0, 0
	map_header_2 DayCare, DAYCARE, $0, 0
	map_header_2 GoldenrodHPUpHouse, GOLDENROD_HP_UP_HOUSE, $0, 0
	map_header_2 GoldenrodNetBallHouse, GOLDENROD_NET_BALL_HOUSE, $0, 0
	map_header_2 GoldenrodBandHouse, GOLDENROD_BAND_HOUSE, $0, 0
	map_header_2 GoldenrodSpeechHouse, GOLDENROD_SPEECH_HOUSE, $0, 0
	map_header_2 VermilionHouseFishingSpeechHouse, VERMILION_HOUSE_FISHING_SPEECH_HOUSE, $0, 0
	map_header_2 VermilionPokeCenter1F, VERMILION_POKECENTER_1F, $0, 0
	map_header_2 PokemonFanClub, POKEMON_FAN_CLUB, $0, 0
	map_header_2 VermilionMagnetTrainSpeechHouse, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, $0, 0
	map_header_2 VermilionMart, VERMILION_MART, $0, 0
	map_header_2 VermilionHouseDiglettsCaveSpeechHouse, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE, $0, 0
	map_header_2 VermilionGym, VERMILION_GYM, $0, 0
	map_header_2 Route6SaffronGate, ROUTE_6_SAFFRON_GATE, $0, 0
	map_header_2 Route6UndergroundEntrance, ROUTE_6_UNDERGROUND_ENTRANCE, $0, 0
	map_header_2 Route11Gate, ROUTE_11_GATE, $0, 0
	map_header_2 Route11Gate2F, ROUTE_11_GATE_2F, $0, 0
	map_header_2 VermilionPollutionSpeechHouse, VERMILION_POLLUTION_SPEECH_HOUSE, $0, 0
	map_header_2 VermilionSSAnneSpeechHouse, VERMILION_S_S_ANNE_SPEECH_HOUSE, $0, 0
	map_header_2 RedsHouse1F, REDS_HOUSE_1F, $0, 0
	map_header_2 RedsHouse2F, REDS_HOUSE_2F, $0, 0
	map_header_2 BluesHouse1F, BLUES_HOUSE_1F, $0, 0
	map_header_2 BluesHouse2F, BLUES_HOUSE_2F, $0, 0
	map_header_2 OaksLab, OAKS_LAB, $0, 0
	map_header_2 PewterNidoranSpeechHouse, PEWTER_NIDORAN_SPEECH_HOUSE, $0, 0
	map_header_2 PewterGym, PEWTER_GYM, $0, 0
	map_header_2 PewterMart, PEWTER_MART, $0, 0
	map_header_2 PewterPokeCenter1F, PEWTER_POKECENTER_1F, $0, 0
	map_header_2 PewterSnoozeSpeechHouse, PEWTER_SNOOZE_SPEECH_HOUSE, $0, 0
	map_header_2 OlivinePort, OLIVINE_PORT, $a, 0
	map_header_2 VermilionPort, VERMILION_PORT, $a, 0
	map_header_2 FastShip1F, FAST_SHIP_1F, $0, 0
	map_header_2 FastShipCabins_NNW_NNE_NE, FAST_SHIP_CABINS_NNW_NNE_NE, $0, 0
	map_header_2 FastShipCabins_SW_SSW_NW, FAST_SHIP_CABINS_SW_SSW_NW, $0, 0
	map_header_2 FastShipCabins_SE_SSE_CaptainsCabin, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, $0, 0
	map_header_2 FastShipB1F, FAST_SHIP_B1F, $0, 0
	map_header_2 OlivinePortPassage, OLIVINE_PORT_PASSAGE, $0, 0
	map_header_2 VermilionPortPassage, VERMILION_PORT_PASSAGE, $0, 0
	map_header_2 MountMoonSquare, MOUNT_MOON_SQUARE, $2d, 0
	map_header_2 MountMoonGiftShop, MOUNT_MOON_GIFT_SHOP, $0, 0
	map_header_2 TinTowerRoof, TIN_TOWER_ROOF, $1, 0
	map_header_2 IndigoPlateauPokeCenter1F, INDIGO_PLATEAU_POKECENTER_1F, $0, 0
	map_header_2 WillsRoom, WILLS_ROOM, $0, 0
	map_header_2 KogasRoom, KOGAS_ROOM, $0, 0
	map_header_2 BrunosRoom, BRUNOS_ROOM, $0, 0
	map_header_2 KarensRoom, KARENS_ROOM, $0, 0
	map_header_2 LancesRoom, LANCES_ROOM, $0, 0
	map_header_2 HallOfFame, HALL_OF_FAME, $0, 0
	map_header_2 FuchsiaMart, FUCHSIA_MART, $0, 0
	map_header_2 FuchsiaGym, FUCHSIA_GYM, $0, 0
	map_header_2 FuchsiaBillSpeechHouse, FUCHSIA_BILL_SPEECH_HOUSE, $0, 0
	map_header_2 FuchsiaSafariBallHouse, FUCHSIA_SAFARI_BALL_HOUSE, $0, 0
	map_header_2 FuchsiaPokeCenter1F, FUCHSIA_POKECENTER_1F, $0, 0
	map_header_2 SafariZoneWardensHome, SAFARI_ZONE_WARDENS_HOME, $0, 0
	map_header_2 Route12Gate, ROUTE_12_GATE, $0, 0
	map_header_2 Route12Gate2F, ROUTE_12_GATE_2F, $0, 0
	map_header_2 Route15FuchsiaGate, ROUTE_15_FUCHSIA_GATE, $0, 0
	map_header_2 Route15FuchsiaGate2F, ROUTE_15_FUCHSIA_GATE_2F, $0, 0
	map_header_2 LavenderPokeCenter1F, LAVENDER_POKECENTER_1F, $0, 0
	map_header_2 MrFujisHouse, MR_FUJIS_HOUSE, $0, 0
	map_header_2 LavenderTownSpeechHouse, LAVENDER_TOWN_SPEECH_HOUSE, $0, 0
	map_header_2 LavenderNameRater, LAVENDER_NAME_RATER, $0, 0
	map_header_2 LavenderMart, LAVENDER_MART, $0, 0
	map_header_2 SoulHouse, SOUL_HOUSE, $0, 0
	map_header_2 SoulHouseB1F, SOUL_HOUSE_B1F, $0, 0
	map_header_2 SoulHouseB2F, SOUL_HOUSE_B2F, $0, 0
	map_header_2 SoulHouseB3F, SOUL_HOUSE_B3F, $0, 0
	map_header_2 LavRadioTower1F, LAV_RADIO_TOWER_1F, $0, 0
	map_header_2 LavRadioTower2F, LAV_RADIO_TOWER_2F, $0, 0
	map_header_2 LavRadioTower3F, LAV_RADIO_TOWER_3F, $0, 0
	map_header_2 LavRadioTower4F, LAV_RADIO_TOWER_3F, $0, 0
	map_header_2 LavRadioTower5F, LAV_RADIO_TOWER_5F, $0, 0
	map_header_2 HauntedRadioTower2F, HAUNTED_RADIO_TOWER_2F, $0, 0
	map_header_2 HauntedRadioTower3F, HAUNTED_RADIO_TOWER_3F, $0, 0
	map_header_2 HauntedRadioTower4F, HAUNTED_RADIO_TOWER_4F, $0, 0
	map_header_2 HauntedRadioTower5F, HAUNTED_RADIO_TOWER_5F, $0, 0
	map_header_2 HauntedRadioTower6F, HAUNTED_RADIO_TOWER_6F, $0, 0
	map_header_2 Route8SaffronGate, ROUTE_8_SAFFRON_GATE, $0, 0
	map_header_2 Route12SuperRodHouse, ROUTE_12_SUPER_ROD_HOUSE, $0, 0
	map_header_2 SilverCavePokeCenter1F, SILVER_CAVE_POKECENTER_1F, $0, 0
	map_header_2 Route28FamousSpeechHouse, ROUTE_28_FAMOUS_SPEECH_HOUSE, $0, 0
	map_header_2 PokeCenter2F, POKECENTER_2F, $0, 0
	map_header_2 TradeCenter, TRADE_CENTER, $0, 0
	map_header_2 Colosseum, COLOSSEUM, $0, 0
	map_header_2 HiddenTreeGrotto, HIDDEN_TREE_GROTTO, $35, 0
	map_header_2 HiddenCaveGrotto, HIDDEN_CAVE_GROTTO, $9, 0
	map_header_2 CeladonDeptStore1F, CELADON_DEPT_STORE_1F, $0, 0
	map_header_2 CeladonDeptStore2F, CELADON_DEPT_STORE_2F, $0, 0
	map_header_2 CeladonDeptStore3F, CELADON_DEPT_STORE_3F, $0, 0
	map_header_2 CeladonDeptStore4F, CELADON_DEPT_STORE_4F, $0, 0
	map_header_2 CeladonDeptStore5F, CELADON_DEPT_STORE_5F, $0, 0
	map_header_2 CeladonDeptStore6F, CELADON_DEPT_STORE_6F, $0, 0
	map_header_2 CeladonDeptStoreElevator, CELADON_DEPT_STORE_ELEVATOR, $0, 0
	map_header_2 CeladonMansion1F, CELADON_MANSION_1F, $0, 0
	map_header_2 CeladonMansion2F, CELADON_MANSION_2F, $0, 0
	map_header_2 CeladonMansion3F, CELADON_MANSION_3F, $0, 0
	map_header_2 CeladonMansionRoof, CELADON_MANSION_ROOF, $1, 0
	map_header_2 CeladonMansionRoofHouse, CELADON_MANSION_ROOF_HOUSE, $0, 0
	map_header_2 CeladonPokeCenter1F, CELADON_POKECENTER_1F, $0, 0
	map_header_2 CeladonGameCorner, CELADON_GAME_CORNER, $0, 0
	map_header_2 CeladonGameCornerPrizeRoom, CELADON_GAME_CORNER_PRIZE_ROOM, $0, 0
	map_header_2 CeladonGym, CELADON_GYM, $0, 0
	map_header_2 CeladonCafe, CELADON_CAFE, $0, 0
	map_header_2 CeladonChiefHouse, CELADON_CHIEF_HOUSE, $0, 0
	map_header_2 CeladonHotel1F, CELADON_HOTEL_1F, $0, 0
	map_header_2 CeladonHotel2F, CELADON_HOTEL_2F, $0, 0
	map_header_2 CeladonHotelRoom1, CELADON_HOTEL_ROOM_1, $0, 0
	map_header_2 CeladonHotelRoom2, CELADON_HOTEL_ROOM_2, $0, 0
	map_header_2 CeladonHotelRoom3, CELADON_HOTEL_ROOM_3, $0, 0
	map_header_2 CeladonHotelPool, CELADON_HOTEL_POOL, $0, 0
	map_header_2 EusinesHouse, EUSINES_HOUSE, $0, 0
	map_header_2 PsychicInversHouse, PSYCHIC_INVERS_HOUSE, $0, 0
	map_header_2 CeladonOldManSpeechHouse, CELADON_OLD_MAN_SPEECH_HOUSE, $0, 0
	map_header_2 CeladonDevelopmentSpeechHouse, CELADON_DEVELOPMENT_SPEECH_HOUSE, $0, 0
	map_header_2 Route16FuchsiaSpeechHouse, ROUTE_16_FUCHSIA_SPEECH_HOUSE, $0, 0
	map_header_2 Route16Gate, ROUTE_16_GATE, $0, 0
	map_header_2 Route1617Gate, ROUTE_16_17_GATE, $0, 0
	map_header_2 Route1617Gate2F, ROUTE_16_17_GATE_2F, $0, 0
	map_header_2 Route7SaffronGate, ROUTE_7_SAFFRON_GATE, $0, 0
	map_header_2 Route18Gate, ROUTE_18_GATE, $0, 0
	map_header_2 Route18Gate2F, ROUTE_18_GATE_2F, $0, 0
	map_header_2 CeladonHomeDecorStore1F, CELADON_HOME_DECOR_STORE_1F, $0, 0
	map_header_2 CeladonHomeDecorStore2F, CELADON_HOME_DECOR_STORE_2F, $0, 0
	map_header_2 CeladonHomeDecorStore3F, CELADON_HOME_DECOR_STORE_3F, $0, 0
	map_header_2 CeladonHomeDecorStore4F, CELADON_HOME_DECOR_STORE_4F, $0, 0
	map_header_2 CeladonUniversity1F, CELADON_UNIVERSITY_1F, $0, 0
	map_header_2 CeladonUniversity2F, CELADON_UNIVERSITY_2F, $0, 0
	map_header_2 CeladonUniversityLibrary1F, CELADON_UNIVERSITY_LIBRARY_1F, $0, 0
	map_header_2 CeladonUniversityLibrary2F, CELADON_UNIVERSITY_LIBRARY_2F, $0, 0
	map_header_2 CeladonUniversityPrincipalsOffice, CELADON_UNIVERSITY_PRINCIPALS_OFFICE, $0, 0
	map_header_2 CeladonUniversityWestwoodsOffice, CELADON_UNIVERSITY_WESTWOODS_OFFICE, $0, 0
	map_header_2 CeladonUniversityWillowsOffice, CELADON_UNIVERSITY_WILLOWS_OFFICE, $0, 0
	map_header_2 CeladonUniversityLounge, CELADON_UNIVERSITY_LOUNGE, $0, 0
	map_header_2 CeladonUniversityCafeteria, CELADON_UNIVERSITY_CAFETERIA, $0, 0
	map_header_2 CeladonUniversityHyperTestRoom, CELADON_UNIVERSITY_HYPER_TEST_ROOM, $0, 0
	map_header_2 CeladonUniversityPool, CELADON_UNIVERSITY_POOL, $0, 0
	map_header_2 CeladonUniversityClassroom1, CELADON_UNIVERSITY_CLASSROOM_1, $0, 0
	map_header_2 CeladonUniversityClassroom2, CELADON_UNIVERSITY_CLASSROOM_2, $0, 0
	map_header_2 CeladonUniversityClassroom3, CELADON_UNIVERSITY_CLASSROOM_3, $0, 0
	map_header_2 CeladonUniversityClassroom4, CELADON_UNIVERSITY_CLASSROOM_4, $0, 0
	map_header_2 ManiasHouse, MANIAS_HOUSE, $0, 0
	map_header_2 CianwoodGym, CIANWOOD_GYM, $0, 0
	map_header_2 CianwoodPokeCenter1F, CIANWOOD_POKECENTER_1F, $0, 0
	map_header_2 CianwoodPharmacy, CIANWOOD_PHARMACY, $0, 0
	map_header_2 CianwoodCityPhotoStudio, CIANWOOD_CITY_PHOTO_STUDIO, $0, 0
	map_header_2 CianwoodLugiaSpeechHouse, CIANWOOD_LUGIA_SPEECH_HOUSE, $0, 0
	map_header_2 StatsJudgesHouse, STATS_JUDGES_HOUSE, $0, 0
	map_header_2 BattleTower1F, BATTLE_TOWER_1F, $0, 0
	map_header_2 BattleTower2F, BATTLE_TOWER_2F, $0, 0
	map_header_2 BattleTowerBattleRoom, BATTLE_TOWER_BATTLE_ROOM, $0, 0
	map_header_2 BattleTowerElevator, BATTLE_TOWER_ELEVATOR, $0, 0
	map_header_2 BattleTowerHallway, BATTLE_TOWER_HALLWAY, $0, 0
	map_header_2 Route40BattleTowerGate, ROUTE_40_BATTLE_TOWER_GATE, $0, 0
	map_header_2 BattleTowerOutside, BATTLE_TOWER_OUTSIDE, $5, 0
	map_header_2 CliffEdgeGate, CLIFF_EDGE_GATE, $9, 0
	map_header_2 CliffCave, CLIFF_CAVE, $9, 0
	map_header_2 ViridianGym, VIRIDIAN_GYM, $0, 0
	map_header_2 ViridianNicknameSpeechHouse, VIRIDIAN_NICKNAME_SPEECH_HOUSE, $0, 0
	map_header_2 ViridianSchoolHouse, VIRIDIAN_SCHOOL_HOUSE, $0, 0
	map_header_2 TrainerHouse1F, TRAINER_HOUSE_1F, $0, 0
	map_header_2 TrainerHouseB1F, TRAINER_HOUSE_B1F, $0, 0
	map_header_2 ViridianMart, VIRIDIAN_MART, $0, 0
	map_header_2 ViridianPokeCenter1F, VIRIDIAN_POKECENTER_1F, $0, 0
	map_header_2 Route2NuggetSpeechHouse, ROUTE_2_NUGGET_SPEECH_HOUSE, $0, 0
	map_header_2 Route2Gate, ROUTE_2_GATE, $0, 0
	map_header_2 PokemonLeagueGate, POKEMON_LEAGUE_GATE, $0, 0
	map_header_2 ElmsLab, ELMS_LAB, $0, 0
	map_header_2 KrissHouse1F, KRISS_HOUSE_1F, $0, 0
	map_header_2 KrissHouse2F, KRISS_HOUSE_2F, $0, 0
	map_header_2 KrissNeighborsHouse, KRISS_NEIGHBORS_HOUSE, $0, 0
	map_header_2 LyrasHouse1F, LYRAS_HOUSE_1F, $0, 0
	map_header_2 LyrasHouse2F, LYRAS_HOUSE_2F, $0, 0
	map_header_2 ElmsHouse, ELMS_HOUSE, $0, 0
	map_header_2 Route26HealSpeechHouse, ROUTE_26_HEAL_SPEECH_HOUSE, $0, 0
	map_header_2 Route26DayofWeekSiblingsHouse, ROUTE_26_DAY_OF_WEEK_SIBLINGS_HOUSE, $0, 0
	map_header_2 Route27RestHouse, ROUTE_27_REST_HOUSE, $0, 0
	map_header_2 Route2946Gate, ROUTE_29_46_GATE, $0, 0
	map_header_2 FightingDojo, FIGHTING_DOJO, $0, 0
	map_header_2 SaffronGym, SAFFRON_GYM, $0, 0
	map_header_2 SaffronMart, SAFFRON_MART, $0, 0
	map_header_2 SaffronPokeCenter1F, SAFFRON_POKECENTER_1F, $0, 0
	map_header_2 MrPsychicsHouse, MR_PSYCHICS_HOUSE, $0, 0
	map_header_2 SaffronTrainStation, SAFFRON_TRAIN_STATION, $0, 0
	map_header_2 SilphCo1F, SILPH_CO_1F, $0, 0
	map_header_2 SilphCo2F, SILPH_CO_2F, $0, 0
	map_header_2 SilphCo3F, SILPH_CO_3F, $0, 0
	map_header_2 CopycatsHouse1F, COPYCATS_HOUSE_1F, $0, 0
	map_header_2 CopycatsHouse2F, COPYCATS_HOUSE_2F, $0, 0
	map_header_2 Route5UndergroundEntrance, ROUTE_5_UNDERGROUND_ENTRANCE, $0, 0
	map_header_2 Route5SaffronCityGate, ROUTE_5_SAFFRON_CITY_GATE, $0, 0
	map_header_2 Route5CleanseTagSpeechHouse, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE, $0, 0
	map_header_2 PokemonTrainerFanClub, POKEMON_TRAINER_FAN_CLUB, $0, 0
	map_header_2 SaffronHitmontopKidHouse, SAFFRON_HITMONTOP_KID_HOUSE, $0, 0
	map_header_2 SaffronBookSpeechHouse, SAFFRON_BOOK_SPEECH_HOUSE, $0, 0
	map_header_2 SaffronOrreSpeechHouse, SAFFRON_ORRE_SPEECH_HOUSE, $0, 0
	map_header_2 SaffronRichSpeechHouse, SAFFRON_RICH_SPEECH_HOUSE, $0, 0
	map_header_2 CherrygroveMart, CHERRYGROVE_MART, $0, 0
	map_header_2 CherrygrovePokeCenter1F, CHERRYGROVE_POKECENTER_1F, $0, 0
	map_header_2 CherrygroveGymSpeechHouse, CHERRYGROVE_GYM_SPEECH_HOUSE, $0, 0
	map_header_2 GuideGentsHouse, GUIDE_GENTS_HOUSE, $0, 0
	map_header_2 CherrygroveEvolutionSpeechHouse, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, $0, 0
	map_header_2 Route30BerrySpeechHouse, ROUTE_30_BERRY_SPEECH_HOUSE, $0, 0
	map_header_2 MrPokemonsHouse, MR_POKEMONS_HOUSE, $0, 0
	map_header_2 Route31VioletGate, ROUTE_31_VIOLET_GATE, $0, 0
	map_header_2 BellchimeTrail, BELLCHIME_TRAIL, $5, 0
	map_header_2 PewterMuseumOfScience1F, PEWTER_MUSEUM_OF_SCIENCE_1F, $0, 0
	map_header_2 PewterMuseumOfScience2F, PEWTER_MUSEUM_OF_SCIENCE_2F, $0, 0
	map_header_2 ViridianForest, VIRIDIAN_FOREST, $45, 0
	map_header_2 ViridianForestViridianGate, VIRIDIAN_FOREST_VIRIDIAN_GATE, $0, 0
	map_header_2 ViridianForestPewterGate, VIRIDIAN_FOREST_PEWTER_GATE, $0, 0
	map_header_2 Route1ViridianGate, ROUTE_1_VIRIDIAN_GATE, $0, 0
	map_header_2 CeruleanCave1F, CERULEAN_CAVE_1F, $9, 0
	map_header_2 CeruleanCave2F, CERULEAN_CAVE_2F, $9, 0
	map_header_2 CeruleanCaveB1F, CERULEAN_CAVE_B1F, $9, 0
	map_header_2 YellowForestGate, YELLOW_FOREST_GATE, $0, 0
	map_header_2 YellowForest, YELLOW_FOREST, $55, 0
	map_header_2 QuietCave1F, QUIET_CAVE_1F, $9, 0
	map_header_2 QuietCaveB1F, QUIET_CAVE_B1F, $9, 0
	map_header_2 QuietCaveB2F, QUIET_CAVE_B2F, $9, 0
	map_header_2 QuietCaveB3F, QUIET_CAVE_B3F, $9, 0
	map_header_2 DimCave1F, DIM_CAVE_1F, $9, 0
	map_header_2 DimCave2F, DIM_CAVE_2F, $9, 0
	map_header_2 DimCave3F, DIM_CAVE_3F, $9, 0
	map_header_2 DimCave4F, DIM_CAVE_4F, $9, 0
	map_header_2 DimCave5F, DIM_CAVE_5F, $9, 0
	map_header_2 CinnabarVolcano1F, CINNABAR_VOLCANO_1F, $9, 0
	map_header_2 CinnabarVolcanoB1F, CINNABAR_VOLCANO_B1F, $9, 0
	map_header_2 CinnabarVolcanoB2F, CINNABAR_VOLCANO_B2F, $9, 0
	map_header_2 SafariZoneFuchsiaGate, SAFARI_ZONE_FUCHSIA_GATE, $0, 0
	map_header_2 SafariZoneHub, SAFARI_ZONE_HUB, $0, 0
	map_header_2 SafariZoneEast, SAFARI_ZONE_EAST, $0, 0
	map_header_2 SafariZoneNorth, SAFARI_ZONE_NORTH, $0, 0
	map_header_2 SafariZoneWest, SAFARI_ZONE_WEST, $0, 0
	map_header_2 SafariZoneHubRestHouse, SAFARI_ZONE_HUB_REST_HOUSE, $0, 0
	map_header_2 SafariZoneEastRestHouse, SAFARI_ZONE_EAST_REST_HOUSE, $0, 0
	map_header_2 SafariZoneNorthRestHouse, SAFARI_ZONE_NORTH_REST_HOUSE, $0, 0
	map_header_2 SafariZoneWestRestHouse1, SAFARI_ZONE_WEST_REST_HOUSE_1, $0, 0
	map_header_2 SafariZoneWestRestHouse2, SAFARI_ZONE_WEST_REST_HOUSE_2, $0, 0
	map_header_2 NavelRockOutside, NAVEL_ROCK_OUTSIDE, $35, 0
	map_header_2 NavelRockInside, NAVEL_ROCK_INSIDE, $9, 0
	map_header_2 NavelRockRoof, NAVEL_ROCK_ROOF, $1, 0
	map_header_2 FarawayIsland, FARAWAY_ISLAND, $6, 0
	map_header_2 FarawayJungle, FARAWAY_JUNGLE, $17, 0
	map_header_2 SeagallopFerryVermilionGate, SEAGALLOP_FERRY_VERMILION_GATE, $0, 0
	map_header_2 SeagallopFerryNavelGate, SEAGALLOP_FERRY_NAVEL_GATE, $0, 0
	map_header_2 SeagallopFerryShamoutiGate, SEAGALLOP_FERRY_SHAMOUTI_GATE, $0, 0
	map_header_2 PokemonMansion1F, POKEMON_MANSION_1F, $0, 0
	map_header_2 PokemonMansionB1F, POKEMON_MANSION_B1F, $45, 0
	map_header_2 CinnabarLab, CINNABAR_LAB, $0, 0
	map_header_2 ScaryCave1F, SCARY_CAVE_1F, $9, 0
	map_header_2 ScaryCaveB1F, SCARY_CAVE_B1F, $9, 0
	map_header_2 ScaryCaveShipwreck, SCARY_CAVE_SHIPWRECK, $9, 0
	map_header_2 Route19BeachHouse, ROUTE_19_BEACH_HOUSE, $0, 0
	map_header_2 ShamoutiTunnel, SHAMOUTI_TUNNEL, $9, 0
	map_header_2 NoisyForest, NOISY_FOREST, $0, 0
	map_header_2 ShamoutiShrineRuins, SHAMOUTI_SHRINE_RUINS, $37, 0
	map_header_2 ShamoutiPokeCenter1F, SHAMOUTI_POKECENTER_1F, $0, 0
	map_header_2 ShamoutiHotel1F, SHAMOUTI_HOTEL_1F, $0, 0
	map_header_2 ShamoutiHotel2F, SHAMOUTI_HOTEL_2F, $0, 0
	map_header_2 ShamoutiHotel3F, SHAMOUTI_HOTEL_3F, $0, 0
	map_header_2 ShamoutiHotelRoom2A, SHAMOUTI_HOTEL_ROOM_2A, $0, 0
	map_header_2 ShamoutiHotelRoom2B, SHAMOUTI_HOTEL_ROOM_2B, $0, 0
	map_header_2 ShamoutiHotelRoom3B, SHAMOUTI_HOTEL_ROOM_3B, $0, 0
	map_header_2 ShamoutiHotelRoom3C, SHAMOUTI_HOTEL_ROOM_3C, $0, 0
	map_header_2 ShamoutiHotelRestaurant, SHAMOUTI_HOTEL_RESTAURANT, $0, 0
	map_header_2 ShamoutiTouristCenter, SHAMOUTI_TOURIST_CENTER, $0, 0
	map_header_2 ShamoutiMerchant, SHAMOUTI_MERCHANT, $0, 0
	map_header_2 ShamoutiHouse, SHAMOUTI_HOUSE, $0, 0
	map_header_2 BeautifulBeachVilla, BEAUTIFUL_BEACH_VILLA, $0, 0
	map_header_2 WarmBeachShack, WARM_BEACH_SHACK, $0, 0
	map_header_2 WarmBeachHouse, WARM_BEACH_HOUSE, $0, 0
	map_header_2 RockyBeachHouse, ROCKY_BEACH_HOUSE, $0, 0
	map_header_2 FireIsland, FIRE_ISLAND, $9, 0
	map_header_2 FireIslandRoof, FIRE_ISLAND_ROOF, $35, 0
	map_header_2 IceIsland, ICE_ISLAND, $9, 0
	map_header_2 IceIslandRoof, ICE_ISLAND_ROOF, $35, 0
	map_header_2 LightningIsland, LIGHTNING_ISLAND, $9, 0
	map_header_2 LightningIslandRoof, LIGHTNING_ISLAND_ROOF, $35, 0
	map_header_2 IvysLab, IVYS_LAB, $0, 0
	map_header_2 IvysHouse, IVYS_HOUSE, $0, 0
	map_header_2 ValenciaHouse, VALENCIA_HOUSE, $0, 0
	map_header_2 ValenciaPort, VALENCIA_PORT, $0, 0
