GROUP_N_A  EQU -1
MAP_N_A    EQU -1

GROUP_NONE EQU 0
MAP_NONE   EQU 0

; map group ids
	const_def
	newgroup                                                    ;  1

	mapgroup OLIVINE_POKECENTER_1F,                       4,  6 ;  1
	mapgroup OLIVINE_GYM,                                 8,  5 ;  2
	mapgroup OLIVINE_TIMS_HOUSE,                          4,  4 ;  3
	mapgroup OLIVINE_PUNISHMENT_SPEECH_HOUSE,             4,  4 ;  5
	mapgroup OLIVINE_GOOD_ROD_HOUSE,                      4,  4 ;  6
	mapgroup OLIVINE_CAFE,                                4,  5 ;  7
	mapgroup OLIVINE_MART,                                4,  6 ;  8
	mapgroup ROUTE_38_ECRUTEAK_GATE,                      4,  5 ;  9
	mapgroup ROUTE_39_BARN,                               4,  4 ; 10
	mapgroup ROUTE_39_FARMHOUSE,                          4,  4 ; 11
	mapgroup ROUTE_38,                                    9, 20 ; 12
	mapgroup ROUTE_39,                                   20, 10 ; 13
	mapgroup OLIVINE_CITY,                               16, 33 ; 14
	mapgroup ROUTE_35_COAST,                             14, 26 ; 15

	newgroup                                                    ;  2

	mapgroup MAHOGANY_RED_GYARADOS_SPEECH_HOUSE,          4,  4 ;  1
	mapgroup MAHOGANY_GYM,                                9,  5 ;  2
	mapgroup MAHOGANY_POKECENTER_1F,                      4,  6 ;  3
	mapgroup ROUTE_42_ECRUTEAK_GATE,                      4,  5 ;  4
	mapgroup ROUTE_42,                                    9, 30 ;  5
	mapgroup ROUTE_44,                                    9, 30 ;  6
	mapgroup MAHOGANY_TOWN,                               9, 10 ;  7

	newgroup                                                    ;  3

	mapgroup SPROUT_TOWER_1F,                             8,  8 ;  1
	mapgroup SPROUT_TOWER_2F,                             8,  8 ;  2
	mapgroup SPROUT_TOWER_3F,                             8,  8 ;  3
	mapgroup TIN_TOWER_1F,                                8,  8 ;  4
	mapgroup TIN_TOWER_2F,                                8,  8 ;  5
	mapgroup TIN_TOWER_3F,                                8,  8 ;  6
	mapgroup TIN_TOWER_4F,                                8,  8 ;  7
	mapgroup TIN_TOWER_5F,                                8,  8 ;  8
	mapgroup TIN_TOWER_6F,                                8,  8 ;  9
	mapgroup TIN_TOWER_7F,                                8,  8 ; 10
	mapgroup TIN_TOWER_8F,                                8,  8 ; 11
	mapgroup TIN_TOWER_9F,                                8,  8 ; 12
	mapgroup TIN_TOWER_10F,                               8,  8 ; 13
	mapgroup BURNED_TOWER_1F,                             8,  8 ; 14
	mapgroup BURNED_TOWER_B1F,                            9, 10 ; 15
	mapgroup NATIONAL_PARK,                              27, 21 ; 16
	mapgroup NATIONAL_PARK_BUG_CONTEST,                  27, 21 ; 17
	mapgroup RADIO_TOWER_1F,                              4,  9 ; 18
	mapgroup RADIO_TOWER_2F,                              4,  9 ; 19
	mapgroup RADIO_TOWER_3F,                              4,  9 ; 20
	mapgroup RADIO_TOWER_4F,                              4,  9 ; 21
	mapgroup RADIO_TOWER_5F,                              4,  9 ; 22
	mapgroup UNION_CAVE_1F,                              24, 10 ; 23
	mapgroup UNION_CAVE_B1F_NORTH,                       13, 10 ; 24
	mapgroup UNION_CAVE_B1F_SOUTH,                       18, 10 ; 25
	mapgroup UNION_CAVE_B2F,                             18, 10 ; 26
	mapgroup SLOWPOKE_WELL_B1F,                           9, 10 ; 27
	mapgroup SLOWPOKE_WELL_B2F,                           9, 10 ; 28
	mapgroup OLIVINE_LIGHTHOUSE_1F,                       9, 10 ; 29
	mapgroup OLIVINE_LIGHTHOUSE_2F,                       9, 10 ; 30
	mapgroup OLIVINE_LIGHTHOUSE_3F,                       9, 10 ; 31
	mapgroup OLIVINE_LIGHTHOUSE_4F,                       9, 10 ; 32
	mapgroup OLIVINE_LIGHTHOUSE_5F,                       9, 10 ; 33
	mapgroup OLIVINE_LIGHTHOUSE_6F,                       9, 10 ; 34
	mapgroup OLIVINE_LIGHTHOUSE_ROOF,                    10, 10 ; 35
	mapgroup MAHOGANY_MART_1F,                            4,  4 ; 36
	mapgroup TEAM_ROCKET_BASE_B1F,                        9, 15 ; 37
	mapgroup TEAM_ROCKET_BASE_B2F,                        9, 15 ; 38
	mapgroup TEAM_ROCKET_BASE_B3F,                        9, 15 ; 39
	mapgroup ILEX_FOREST,                                24, 17 ; 40
	mapgroup WAREHOUSE_ENTRANCE,                         18,  9 ; 41
	mapgroup UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES,     14, 13 ; 42
	mapgroup GOLDENROD_DEPT_STORE_B1F,                    9, 10 ; 43
	mapgroup UNDERGROUND_WAREHOUSE,                       9, 10 ; 44
	mapgroup MOUNT_MORTAR_1F_OUTSIDE,                    18, 20 ; 45
	mapgroup MOUNT_MORTAR_1F_INSIDE,                     25, 20 ; 46
	mapgroup MOUNT_MORTAR_2F_INSIDE,                     18, 20 ; 47
	mapgroup MOUNT_MORTAR_B1F,                           18, 20 ; 48
	mapgroup ICE_PATH_1F,                                15, 20 ; 49
	mapgroup ICE_PATH_B1F,                               18, 10 ; 50
	mapgroup ICE_PATH_B2F_MAHOGANY_SIDE,                  9, 10 ; 51
	mapgroup ICE_PATH_B2F_BLACKTHORN_SIDE,                9,  5 ; 52
	mapgroup ICE_PATH_B3F,                                5, 10 ; 53
	mapgroup WHIRL_ISLAND_NW,                            18, 17 ; 54
	mapgroup WHIRL_ISLAND_NE,                             9, 10 ; 55
	mapgroup WHIRL_ISLAND_SW,                             9, 10 ; 56
	mapgroup WHIRL_ISLAND_CAVE,                          45, 20 ; 57
	mapgroup WHIRL_ISLAND_SE,                             9,  5 ; 58
	mapgroup WHIRL_ISLAND_B1F,                           18, 20 ; 59
	mapgroup WHIRL_ISLAND_B2F,                           18, 10 ; 60
	mapgroup WHIRL_ISLAND_LUGIA_CHAMBER,                  9, 10 ; 61
	mapgroup SILVER_CAVE_ROOM_1,                         18, 10 ; 62
	mapgroup SILVER_CAVE_ROOM_2,                         17, 15 ; 63
	mapgroup SILVER_CAVE_ROOM_3,                         17, 10 ; 64
	mapgroup SILVER_CAVE_ITEM_ROOMS,                     18, 20 ; 65
	mapgroup DARK_CAVE_VIOLET_ENTRANCE,                  18, 20 ; 66
	mapgroup DARK_CAVE_BLACKTHORN_ENTRANCE,              15, 15 ; 67
	mapgroup DRAGONS_DEN_1F,                             45, 20 ; 68
	mapgroup DRAGONS_DEN_B1F,                            18, 20 ; 69
	mapgroup DRAGON_SHRINE,                               5,  5 ; 70
	mapgroup TOHJO_FALLS,                                 9, 15 ; 71
	mapgroup GIOVANNIS_CAVE,                             24, 10 ; 72
	mapgroup DIGLETTS_CAVE,                              19, 21 ; 73
	mapgroup MOUNT_MOON_1F,                              13, 15 ; 74
	mapgroup MOUNT_MOON_B1F,                             17, 15 ; 75
	mapgroup MOUNT_MOON_B2F,                             17, 16 ; 76
	mapgroup UNDERGROUND,                                18,  3 ; 77
	mapgroup ROCK_TUNNEL_1F,                             14, 15 ; 78
	mapgroup ROCK_TUNNEL_B1F,                            14, 15 ; 79
	mapgroup ROCK_TUNNEL_2F,                             14, 15 ; 80
	mapgroup VICTORY_ROAD_1F,                            13, 12 ; 81
	mapgroup VICTORY_ROAD_2F,                            11, 14 ; 82
	mapgroup VICTORY_ROAD_3F,                             9, 12 ; 83

	newgroup                                                    ;  4

	mapgroup ECRUTEAK_HOUSE,                              9, 10 ;  1
	mapgroup WISE_TRIOS_ROOM,                             4,  4 ;  2
	mapgroup ECRUTEAK_POKECENTER_1F,                      4,  6 ;  3
	mapgroup ECRUTEAK_LUGIA_SPEECH_HOUSE,                 4,  4 ;  4
	mapgroup DANCE_THEATRE,                               7,  6 ;  5
	mapgroup ECRUTEAK_MART,                               4,  6 ;  6
	mapgroup ECRUTEAK_GYM,                                9,  5 ;  7
	mapgroup ECRUTEAK_ITEMFINDER_HOUSE,                   4,  4 ;  8
	mapgroup ECRUTEAK_CITY,                              18, 20 ;  9
	mapgroup ROUTE_37,                                   10, 10 ; 10
	mapgroup VALERIES_HOUSE,                              4,  4 ; 11
	mapgroup ECRUTEAK_CHERISH_BALL_HOUSE,                 4,  4 ; 12
	mapgroup ECRUTEAK_DESTINY_KNOT_HOUSE,                 4,  4 ; 13

	newgroup                                                    ;  5

	mapgroup BLACKTHORN_GYM_1F,                           9,  5 ;  1
	mapgroup BLACKTHORN_GYM_2F,                           9,  5 ;  2
	mapgroup BLACKTHORN_DRAGON_SPEECH_HOUSE,              4,  4 ;  3
	mapgroup BLACKTHORN_EMYS_HOUSE,                       4,  4 ;  4
	mapgroup BLACKTHORN_MART,                             4,  6 ;  5
	mapgroup BLACKTHORN_POKECENTER_1F,                    4,  6 ;  6
	mapgroup MOVE_DELETERS_HOUSE,                         4,  4 ;  7
	mapgroup ROUTE_45,                                   46, 12 ;  8
	mapgroup ROUTE_46,                                   18, 10 ;  9
	mapgroup BLACKTHORN_CITY,                            19, 20 ; 10

	newgroup                                                    ;  6

	mapgroup CINNABAR_POKECENTER_1F,                      4,  6 ;  1
	mapgroup SEAFOAM_ISLANDS_1F,                         18, 17 ;  2
	mapgroup SEAFOAM_GYM,                                12, 12 ;  3
	mapgroup SEAFOAM_ISLANDS_B1F,                        10, 20 ;  4
	mapgroup SEAFOAM_ISLANDS_B2F,                        10, 20 ;  5
	mapgroup SEAFOAM_ISLANDS_B3F,                        10, 20 ;  6
	mapgroup SEAFOAM_ISLANDS_B4F,                        10, 20 ;  7
	mapgroup ROUTE_19,                                   29, 10 ;  8
	mapgroup ROUTE_20,                                    9, 51 ;  9
	mapgroup ROUTE_21,                                   48, 10 ; 10
	mapgroup URAGA_CHANNEL_WEST,                         15,  6 ; 11
	mapgroup CINNABAR_ISLAND,                            11, 12 ; 12
	mapgroup CINNABAR_VOLCANO_1F,                        14, 14 ; 13
	mapgroup CINNABAR_VOLCANO_B1F,                       18, 18 ; 14
	mapgroup CINNABAR_VOLCANO_B2F,                       14, 14 ; 15
	mapgroup POKEMON_MANSION_1F,                         14, 15 ; 16
	mapgroup POKEMON_MANSION_B1F,                        16, 17 ; 17
	mapgroup CINNABAR_LAB,                                9, 16 ; 18
	mapgroup SCARY_CAVE_1F,                              17, 20 ; 19
	mapgroup SCARY_CAVE_B1F,                             12, 12 ; 20
	mapgroup SCARY_CAVE_SHIPWRECK,                        6,  6 ; 21
	mapgroup ROUTE_19_BEACH_HOUSE,                        4,  4 ; 22

	newgroup                                                    ;  7

	mapgroup CERULEAN_GYM_BADGE_SPEECH_HOUSE,             4,  4 ;  1
	mapgroup CERULEAN_POLICE_STATION,                     4,  4 ;  2
	mapgroup CERULEAN_TRADE_SPEECH_HOUSE,                 4,  4 ;  3
	mapgroup CERULEAN_POKECENTER_1F,                      4,  6 ;  4
	mapgroup CERULEAN_GYM,                                8,  5 ;  6
	mapgroup CERULEAN_MART,                               4,  6 ;  7
	mapgroup ROUTE_10_POKECENTER_1F,                      4,  6 ;  8
	mapgroup POWER_PLANT,                                 9, 10 ; 10
	mapgroup BILLS_HOUSE,                                 4,  4 ; 11
	mapgroup ROUTE_4,                                    10, 33 ; 12
	mapgroup ROUTE_24,                                   20, 14 ; 13
	mapgroup ROUTE_25,                                   21, 17 ; 14
	mapgroup CERULEAN_CAPE,                              19, 25 ; 15
	mapgroup CERULEAN_CITY,                              16, 20 ; 16
	mapgroup CERULEAN_CAVE_1F,                           12, 17 ; 17
	mapgroup CERULEAN_CAVE_2F,                           11, 17 ; 18
	mapgroup CERULEAN_CAVE_B1F,                          11, 17 ; 19
	mapgroup CERULEAN_BIKE_SHOP,                          4,  4 ; 20
	mapgroup CERULEAN_BERRY_POWDER_HOUSE,                 4,  4 ; 21
	mapgroup CERULEAN_COUPLE_HOUSE,                       4,  4 ; 22
	mapgroup CERULEAN_WATER_SHOW_SPEECH_HOUSE,            4,  4 ; 23

	newgroup                                                    ;  8

	mapgroup AZALEA_POKECENTER_1F,                        4,  6 ;  1
	mapgroup CHARCOAL_KILN,                               4,  5 ;  2
	mapgroup AZALEA_MART,                                 4,  6 ;  3
	mapgroup KURTS_HOUSE,                                 4,  8 ;  4
	mapgroup AZALEA_GYM,                                  8,  5 ;  5
	mapgroup ROUTE_33,                                    9, 10 ;  6
	mapgroup AZALEA_TOWN,                                 9, 20 ;  7

	newgroup                                                    ;  9

	mapgroup LAKE_OF_RAGE_HIDDEN_POWER_HOUSE,             4,  4 ;  1
	mapgroup LAKE_OF_RAGE_MAGIKARP_HOUSE,                 4,  4 ;  2
	mapgroup ROUTE_43_MAHOGANY_GATE,                      4,  5 ;  3
	mapgroup ROUTE_43_GATE,                               4,  5 ;  4
	mapgroup ROUTE_43,                                   27, 10 ;  5
	mapgroup LAKE_OF_RAGE,                               18, 20 ;  6

	newgroup                                                    ; 10

	mapgroup ROUTE_32,                                   45, 10 ;  1
	mapgroup ROUTE_32_COAST,                             36, 15 ;  2
	mapgroup VIOLET_CITY,                                20, 20 ;  3
	mapgroup VIOLET_MART,                                 4,  6 ;  4
	mapgroup VIOLET_GYM,                                  8,  5 ;  5
	mapgroup EARLS_POKEMON_ACADEMY,                       8,  4 ;  6
	mapgroup VIOLET_NICKNAME_SPEECH_HOUSE,                4,  4 ;  7
	mapgroup VIOLET_POKECENTER_1F,                        4,  6 ;  8
	mapgroup VIOLET_ONIX_TRADE_HOUSE,                     4,  4 ;  9
	mapgroup ROUTE_32_RUINS_OF_ALPH_GATE,                 4,  5 ; 10
	mapgroup ROUTE_32_POKECENTER_1F,                      4,  6 ; 11
	mapgroup ROUTE_32_COAST_HOUSE,                        4,  4 ; 12
	mapgroup MAGNET_TUNNEL_EAST,                         11, 10 ; 13
	mapgroup VIOLET_OUTSKIRTS,                            8, 20 ; 14

	newgroup                                                    ; 11

	mapgroup ROUTE_34,                                   27, 10 ;  1
	mapgroup ROUTE_34_COAST,                             34,  9 ;  2
	mapgroup STORMY_BEACH,                               11, 22 ;  3
	mapgroup MURKY_SWAMP,                                19, 23 ;  4
	mapgroup GOLDENROD_CITY,                             18, 22 ;  5
	mapgroup GOLDENROD_GYM,                               9, 10 ;  6
	mapgroup GOLDENROD_BIKE_SHOP,                         4,  4 ;  7
	mapgroup GOLDENROD_HAPPINESS_RATER,                   4,  4 ;  8
	mapgroup GOLDENROD_BILLS_HOUSE,                       4,  4 ;  9
	mapgroup GOLDENROD_MAGNET_TRAIN_STATION,              9, 10 ; 10
	mapgroup GOLDENROD_FLOWER_SHOP,                       4,  4 ; 11
	mapgroup GOLDENROD_PP_SPEECH_HOUSE,                   4,  4 ; 12
	mapgroup GOLDENROD_NAME_RATER,                        4,  4 ; 13
	mapgroup GOLDENROD_DEPT_STORE_1F,                     4,  8 ; 14
	mapgroup GOLDENROD_DEPT_STORE_2F,                     4,  8 ; 15
	mapgroup GOLDENROD_DEPT_STORE_3F,                     4,  8 ; 16
	mapgroup GOLDENROD_DEPT_STORE_4F,                     4,  8 ; 17
	mapgroup GOLDENROD_DEPT_STORE_5F,                     4,  8 ; 18
	mapgroup GOLDENROD_DEPT_STORE_6F,                     4,  8 ; 19
	mapgroup GOLDENROD_DEPT_STORE_ELEVATOR,               2,  2 ; 20
	mapgroup GOLDENROD_DEPT_STORE_ROOF,                   6,  8 ; 21
	mapgroup GOLDENROD_GAME_CORNER,                       7, 10 ; 22
	mapgroup GOLDENROD_POKECOM_CENTER_1F,                 8, 16 ; 23
	mapgroup GOLDENROD_POKECOM_CENTER_OFFICE,             4,  4 ; 24
	mapgroup ILEX_FOREST_AZALEA_GATE,                     4,  5 ; 25
	mapgroup ROUTE_34_ILEX_FOREST_GATE,                   4,  5 ; 26
	mapgroup DAYCARE,                                     4,  4 ; 27
	mapgroup GOLDENROD_HP_UP_HOUSE,                       4,  4 ; 28
	mapgroup GOLDENROD_NET_BALL_HOUSE,                    4,  4 ; 29
	mapgroup GOLDENROD_BAND_HOUSE,                        4,  4 ; 30
	mapgroup GOLDENROD_SPEECH_HOUSE,                      4,  4 ; 31
	mapgroup MAGNET_TUNNEL_WEST,                         11, 10 ; 32
	mapgroup MAGNET_TUNNEL_INSIDE,                       13, 23 ; 33

	newgroup                                                    ; 12

	mapgroup ROUTE_6,                                    16, 15 ;  1
	mapgroup ROUTE_11,                                    9, 26 ;  2
	mapgroup VERMILION_CITY,                             20, 20 ;  3
	mapgroup VERMILION_HOUSE_FISHING_SPEECH_HOUSE,        4,  4 ;  4
	mapgroup VERMILION_POKECENTER_1F,                     4,  6 ;  5
	mapgroup POKEMON_FAN_CLUB,                            4,  5 ;  6
	mapgroup VERMILION_MAGNET_TRAIN_SPEECH_HOUSE,         4,  4 ;  7
	mapgroup VERMILION_MART,                              4,  6 ;  8
	mapgroup VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE,  4,  4 ;  9
	mapgroup VERMILION_GYM,                               9,  5 ; 10
	mapgroup ROUTE_6_SAFFRON_GATE,                        4,  5 ; 11
	mapgroup ROUTE_6_UNDERGROUND_ENTRANCE,                4,  4 ; 12
	mapgroup ROUTE_11_GATE,                               5,  5 ; 13
	mapgroup ROUTE_11_GATE_2F,                            4,  4 ; 14
	mapgroup VERMILION_POLLUTION_SPEECH_HOUSE,            4,  4 ; 15
	mapgroup VERMILION_S_S_ANNE_SPEECH_HOUSE,             4,  4 ; 16

	newgroup                                                    ; 13

	mapgroup ROUTE_1,                                    18, 12 ;  1
	mapgroup PALLET_TOWN,                                 9, 10 ;  2
	mapgroup REDS_HOUSE_1F,                               4,  4 ;  3
	mapgroup REDS_HOUSE_2F,                               4,  4 ;  4
	mapgroup BLUES_HOUSE_1F,                              4,  4 ;  5
	mapgroup BLUES_HOUSE_2F,                              4,  4 ;  6
	mapgroup OAKS_LAB,                                    6,  5 ;  7

	newgroup                                                    ; 14

	mapgroup ROUTE_2_NORTH,                              18, 10 ;  1
	mapgroup ROUTE_3,                                    11, 36 ;  2
	mapgroup ROUTE_3_POKECENTER_1F,                       4,  6 ;  3
	mapgroup PEWTER_CITY,                                18, 20 ;  4
	mapgroup PEWTER_NIDORAN_SPEECH_HOUSE,                 4,  4 ;  5
	mapgroup PEWTER_GYM,                                  7,  5 ;  6
	mapgroup PEWTER_MART,                                 4,  6 ;  7
	mapgroup PEWTER_POKECENTER_1F,                        4,  6 ;  8
	mapgroup PEWTER_SNOOZE_SPEECH_HOUSE,                  4,  4 ;  9
	mapgroup PEWTER_MUSEUM_OF_SCIENCE_1F,                 4, 10 ; 10
	mapgroup PEWTER_MUSEUM_OF_SCIENCE_2F,                 4,  7 ; 11

	newgroup                                                    ; 15

	mapgroup OLIVINE_PORT,                               16, 10 ;  1
	mapgroup VERMILION_PORT,                             13, 10 ;  2
	mapgroup FAST_SHIP_1F,                                9, 16 ;  3
	mapgroup FAST_SHIP_CABINS_NNW_NNE_NE,                16,  4 ;  4
	mapgroup FAST_SHIP_CABINS_SW_SSW_NW,                 16,  4 ;  5
	mapgroup FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN,     17,  5 ;  6
	mapgroup FAST_SHIP_B1F,                               7, 14 ;  7
	mapgroup OLIVINE_PORT_PASSAGE,                       15,  4 ;  8
	mapgroup VERMILION_PORT_PASSAGE,                     15,  4 ;  9
	mapgroup MOUNT_MOON_SQUARE,                           9, 15 ; 10
	mapgroup MOUNT_MOON_GIFT_SHOP,                        4,  4 ; 11
	mapgroup TIN_TOWER_ROOF,                              9,  7 ; 12

	newgroup                                                    ; 16

	mapgroup ROUTE_23,                                   70, 10 ;  1
	mapgroup INDIGO_PLATEAU,                             13, 10 ;  2
	mapgroup INDIGO_PLATEAU_POKECENTER_1F,                7,  8 ;  3
	mapgroup WILLS_ROOM,                                  9,  5 ;  4
	mapgroup KOGAS_ROOM,                                  9,  5 ;  5
	mapgroup BRUNOS_ROOM,                                 9,  5 ;  6
	mapgroup KARENS_ROOM,                                 9,  5 ;  7
	mapgroup LANCES_ROOM,                                12,  5 ;  8
	mapgroup HALL_OF_FAME,                                7,  5 ;  9
	mapgroup BELLCHIME_TRAIL,                             7, 12 ; 10

	newgroup                                                    ; 17

	mapgroup ROUTE_12_SOUTH,                             44, 10 ;  1
	mapgroup ROUTE_13_EAST,                              10, 23 ;  2
	mapgroup ROUTE_13_WEST,                              10, 12 ;  3
	mapgroup ROUTE_14,                                   19, 12 ;  4
	mapgroup ROUTE_15,                                    9, 20 ;  5
	mapgroup ROUTE_18_EAST,                              11, 14 ;  6
	mapgroup FUCHSIA_CITY,                               18, 20 ;  7
	mapgroup FUCHSIA_MART,                                4,  6 ;  8
	mapgroup FUCHSIA_GYM,                                 9,  5 ;  9
	mapgroup FUCHSIA_BILL_SPEECH_HOUSE,                   4,  4 ; 10
	mapgroup FUCHSIA_SAFARI_BALL_HOUSE,                   4,  4 ; 11
	mapgroup FUCHSIA_POKECENTER_1F,                       4,  6 ; 12
	mapgroup SAFARI_ZONE_WARDENS_HOME,                    4,  5 ; 13
	mapgroup SAFARI_ZONE_FUCHSIA_GATE,                    4,  5 ; 14
	mapgroup ROUTE_12_GATE,                               5,  5 ; 15
	mapgroup ROUTE_12_GATE_2F,                            4,  4 ; 16
	mapgroup ROUTE_15_FUCHSIA_GATE,                       5,  5 ; 17
	mapgroup ROUTE_15_FUCHSIA_GATE_2F,                    4,  4 ; 18
	mapgroup ROUTE_19_FUCHSIA_GATE,                       4,  5 ; 19
	mapgroup ROUTE_12_SUPER_ROD_HOUSE,                    4,  4 ; 20
	mapgroup LUCKY_ISLAND,                               17, 23 ; 21

	newgroup                                                    ; 18

	mapgroup ROUTE_8,                                    11, 26 ;  1
	mapgroup ROUTE_8_SAFFRON_GATE,                        4,  5 ;  2
	mapgroup ROUTE_10_SOUTH,                              9, 10 ;  3
	mapgroup ROUTE_12_NORTH,                              9, 10 ;  4
	mapgroup LAVENDER_TOWN,                              10, 10 ;  5
	mapgroup LAVENDER_POKECENTER_1F,                      4,  6 ;  6
	mapgroup MR_FUJIS_HOUSE,                              4,  5 ;  7
	mapgroup LAVENDER_TOWN_SPEECH_HOUSE,                  4,  4 ;  8
	mapgroup LAVENDER_NAME_RATER,                         4,  4 ;  9
	mapgroup LAVENDER_MART,                               4,  6 ; 10
	mapgroup SOUL_HOUSE,                                  5,  5 ; 11
	mapgroup SOUL_HOUSE_B1F,                              9, 10 ; 12
	mapgroup SOUL_HOUSE_B2F,                              9, 10 ; 13
	mapgroup SOUL_HOUSE_B3F,                              9,  4 ; 14
	mapgroup LAV_RADIO_TOWER_1F,                          4, 10 ; 15
	mapgroup LAV_RADIO_TOWER_2F,                          4,  9 ; 16
	mapgroup LAV_RADIO_TOWER_3F,                          4,  9 ; 17
	mapgroup LAV_RADIO_TOWER_4F,                          4,  9 ; 18
	mapgroup LAV_RADIO_TOWER_5F,                          4,  7 ; 19
	mapgroup HAUNTED_RADIO_TOWER_2F,                      4,  9 ; 20
	mapgroup HAUNTED_RADIO_TOWER_3F,                      4,  9 ; 21
	mapgroup HAUNTED_RADIO_TOWER_4F,                      4,  9 ; 22
	mapgroup HAUNTED_RADIO_TOWER_5F,                      9,  8 ; 23
	mapgroup HAUNTED_RADIO_TOWER_6F,                      9,  8 ; 24

	newgroup                                                    ; 19

	mapgroup ROUTE_28,                                    9, 19 ;  1
	mapgroup SILVER_CAVE_OUTSIDE,                        15, 20 ;  2
	mapgroup SILVER_CAVE_POKECENTER_1F,                   4,  6 ;  3
	mapgroup ROUTE_28_FAMOUS_SPEECH_HOUSE,                4,  4 ;  4
	mapgroup NAVEL_ROCK_OUTSIDE,                         16, 13 ;  5
	mapgroup NAVEL_ROCK_INSIDE,                          45, 20 ;  6
	mapgroup NAVEL_ROCK_ROOF,                            11,  8 ;  7
	mapgroup FARAWAY_ISLAND,                             23, 17 ;  8
	mapgroup FARAWAY_JUNGLE,                             12, 14 ;  9
	mapgroup SEAGALLOP_FERRY_VERMILION_GATE,              6,  7 ;  10
	mapgroup SEAGALLOP_FERRY_NAVEL_GATE,                  6,  7 ;  11
	mapgroup SEAGALLOP_FERRY_SHAMOUTI_GATE,               6,  7 ;  12

	newgroup                                                    ; 20

	mapgroup POKECENTER_2F,                               4,  8 ;  1
	mapgroup TRADE_CENTER,                                4,  5 ;  2
	mapgroup COLOSSEUM,                                   4,  5 ;  3
	mapgroup HIDDEN_TREE_GROTTO,                          9,  5 ;  4
	mapgroup HIDDEN_CAVE_GROTTO,                         45, 20 ;  5
	mapgroup YELLOW_FOREST_GATE,                          4,  5 ;  6
	mapgroup YELLOW_FOREST,                              26, 29 ;  7
	mapgroup ECRUTEAK_SHRINE_OUTSIDE,                     9,  6 ;  8
	mapgroup ECRUTEAK_SHRINE_INSIDE,                      6,  6 ;  9

	newgroup                                                    ; 21

	mapgroup ROUTE_7,                                     9, 10 ;  1
	mapgroup ROUTE_16_NORTHEAST,                         11, 11 ;  2
	mapgroup ROUTE_16_SOUTH,                             11, 11 ;  3
	mapgroup ROUTE_17,                                   63, 10 ;  4
	mapgroup ROUTE_18_WEST,                               9, 10 ;  5
	mapgroup URAGA_CHANNEL_EAST,                          9, 23 ;  6
	mapgroup CELADON_CITY,                               18, 22 ;  7
	mapgroup CELADON_DEPT_STORE_1F,                       4,  8 ;  8
	mapgroup CELADON_DEPT_STORE_2F,                       4,  8 ;  9
	mapgroup CELADON_DEPT_STORE_3F,                       4,  8 ; 10
	mapgroup CELADON_DEPT_STORE_4F,                       4,  8 ; 11
	mapgroup CELADON_DEPT_STORE_5F,                       4,  8 ; 12
	mapgroup CELADON_DEPT_STORE_6F,                       4,  8 ; 13
	mapgroup CELADON_DEPT_STORE_ELEVATOR,                 2,  2 ; 14
	mapgroup CELADON_MANSION_1F,                          5,  4 ; 15
	mapgroup CELADON_MANSION_2F,                          5,  4 ; 16
	mapgroup CELADON_MANSION_3F,                          5,  4 ; 17
	mapgroup CELADON_MANSION_ROOF,                        7,  4 ; 18
	mapgroup CELADON_MANSION_ROOF_HOUSE,                  4,  4 ; 19
	mapgroup CELADON_POKECENTER_1F,                       4,  6 ; 20
	mapgroup CELADON_GAME_CORNER,                         7, 10 ; 21
	mapgroup CELADON_GAME_CORNER_PRIZE_ROOM,              4,  4 ; 22
	mapgroup CELADON_GYM,                                 9,  5 ; 23
	mapgroup CELADON_CAFE,                                4,  6 ; 24
	mapgroup CELADON_CHIEF_HOUSE,                         4,  4 ; 25
	mapgroup CELADON_HOTEL_1F,                            4,  9 ; 26
	mapgroup CELADON_HOTEL_2F,                            2,  9 ; 27
	mapgroup CELADON_HOTEL_ROOM_1,                        3,  3 ; 28
	mapgroup CELADON_HOTEL_ROOM_2,                        3,  3 ; 29
	mapgroup CELADON_HOTEL_ROOM_3,                        3,  3 ; 30
	mapgroup CELADON_HOTEL_POOL,                          4,  7 ; 31
	mapgroup EUSINES_HOUSE,                               4,  4 ; 32
	mapgroup PSYCHIC_INVERS_HOUSE,                        4,  4 ; 33
	mapgroup ROUTE_16_FUCHSIA_SPEECH_HOUSE,               4,  4 ; 34
	mapgroup ROUTE_16_GATE,                               4,  5 ; 35
	mapgroup ROUTE_16_17_GATE,                            5,  5 ; 36
	mapgroup ROUTE_16_17_GATE_2F,                         4,  4 ; 37
	mapgroup ROUTE_7_SAFFRON_GATE,                        4,  5 ; 38
	mapgroup ROUTE_18_GATE,                               5,  5 ; 39
	mapgroup ROUTE_18_GATE_2F,                            4,  4 ; 40
	mapgroup CELADON_HOME_DECOR_STORE_1F,                 4,  5 ; 41
	mapgroup CELADON_HOME_DECOR_STORE_2F,                 4,  5 ; 42
	mapgroup CELADON_HOME_DECOR_STORE_3F,                 4,  5 ; 43
	mapgroup CELADON_HOME_DECOR_STORE_4F,                 4,  5 ; 44
	mapgroup CELADON_UNIVERSITY_1F,                      10, 15 ; 45
	mapgroup CELADON_UNIVERSITY_2F,                       7, 13 ; 46
	mapgroup CELADON_UNIVERSITY_LIBRARY_1F,               6,  7 ; 47
	mapgroup CELADON_UNIVERSITY_LIBRARY_2F,               6,  7 ; 48
	mapgroup CELADON_UNIVERSITY_PRINCIPALS_OFFICE,        4,  3 ; 49
	mapgroup CELADON_UNIVERSITY_WESTWOODS_OFFICE,         3,  3 ; 50
	mapgroup CELADON_UNIVERSITY_WILLOWS_OFFICE,           3,  3 ; 51
	mapgroup CELADON_UNIVERSITY_LOUNGE,                   6,  4 ; 52
	mapgroup CELADON_UNIVERSITY_CAFETERIA,                4,  8 ; 53
	mapgroup CELADON_UNIVERSITY_HYPER_TEST_ROOM,          6,  4 ; 54
	mapgroup CELADON_UNIVERSITY_POOL,                     5,  8 ; 55
	mapgroup CELADON_UNIVERSITY_CLASSROOM_1,              6,  4 ; 56
	mapgroup CELADON_UNIVERSITY_CLASSROOM_2,              6,  4 ; 57
	mapgroup CELADON_UNIVERSITY_CLASSROOM_3,              6,  4 ; 58
	mapgroup CELADON_UNIVERSITY_CLASSROOM_4,              6,  4 ; 59
	mapgroup CELADON_OLD_MAN_SPEECH_HOUSE,                4,  4 ; 60
	mapgroup CELADON_DEVELOPMENT_SPEECH_HOUSE,            4,  4 ; 61
	mapgroup CELADON_OUTSKIRTS,                           6, 10 ; 62

	newgroup                                                    ; 22

	mapgroup ROUTE_40,                                   20, 10 ;  1
	mapgroup ROUTE_41,                                   27, 32 ;  2
	mapgroup CIANWOOD_CITY,                              27, 15 ;  3
	mapgroup MANIAS_HOUSE,                                4,  4 ;  4
	mapgroup CIANWOOD_GYM,                                9,  5 ;  5
	mapgroup CIANWOOD_POKECENTER_1F,                      4,  6 ;  6
	mapgroup CIANWOOD_PHARMACY,                           4,  4 ;  7
	mapgroup CIANWOOD_CITY_PHOTO_STUDIO,                  4,  4 ;  8
	mapgroup CIANWOOD_LUGIA_SPEECH_HOUSE,                 4,  4 ;  9
	mapgroup STATS_JUDGES_HOUSE,                          4,  4 ; 10
	mapgroup BATTLE_TOWER_1F,                             7, 11 ; 11
	mapgroup BATTLE_TOWER_2F,                             5, 11 ; 12
	mapgroup BATTLE_TOWER_BATTLE_ROOM,                    4,  4 ; 13
	mapgroup BATTLE_TOWER_ELEVATOR,                       2,  2 ; 14
	mapgroup BATTLE_TOWER_HALLWAY,                        2, 11 ; 15
	mapgroup ROUTE_40_BATTLE_TOWER_GATE,                  4,  5 ; 16
	mapgroup BATTLE_TOWER_OUTSIDE,                       13, 10 ; 17

	newgroup                                                    ; 23

	mapgroup ROUTE_2_SOUTH,                              18, 10 ;  1
	mapgroup ROUTE_22,                                    9, 15 ;  2
	mapgroup VIRIDIAN_CITY,                              18, 20 ;  3
	mapgroup VIRIDIAN_GYM,                               23,  7 ;  4
	mapgroup VIRIDIAN_NICKNAME_SPEECH_HOUSE,              4,  4 ;  5
	mapgroup VIRIDIAN_SCHOOL_HOUSE,                       5,  4 ;  6
	mapgroup TRAINER_HOUSE_1F,                            6,  5 ;  7
	mapgroup TRAINER_HOUSE_B1F,                           8,  5 ;  8
	mapgroup VIRIDIAN_MART,                               4,  6 ;  9
	mapgroup VIRIDIAN_POKECENTER_1F,                      4,  6 ; 11
	mapgroup ROUTE_2_NUGGET_SPEECH_HOUSE,                 4,  4 ; 12
	mapgroup ROUTE_2_GATE,                                4,  5 ; 13
	mapgroup POKEMON_LEAGUE_GATE,                         9, 11 ; 14
	mapgroup VIRIDIAN_FOREST,                            26, 19 ; 15
	mapgroup VIRIDIAN_FOREST_VIRIDIAN_GATE,                4, 5 ; 16
	mapgroup VIRIDIAN_FOREST_PEWTER_GATE,                  4, 5 ; 17
	mapgroup ROUTE_1_VIRIDIAN_GATE,                        4, 5 ; 18
	mapgroup ROUTE_16_NORTHWEST,                         11, 11 ; 19
	mapgroup ROUTE_16_WEST,                              11, 34 ; 20

	newgroup                                                    ; 24

	mapgroup ROUTE_26,                                   54, 10 ;  1
	mapgroup ROUTE_27,                                    9, 40 ;  2
	mapgroup ROUTE_29,                                    9, 30 ;  3
	mapgroup NEW_BARK_TOWN,                               9, 10 ;  4
	mapgroup ELMS_LAB,                                    6,  5 ;  5
	mapgroup KRISS_HOUSE_1F,                              4,  5 ;  6
	mapgroup KRISS_HOUSE_2F,                              3,  4 ;  7
	mapgroup KRISS_NEIGHBORS_HOUSE,                       4,  4 ;  8
	mapgroup LYRAS_HOUSE_1F,                              4,  5 ;  9
	mapgroup LYRAS_HOUSE_2F,                              3,  4 ; 10
	mapgroup ELMS_HOUSE,                                  4,  4 ; 11
	mapgroup ROUTE_26_HEAL_SPEECH_HOUSE,                  4,  4 ; 12
	mapgroup ROUTE_26_DAY_OF_WEEK_SIBLINGS_HOUSE,         4,  4 ; 13
	mapgroup ROUTE_27_REST_HOUSE,                         4,  4 ; 14
	mapgroup ROUTE_29_46_GATE,                            4,  5 ; 15

	newgroup                                                    ; 25

	mapgroup FIGHTING_DOJO,                               6,  5 ;  1
	mapgroup SAFFRON_GYM,                                 9, 10 ;  2
	mapgroup SAFFRON_MART,                                4,  6 ;  3
	mapgroup SAFFRON_POKECENTER_1F,                       4,  6 ;  4
	mapgroup MR_PSYCHICS_HOUSE,                           4,  4 ;  5
	mapgroup SAFFRON_TRAIN_STATION,                       9, 10 ;  6
	mapgroup SILPH_CO_1F,                                 4,  8 ;  7
	mapgroup SILPH_CO_2F,                                 4,  8 ;  8
	mapgroup SILPH_CO_3F,                                 4,  8 ;  9
	mapgroup COPYCATS_HOUSE_1F,                           4,  4 ; 10
	mapgroup COPYCATS_HOUSE_2F,                           3,  4 ; 11
	mapgroup ROUTE_5,                                    17, 10 ; 12
	mapgroup ROUTE_5_UNDERGROUND_ENTRANCE,                4,  4 ; 13
	mapgroup ROUTE_5_SAFFRON_CITY_GATE,                   4,  5 ; 14
	mapgroup ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE,            4,  4 ; 15
	mapgroup POKEMON_TRAINER_FAN_CLUB,                    5,  4 ; 16
	mapgroup SAFFRON_HITMONTOP_KID_HOUSE,                 4,  4 ; 17
	mapgroup SAFFRON_BOOK_SPEECH_HOUSE,                   4,  4 ; 18
	mapgroup SAFFRON_ORRE_SPEECH_HOUSE,                   4,  4 ; 19
	mapgroup SAFFRON_RICH_SPEECH_HOUSE,                   4,  4 ; 20

	newgroup                                                    ; 26

	mapgroup ROUTE_30,                                   27, 10 ;  1
	mapgroup ROUTE_31,                                    9, 22 ;  2
	mapgroup CHERRYGROVE_BAY,                            25, 15 ;  3
	mapgroup CHERRYGROVE_CITY,                           10, 20 ;  4
	mapgroup CHERRYGROVE_MART,                            4,  6 ;  5
	mapgroup CHERRYGROVE_POKECENTER_1F,                   4,  6 ;  6
	mapgroup CHERRYGROVE_GYM_SPEECH_HOUSE,                4,  4 ;  7
	mapgroup GUIDE_GENTS_HOUSE,                           4,  4 ;  8
	mapgroup CHERRYGROVE_EVOLUTION_SPEECH_HOUSE,          4,  4 ;  9
	mapgroup ROUTE_30_BERRY_SPEECH_HOUSE,                 4,  4 ; 10
	mapgroup MR_POKEMONS_HOUSE,                           4,  4 ; 11
	mapgroup ROUTE_31_VIOLET_GATE,                        4,  5 ; 12

	newgroup                                                    ; 27

	mapgroup CLIFF_EDGE_GATE,                            11, 10 ;  1
	mapgroup CLIFF_CAVE,                                 18,  6 ;  2
	mapgroup ROUTE_47,                                   19, 39 ;  3
	mapgroup ROUTE_48,                                   11, 18 ;  4
	mapgroup QUIET_CAVE_1F,                              18, 18 ;  5
	mapgroup QUIET_CAVE_B1F,                             18, 18 ;  6
	mapgroup QUIET_CAVE_B2F,                             18, 18 ;  7
	mapgroup QUIET_CAVE_B3F,                             18, 18 ;  8

	newgroup                                                    ; 28

	mapgroup ROUTE_9,                                     9, 26 ;  1
	mapgroup ROUTE_10_NORTH,                             29, 10 ;  2
	mapgroup DIM_CAVE_1F,                                18, 17 ;  3
	mapgroup DIM_CAVE_2F,                                18, 17 ;  4
	mapgroup DIM_CAVE_3F,                                17, 16 ;  5
	mapgroup DIM_CAVE_4F,                                16, 16 ;  6
	mapgroup DIM_CAVE_5F,                                17, 17 ;  7

	newgroup                                                    ; 29

	mapgroup GOLDENROD_HARBOR,                           18, 24 ;  1
	mapgroup GOLDENROD_HARBOR_GATE,                       4,  5 ;  2

	newgroup                                                    ; 30

	mapgroup RUINS_OF_ALPH_OUTSIDE,                      21, 11 ;  1
	mapgroup RUINS_OF_ALPH_HO_OH_CHAMBER,                 5,  4 ;  2
	mapgroup RUINS_OF_ALPH_KABUTO_CHAMBER,                5,  4 ;  3
	mapgroup RUINS_OF_ALPH_OMANYTE_CHAMBER,               5,  4 ;  4
	mapgroup RUINS_OF_ALPH_AERODACTYL_CHAMBER,            5,  4 ;  5
	mapgroup RUINS_OF_ALPH_ENTRANCE_CHAMBER,              4,  4 ;  6
	mapgroup RUINS_OF_ALPH_INNER_CHAMBER,                14, 10 ;  7
	mapgroup RUINS_OF_ALPH_RESEARCH_CENTER,               4,  4 ;  8
	mapgroup RUINS_OF_ALPH_HO_OH_ITEM_ROOM,               5,  4 ;  9
	mapgroup RUINS_OF_ALPH_KABUTO_ITEM_ROOM,              5,  4 ; 10
	mapgroup RUINS_OF_ALPH_OMANYTE_ITEM_ROOM,             5,  4 ; 11
	mapgroup RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM,          5,  4 ; 12
	mapgroup RUINS_OF_ALPH_HO_OH_WORD_ROOM,              12, 10 ; 13
	mapgroup RUINS_OF_ALPH_KABUTO_WORD_ROOM,              7, 10 ; 14
	mapgroup RUINS_OF_ALPH_OMANYTE_WORD_ROOM,             8, 10 ; 15
	mapgroup RUINS_OF_ALPH_AERODACTYL_WORD_ROOM,          7, 10 ; 16
	mapgroup RUINS_OF_ALPH_SINJOH_CHAMBER,                5,  5 ; 17
	mapgroup ROUTE_22_PAST,                               6,  6 ; 18

	newgroup                                                    ; 31

	mapgroup SHAMOUTI_ISLAND,                            15, 18 ;  1
	mapgroup BEAUTIFUL_BEACH,                            15, 21 ;  2
	mapgroup WARM_BEACH,                                 13, 12 ;  3
	mapgroup SHAMOUTI_COAST,                             10, 48 ;  4
	mapgroup ROCKY_BEACH,                                15, 20 ;  5
	mapgroup SHAMOUTI_TUNNEL,                            10, 18 ;  6
	mapgroup NOISY_FOREST,                               20, 22 ;  7
	mapgroup SHAMOUTI_POKECENTER_1F,                      4,  6 ;  8
	mapgroup SHAMOUTI_HOTEL_1F,                           4,  9 ;  9
	mapgroup SHAMOUTI_HOTEL_2F,                           2,  9 ; 10
	mapgroup SHAMOUTI_HOTEL_3F,                           2,  9 ; 11
	mapgroup SHAMOUTI_HOTEL_ROOM_2A,                      3,  3 ; 12
	mapgroup SHAMOUTI_HOTEL_ROOM_2B,                      3,  3 ; 13
	mapgroup SHAMOUTI_HOTEL_ROOM_3B,                      3,  3 ; 14
	mapgroup SHAMOUTI_HOTEL_ROOM_3C,                      3,  3 ; 15
	mapgroup SHAMOUTI_HOTEL_RESTAURANT,                   4,  9 ; 16
	mapgroup SHAMOUTI_TOURIST_CENTER,                     4,  4 ; 17
	mapgroup SHAMOUTI_MERCHANT,                           4,  4 ; 18
	mapgroup SHAMOUTI_HOUSE,                              4,  4 ; 19
	mapgroup BEAUTIFUL_BEACH_VILLA,                       4,  6 ; 20
	mapgroup WARM_BEACH_SHACK,                            4,  4 ; 21
	mapgroup WARM_BEACH_HOUSE,                            4,  4 ; 22
	mapgroup ROCKY_BEACH_HOUSE,                           4,  4 ; 23
	mapgroup FIRE_ISLAND,                                16, 13 ; 24
	mapgroup FIRE_ISLAND_ROOF,                            6,  6 ; 25
	mapgroup ICE_ISLAND,                                 16, 13 ; 26
	mapgroup ICE_ISLAND_ROOF,                             6,  6 ; 27
	mapgroup LIGHTNING_ISLAND,                           16, 13 ; 28
	mapgroup LIGHTNING_ISLAND_ROOF,                       6,  6 ; 29

	newgroup                                                    ; 32

	mapgroup SAFARI_ZONE_HUB,                            16, 17 ;  1
	mapgroup SAFARI_ZONE_EAST,                           15, 17 ;  2
	mapgroup SAFARI_ZONE_NORTH,                          20, 22 ;  3
	mapgroup SAFARI_ZONE_WEST,                           15, 17 ;  4
	mapgroup SAFARI_ZONE_HUB_REST_HOUSE,                  4,  4 ;  5
	mapgroup SAFARI_ZONE_EAST_REST_HOUSE,                 4,  4 ;  6
	mapgroup SAFARI_ZONE_NORTH_REST_HOUSE,                4,  4 ;  7
	mapgroup SAFARI_ZONE_WEST_REST_HOUSE_1,               4,  4 ;  8
	mapgroup SAFARI_ZONE_WEST_REST_HOUSE_2,               4,  4 ;  9

	newgroup                                                    ; 33

	mapgroup VALENCIA_ISLAND,                            12, 14 ;  1
	mapgroup ROUTE_49,                                   11, 20 ;  2
	mapgroup IVYS_LAB,                                    6,  5 ;  3
	mapgroup IVYS_HOUSE,                                  4,  4 ;  4
	mapgroup VALENCIA_HOUSE,                              4,  4 ;  5
	mapgroup VALENCIA_PORT,                               9, 11 ;  6

	newgroup                                                    ; 34

	mapgroup SINJOH_RUINS,                               13,  9 ;  1
	mapgroup SINJOH_RUINS_HOUSE,                           4, 4 ;  2
	mapgroup MYSTRI_STAGE,                                9,  7 ;  3
	mapgroup EMBEDDED_TOWER,                             12, 11 ;  4

	newgroup                                                    ; 35

	mapgroup SAFFRON_CITY,                               19, 20 ;  1
	mapgroup SHAMOUTI_SHRINE_RUINS,                      17, 12 ;  2

	newgroup                                                    ; 36

	mapgroup ROUTE_35,                                   18, 12 ;  1
	mapgroup ROUTE_36,                                    9, 32 ;  2
	mapgroup ROUTE_35_GOLDENROD_GATE,                     4,  5 ;  3
	mapgroup ROUTE_35_NATIONAL_PARK_GATE,                 4, 10 ;  4
	mapgroup ROUTE_36_RUINS_OF_ALPH_GATE,                 4,  5 ;  5
	mapgroup ROUTE_36_NATIONAL_PARK_GATE,                 4,  5 ;  6
	mapgroup ROUTE_36_VIOLET_GATE,                        4,  5 ;  7



; elevator floors

	const_def
	const _B4F
	const _B3F
	const _B2F
	const _B1F
	const _1F
	const _2F
	const _3F
	const _4F
	const _5F
	const _6F
	const _7F
	const _8F
	const _9F
	const _10F
	const _11F
	const _ROOF

; connection directions
	const_def
	const EAST_F
	const WEST_F
	const SOUTH_F
	const NORTH_F

	const_def
	shift_const EAST
	shift_const WEST
	shift_const SOUTH
	shift_const NORTH

; permissions
const_value SET 1
	const TOWN
	const ROUTE
	const INDOOR
	const CAVE
	const PERM_5
	const GATE
	const DUNGEON

; object struct
	const_def
	const OBJECT_SPRITE
	const OBJECT_MAP_OBJECT_INDEX
	const OBJECT_SPRITE_TILE
	const OBJECT_MOVEMENTTYPE
	const OBJECT_FLAGS1
	const OBJECT_FLAGS2
	const OBJECT_PALETTE
	const OBJECT_DIRECTION_WALKING
	const OBJECT_FACING
	const OBJECT_STEP_TYPE
	const OBJECT_STEP_DURATION
	const OBJECT_ACTION
	const OBJECT_STEP_FRAME
	const OBJECT_FACING_STEP
	const OBJECT_NEXT_TILE
	const OBJECT_STANDING_TILE
	const OBJECT_NEXT_MAP_X
	const OBJECT_NEXT_MAP_Y
	const OBJECT_MAP_X
	const OBJECT_MAP_Y
	const OBJECT_INIT_X
	const OBJECT_INIT_Y
	const OBJECT_RADIUS
	const OBJECT_SPRITE_X
	const OBJECT_SPRITE_Y
	const OBJECT_SPRITE_X_OFFSET
	const OBJECT_SPRITE_Y_OFFSET
	const OBJECT_MOVEMENT_BYTE_INDEX
	const OBJECT_28
	const OBJECT_29
	const OBJECT_30
	const OBJECT_31
	const OBJECT_RANGE

; map object struct
	const_def
	const MAPOBJECT_OBJECT_STRUCT_ID ; 0
	const MAPOBJECT_SPRITE ; 1
	const MAPOBJECT_Y_COORD ; 2
	const MAPOBJECT_X_COORD ; 3
	const MAPOBJECT_MOVEMENT ; 4
	const MAPOBJECT_RADIUS ; 5
	const MAPOBJECT_HOUR ; 6
	const MAPOBJECT_TIMEOFDAY ; 7
	const MAPOBJECT_COLOR ; 8
	const MAPOBJECT_RANGE ; 9
	const MAPOBJECT_SCRIPT_POINTER ; a
	const MAPOBJECT_POINTER_HI ; b
	const MAPOBJECT_EVENT_FLAG ; c
	const MAPOBJECT_FLAG_HI ; d
OBJECT_LENGTH EQU const_value

MAPOBJECT_SCREEN_HEIGHT EQU 11
MAPOBJECT_SCREEN_WIDTH EQU 12

OW_DOWN  EQU DOWN  << 2
OW_UP    EQU UP    << 2
OW_LEFT  EQU LEFT  << 2
OW_RIGHT EQU RIGHT << 2

; see engine/overworld.asm:EmotesPointers
	const_def
	const EMOTE_SHOCK ; 0
	const EMOTE_QUESTION ; 1
	const EMOTE_HAPPY ; 2
	const EMOTE_SAD ; 3
	const EMOTE_HEART ; 4
	const EMOTE_BOLT ; 5
	const EMOTE_SLEEP ; 6
	const EMOTE_FISH ; 7
	const EMOTE_SHADOW ; 8
	const EMOTE_ROD ; 9
	const EMOTE_BOULDER_DUST ; 10
	const EMOTE_SHAKING_GRASS ; 11
	const EMOTE_PUDDLE_SPLASH ; 12
EMOTE_MEM EQU -1

; see engine/events.asm:TryReadSign.signs
	const_def
	const SIGNPOST_READ
	const SIGNPOST_UP
	const SIGNPOST_DOWN
	const SIGNPOST_RIGHT
	const SIGNPOST_LEFT
	const SIGNPOST_IFSET
	const SIGNPOST_IFNOTSET
	const SIGNPOST_JUMPTEXT
	const SIGNPOST_JUMPSTD
	const SIGNPOST_GROTTOITEM
; SIGNPOST_ITEM has to be the last signpost type, since hidden item signposts
; use type SIGNPOST_ITEM + (item id) to save space.
; Note that this requires SIGNPOST_ITEM + (item id) <= $ff, so currently most
; of the mail items cannot be hidden.
SIGNPOST_ITEM EQU const_value


; see engine/spawn_points.asm:SpawnPoints
const_value = -1
	const SPAWN_N_A

	const SPAWN_HOME

	const SPAWN_PALLET
	const SPAWN_VIRIDIAN
	const SPAWN_PEWTER
	const SPAWN_MT_MOON
	const SPAWN_CERULEAN
	const SPAWN_ROCK_TUNNEL
	const SPAWN_VERMILION
	const SPAWN_LAVENDER
	const SPAWN_SAFFRON
	const SPAWN_CELADON
	const SPAWN_FUCHSIA
	const SPAWN_CINNABAR
	const SPAWN_INDIGO

	const SPAWN_NEW_BARK
	const SPAWN_CHERRYGROVE
	const SPAWN_VIOLET
	const SPAWN_UNION_CAVE
	const SPAWN_AZALEA
	const SPAWN_CIANWOOD
	const SPAWN_GOLDENROD
	const SPAWN_OLIVINE
	const SPAWN_ECRUTEAK
	const SPAWN_MAHOGANY
	const SPAWN_LAKE
	const SPAWN_BLACKTHORN
	const SPAWN_MT_SILVER
	const SPAWN_FAST_SHIP
NUM_SPAWNS EQU const_value

	const_def
	const PALETTE_AUTO
	const PALETTE_DAY
	const PALETTE_NITE
	const PALETTE_MORN
	const PALETTE_DARK

; ObjectFlags1
FIXED_FACING EQU 2
SLIDING      EQU 3
EMOTE_OBJECT EQU 7
; ObjectFlags2
INVISIBLE    EQU 0
OVERHEAD     EQU 3

; see engine/events.asm:TryObjectEvent.pointers
	const_def
	const PERSONTYPE_SCRIPT         ; 0
	const PERSONTYPE_POKEBALL       ; 1
	const PERSONTYPE_TRAINER        ; 2
	const PERSONTYPE_GENERICTRAINER ; 3
	const PERSONTYPE_POKEMON        ; 4
	const PERSONTYPE_COMMAND        ; 5
NUM_PERSONTYPES EQU const_value

; fruit trees
; see engine/fruit_trees.asm:FruitTreeItems
const_value SET 1
	const FRUITTREE_ROUTE_29        ; 01
	const FRUITTREE_ROUTE_30_1      ; 02
	const FRUITTREE_ROUTE_30_2      ; 03
	const FRUITTREE_ROUTE_31        ; 04
	const FRUITTREE_VIOLET_CITY     ; 05
	const FRUITTREE_ROUTE_32_COAST  ; 06
	const FRUITTREE_ROUTE_33        ; 07
	const FRUITTREE_AZALEA_TOWN     ; 08
	const FRUITTREE_ROUTE_35        ; 09
	const FRUITTREE_ROUTE_36        ; 0a
	const FRUITTREE_ROUTE_37_1      ; 0b
	const FRUITTREE_ROUTE_37_2      ; 0c
	const FRUITTREE_ROUTE_37_3      ; 0d
	const FRUITTREE_ROUTE_38        ; 0e
	const FRUITTREE_ROUTE_39        ; 0f
	const FRUITTREE_ROUTE_42_1      ; 10
	const FRUITTREE_ROUTE_42_2      ; 11
	const FRUITTREE_ROUTE_42_3      ; 12
	const FRUITTREE_ROUTE_43        ; 13
	const FRUITTREE_ROUTE_44        ; 14
	const FRUITTREE_ROUTE_45        ; 15
	const FRUITTREE_ROUTE_46_1      ; 16
	const FRUITTREE_ROUTE_46_2      ; 17
	const FRUITTREE_ROUTE_27        ; 18
	const FRUITTREE_ROUTE_26        ; 19
	const FRUITTREE_ROUTE_8         ; 1a
	const FRUITTREE_ROUTE_11        ; 1b
	const FRUITTREE_FUCHSIA_CITY    ; 1c
	const FRUITTREE_PEWTER_CITY_1   ; 1d
	const FRUITTREE_PEWTER_CITY_2   ; 1e
	const FRUITTREE_ROUTE_2         ; 1f
	const FRUITTREE_ROUTE_1         ; 20
	const FRUITTREE_LUCKY_ISLAND    ; 21
	const FRUITTREE_SHAMOUTI_ISLAND ; 22
	const FRUITTREE_ROUTE_49        ; 23
NUM_FRUIT_TREES EQU const_value +- 1

; hidden grottoes
; see engine/hidden_grottoes.asm:HiddenGrottoData
const_value SET 1
	const HIDDENGROTTO_ROUTE_32           ; 01
	const HIDDENGROTTO_ROUTE_35           ; 02
	const HIDDENGROTTO_LAKE_OF_RAGE       ; 03
	const HIDDENGROTTO_04                 ; 04
	const HIDDENGROTTO_05                 ; 05
	const HIDDENGROTTO_06                 ; 06
	const HIDDENGROTTO_07                 ; 07
	const HIDDENGROTTO_08                 ; 08
	const HIDDENGROTTO_09                 ; 09
	const HIDDENGROTTO_0A                 ; 0a
	const HIDDENGROTTO_0B                 ; 0b
	const HIDDENGROTTO_0C                 ; 0c
	const HIDDENGROTTO_0D                 ; 0d
	const HIDDENGROTTO_0E                 ; 0e
	const HIDDENGROTTO_0F                 ; 0f
	const HIDDENGROTTO_10                 ; 10
	const HIDDENGROTTO_11                 ; 11
	const HIDDENGROTTO_12                 ; 12
	const HIDDENGROTTO_13                 ; 13
	const HIDDENGROTTO_14                 ; 14
	const HIDDENGROTTO_15                 ; 15
	const HIDDENGROTTO_16                 ; 16
	const HIDDENGROTTO_17                 ; 17
NUM_HIDDEN_GROTTOES EQU const_value +- 1

CMDQUEUE_ENTRY_SIZE EQU 6
CMDQUEUE_CAPACITY EQU 4
CMDQUEUE_ADDR EQU 1 ; offsets 0, 3, 4, and 5 are unused
CMDQUEUE_STONETABLE EQU 2 ; types 0, 1, 3, and 4 are unused
