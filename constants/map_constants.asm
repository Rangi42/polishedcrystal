newgroup: MACRO
const_value = const_value + 1
	enum_start 1
ENDM

mapconst: MACRO
GROUP_\1 EQU const_value
	enum MAP_\1
\1_HEIGHT EQU \2
\1_WIDTH EQU \3
ENDM

GROUP_N_A  EQU -1
MAP_N_A    EQU -1

GROUP_NONE EQU 0
MAP_NONE   EQU 0

; map group ids
	const_def
	newgroup                                                    ;  1

	mapconst OLIVINE_POKECENTER_1F,                       4,  6 ;  1
	mapconst OLIVINE_GYM,                                 8,  5 ;  2
	mapconst OLIVINE_TIMS_HOUSE,                          4,  4 ;  3
	mapconst OLIVINE_PUNISHMENT_SPEECH_HOUSE,             4,  4 ;  5
	mapconst OLIVINE_GOOD_ROD_HOUSE,                      4,  4 ;  6
	mapconst OLIVINE_CAFE,                                4,  5 ;  7
	mapconst OLIVINE_MART,                                4,  6 ;  8
	mapconst ROUTE_38_ECRUTEAK_GATE,                      4,  5 ;  9
	mapconst ROUTE_39_BARN,                               4,  4 ; 10
	mapconst ROUTE_39_FARMHOUSE,                          4,  4 ; 11
	mapconst ROUTE_38,                                    9, 20 ; 12
	mapconst ROUTE_39,                                   20, 10 ; 13
	mapconst OLIVINE_CITY,                               16, 33 ; 14
	mapconst ROUTE_35_COAST,                             14, 26 ; 15

	newgroup                                                    ;  2

	mapconst MAHOGANY_RED_GYARADOS_SPEECH_HOUSE,          4,  4 ;  1
	mapconst MAHOGANY_GYM,                                9,  5 ;  2
	mapconst MAHOGANY_POKECENTER_1F,                      4,  6 ;  3
	mapconst ROUTE_42_ECRUTEAK_GATE,                      4,  5 ;  4
	mapconst ROUTE_42,                                    9, 30 ;  5
	mapconst ROUTE_44,                                    9, 30 ;  6
	mapconst MAHOGANY_TOWN,                               9, 10 ;  7

	newgroup                                                    ;  3

	mapconst SPROUT_TOWER_1F,                             8,  8 ;  1
	mapconst SPROUT_TOWER_2F,                             8,  8 ;  2
	mapconst SPROUT_TOWER_3F,                             8,  8 ;  3
	mapconst TIN_TOWER_1F,                                8,  8 ;  4
	mapconst TIN_TOWER_2F,                                8,  8 ;  5
	mapconst TIN_TOWER_3F,                                8,  8 ;  6
	mapconst TIN_TOWER_4F,                                8,  8 ;  7
	mapconst TIN_TOWER_5F,                                8,  8 ;  8
	mapconst TIN_TOWER_6F,                                8,  8 ;  9
	mapconst TIN_TOWER_7F,                                8,  8 ; 10
	mapconst TIN_TOWER_8F,                                8,  8 ; 11
	mapconst TIN_TOWER_9F,                                8,  8 ; 12
	mapconst TIN_TOWER_10F,                               8,  8 ; 13
	mapconst BURNED_TOWER_1F,                             8,  8 ; 14
	mapconst BURNED_TOWER_B1F,                            9, 10 ; 15
	mapconst NATIONAL_PARK,                              27, 21 ; 16
	mapconst NATIONAL_PARK_BUG_CONTEST,                  27, 21 ; 17
	mapconst RADIO_TOWER_1F,                              4,  9 ; 18
	mapconst RADIO_TOWER_2F,                              4,  9 ; 19
	mapconst RADIO_TOWER_3F,                              4,  9 ; 20
	mapconst RADIO_TOWER_4F,                              4,  9 ; 21
	mapconst RADIO_TOWER_5F,                              4,  9 ; 22
	mapconst UNION_CAVE_1F,                              24, 10 ; 23
	mapconst UNION_CAVE_B1F_NORTH,                       13, 10 ; 24
	mapconst UNION_CAVE_B1F_SOUTH,                       18, 10 ; 25
	mapconst UNION_CAVE_B2F,                             18, 10 ; 26
	mapconst SLOWPOKE_WELL_B1F,                           9, 10 ; 27
	mapconst SLOWPOKE_WELL_B2F,                           9, 10 ; 28
	mapconst OLIVINE_LIGHTHOUSE_1F,                       9, 10 ; 29
	mapconst OLIVINE_LIGHTHOUSE_2F,                       9, 10 ; 30
	mapconst OLIVINE_LIGHTHOUSE_3F,                       9, 10 ; 31
	mapconst OLIVINE_LIGHTHOUSE_4F,                       9, 10 ; 32
	mapconst OLIVINE_LIGHTHOUSE_5F,                       9, 10 ; 33
	mapconst OLIVINE_LIGHTHOUSE_6F,                       9, 10 ; 34
	mapconst OLIVINE_LIGHTHOUSE_ROOF,                    10, 10 ; 35
	mapconst MAHOGANY_MART_1F,                            4,  4 ; 36
	mapconst TEAM_ROCKET_BASE_B1F,                        9, 15 ; 37
	mapconst TEAM_ROCKET_BASE_B2F,                        9, 15 ; 38
	mapconst TEAM_ROCKET_BASE_B3F,                        9, 15 ; 39
	mapconst ILEX_FOREST,                                24, 17 ; 40
	mapconst WAREHOUSE_ENTRANCE,                         18,  9 ; 41
	mapconst UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES,     14, 13 ; 42
	mapconst GOLDENROD_DEPT_STORE_B1F,                    9, 10 ; 43
	mapconst UNDERGROUND_WAREHOUSE,                       9, 10 ; 44
	mapconst MOUNT_MORTAR_1F_OUTSIDE,                    18, 20 ; 45
	mapconst MOUNT_MORTAR_1F_INSIDE,                     25, 20 ; 46
	mapconst MOUNT_MORTAR_2F_INSIDE,                     18, 20 ; 47
	mapconst MOUNT_MORTAR_B1F,                           18, 20 ; 48
	mapconst ICE_PATH_1F,                                15, 20 ; 49
	mapconst ICE_PATH_B1F,                               18, 10 ; 50
	mapconst ICE_PATH_B2F_MAHOGANY_SIDE,                  9, 10 ; 51
	mapconst ICE_PATH_B2F_BLACKTHORN_SIDE,                9,  5 ; 52
	mapconst ICE_PATH_B3F,                                5, 10 ; 53
	mapconst WHIRL_ISLAND_NW,                            18, 17 ; 54
	mapconst WHIRL_ISLAND_NE,                             9, 10 ; 55
	mapconst WHIRL_ISLAND_SW,                             9, 10 ; 56
	mapconst WHIRL_ISLAND_CAVE,                          45, 20 ; 57
	mapconst WHIRL_ISLAND_SE,                             9,  5 ; 58
	mapconst WHIRL_ISLAND_B1F,                           18, 20 ; 59
	mapconst WHIRL_ISLAND_B2F,                           18, 10 ; 60
	mapconst WHIRL_ISLAND_LUGIA_CHAMBER,                  9, 10 ; 61
	mapconst SILVER_CAVE_ROOM_1,                         18, 10 ; 62
	mapconst SILVER_CAVE_ROOM_2,                         17, 15 ; 63
	mapconst SILVER_CAVE_ROOM_3,                         17, 10 ; 64
	mapconst SILVER_CAVE_ITEM_ROOMS,                     18, 20 ; 65
	mapconst DARK_CAVE_VIOLET_ENTRANCE,                  18, 20 ; 66
	mapconst DARK_CAVE_BLACKTHORN_ENTRANCE,              15, 15 ; 67
	mapconst DRAGONS_DEN_1F,                             45, 20 ; 68
	mapconst DRAGONS_DEN_B1F,                            18, 20 ; 69
	mapconst DRAGON_SHRINE,                               5,  5 ; 70
	mapconst TOHJO_FALLS,                                 9, 15 ; 71
	mapconst GIOVANNIS_CAVE,                             24, 10 ; 72
	mapconst DIGLETTS_CAVE,                              19, 21 ; 73
	mapconst MOUNT_MOON_1F,                              13, 15 ; 74
	mapconst MOUNT_MOON_B1F,                             14, 16 ; 75
	mapconst MOUNT_MOON_B2F,                             17, 16 ; 76
	mapconst UNDERGROUND,                                18,  3 ; 77
	mapconst ROCK_TUNNEL_1F,                             14, 15 ; 78
	mapconst ROCK_TUNNEL_B1F,                            14, 15 ; 79
	mapconst ROCK_TUNNEL_2F,                             14, 15 ; 80
	mapconst VICTORY_ROAD_1F,                            13, 12 ; 81
	mapconst VICTORY_ROAD_2F,                            11, 14 ; 82
	mapconst VICTORY_ROAD_3F,                             9, 12 ; 83

	newgroup                                                    ;  4

	mapconst ECRUTEAK_HOUSE,                              9, 10 ;  1
	mapconst WISE_TRIOS_ROOM,                             4,  4 ;  2
	mapconst ECRUTEAK_POKECENTER_1F,                      4,  6 ;  3
	mapconst ECRUTEAK_LUGIA_SPEECH_HOUSE,                 4,  4 ;  4
	mapconst DANCE_THEATRE,                               7,  6 ;  5
	mapconst ECRUTEAK_MART,                               4,  6 ;  6
	mapconst ECRUTEAK_GYM,                                9,  5 ;  7
	mapconst ECRUTEAK_ITEMFINDER_HOUSE,                   4,  4 ;  8
	mapconst ECRUTEAK_CITY,                              18, 20 ;  9
	mapconst ROUTE_37,                                   10, 10 ; 10
	mapconst VALERIES_HOUSE,                              4,  4 ; 11
	mapconst ECRUTEAK_CHERISH_BALL_HOUSE,                 4,  4 ; 12
	mapconst ECRUTEAK_DESTINY_KNOT_HOUSE,                 4,  4 ; 13

	newgroup                                                    ;  5

	mapconst BLACKTHORN_GYM_1F,                           9,  5 ;  1
	mapconst BLACKTHORN_GYM_2F,                           9,  5 ;  2
	mapconst BLACKTHORN_DRAGON_SPEECH_HOUSE,              4,  4 ;  3
	mapconst BLACKTHORN_EMYS_HOUSE,                       4,  4 ;  4
	mapconst BLACKTHORN_MART,                             4,  6 ;  5
	mapconst BLACKTHORN_POKECENTER_1F,                    4,  6 ;  6
	mapconst MOVE_DELETERS_HOUSE,                         4,  4 ;  7
	mapconst ROUTE_45,                                   46, 12 ;  8
	mapconst ROUTE_46,                                   18, 10 ;  9
	mapconst BLACKTHORN_CITY,                            19, 20 ; 10

	newgroup                                                    ;  6

	mapconst CINNABAR_POKECENTER_1F,                      4,  6 ;  1
	mapconst SEAFOAM_ISLANDS_1F,                         18, 17 ;  2
	mapconst SEAFOAM_GYM,                                12, 12 ;  3
	mapconst SEAFOAM_ISLANDS_B1F,                        10, 20 ;  4
	mapconst SEAFOAM_ISLANDS_B2F,                        10, 20 ;  5
	mapconst SEAFOAM_ISLANDS_B3F,                        10, 20 ;  6
	mapconst SEAFOAM_ISLANDS_B4F,                        10, 20 ;  7
	mapconst ROUTE_19,                                   29, 10 ;  8
	mapconst ROUTE_20,                                    9, 51 ;  9
	mapconst ROUTE_21,                                   48, 10 ; 10
	mapconst URAGA_CHANNEL_WEST,                         15,  6 ; 11
	mapconst CINNABAR_ISLAND,                            11, 12 ; 12
	mapconst CINNABAR_VOLCANO_1F,                        14, 14 ; 13
	mapconst CINNABAR_VOLCANO_B1F,                       18, 18 ; 14
	mapconst CINNABAR_VOLCANO_B2F,                       14, 14 ; 15
	mapconst POKEMON_MANSION_1F,                         14, 15 ; 16
	mapconst POKEMON_MANSION_B1F,                        16, 17 ; 17
	mapconst CINNABAR_LAB,                                9, 16 ; 18
	mapconst SCARY_CAVE_1F,                              17, 20 ; 19
	mapconst SCARY_CAVE_B1F,                             12, 12 ; 20
	mapconst SCARY_CAVE_SHIPWRECK,                        6,  6 ; 21
	mapconst ROUTE_19_BEACH_HOUSE,                        4,  4 ; 22

	newgroup                                                    ;  7

	mapconst CERULEAN_GYM_BADGE_SPEECH_HOUSE,             4,  4 ;  1
	mapconst CERULEAN_POLICE_STATION,                     4,  4 ;  2
	mapconst CERULEAN_TRADE_SPEECH_HOUSE,                 4,  4 ;  3
	mapconst CERULEAN_POKECENTER_1F,                      4,  6 ;  4
	mapconst CERULEAN_GYM,                                8,  5 ;  6
	mapconst CERULEAN_MART,                               4,  6 ;  7
	mapconst ROUTE_10_POKECENTER_1F,                      4,  6 ;  8
	mapconst POWER_PLANT,                                 9, 10 ; 10
	mapconst BILLS_HOUSE,                                 4,  4 ; 11
	mapconst ROUTE_4,                                    10, 33 ; 12
	mapconst ROUTE_24,                                   20, 14 ; 13
	mapconst ROUTE_25,                                   21, 17 ; 14
	mapconst CERULEAN_CAPE,                              19, 25 ; 15
	mapconst CERULEAN_CITY,                              16, 20 ; 16
	mapconst CERULEAN_CAVE_1F,                           12, 17 ; 17
	mapconst CERULEAN_CAVE_2F,                           11, 17 ; 18
	mapconst CERULEAN_CAVE_B1F,                          11, 17 ; 19
	mapconst CERULEAN_BIKE_SHOP,                          4,  4 ; 20
	mapconst CERULEAN_BERRY_POWDER_HOUSE,                 4,  4 ; 21
	mapconst CERULEAN_COUPLE_HOUSE,                       4,  4 ; 22
	mapconst CERULEAN_WATER_SHOW_SPEECH_HOUSE,            4,  4 ; 23

	newgroup                                                    ;  8

	mapconst AZALEA_POKECENTER_1F,                        4,  6 ;  1
	mapconst CHARCOAL_KILN,                               4,  5 ;  2
	mapconst AZALEA_MART,                                 4,  6 ;  3
	mapconst KURTS_HOUSE,                                 4,  8 ;  4
	mapconst AZALEA_GYM,                                  8,  5 ;  5
	mapconst ROUTE_33,                                    9, 10 ;  6
	mapconst AZALEA_TOWN,                                 9, 20 ;  7

	newgroup                                                    ;  9

	mapconst LAKE_OF_RAGE_HIDDEN_POWER_HOUSE,             4,  4 ;  1
	mapconst LAKE_OF_RAGE_MAGIKARP_HOUSE,                 4,  4 ;  2
	mapconst ROUTE_43_MAHOGANY_GATE,                      4,  5 ;  3
	mapconst ROUTE_43_GATE,                               4,  5 ;  4
	mapconst ROUTE_43,                                   27, 10 ;  5
	mapconst LAKE_OF_RAGE,                               18, 20 ;  6

	newgroup                                                    ; 10

	mapconst ROUTE_32,                                   45, 10 ;  1
	mapconst ROUTE_32_COAST,                             36, 15 ;  2
	mapconst VIOLET_CITY,                                20, 20 ;  3
	mapconst VIOLET_MART,                                 4,  6 ;  4
	mapconst VIOLET_GYM,                                  8,  5 ;  5
	mapconst EARLS_POKEMON_ACADEMY,                       8,  4 ;  6
	mapconst VIOLET_NICKNAME_SPEECH_HOUSE,                4,  4 ;  7
	mapconst VIOLET_POKECENTER_1F,                        4,  6 ;  8
	mapconst VIOLET_ONIX_TRADE_HOUSE,                     4,  4 ;  9
	mapconst ROUTE_32_RUINS_OF_ALPH_GATE,                 4,  5 ; 10
	mapconst ROUTE_32_POKECENTER_1F,                      4,  6 ; 11
	mapconst ROUTE_32_COAST_HOUSE,                        4,  4 ; 12
	mapconst MAGNET_TUNNEL_EAST,                         11, 10 ; 13
	mapconst VIOLET_OUTSKIRTS,                            8, 20 ; 14

	newgroup                                                    ; 11

	mapconst ROUTE_34,                                   27, 10 ;  1
	mapconst ROUTE_34_COAST,                             34,  9 ;  2
	mapconst STORMY_BEACH,                               11, 22 ;  3
	mapconst MURKY_SWAMP,                                19, 23 ;  4
	mapconst GOLDENROD_CITY,                             18, 22 ;  5
	mapconst GOLDENROD_GYM,                               9, 10 ;  6
	mapconst GOLDENROD_BIKE_SHOP,                         4,  4 ;  7
	mapconst GOLDENROD_HAPPINESS_RATER,                   4,  4 ;  8
	mapconst GOLDENROD_BILLS_HOUSE,                       4,  4 ;  9
	mapconst GOLDENROD_MAGNET_TRAIN_STATION,              9, 10 ; 10
	mapconst GOLDENROD_FLOWER_SHOP,                       4,  4 ; 11
	mapconst GOLDENROD_PP_SPEECH_HOUSE,                   4,  4 ; 12
	mapconst GOLDENROD_NAME_RATER,                        4,  4 ; 13
	mapconst GOLDENROD_DEPT_STORE_1F,                     4,  8 ; 14
	mapconst GOLDENROD_DEPT_STORE_2F,                     4,  8 ; 15
	mapconst GOLDENROD_DEPT_STORE_3F,                     4,  8 ; 16
	mapconst GOLDENROD_DEPT_STORE_4F,                     4,  8 ; 17
	mapconst GOLDENROD_DEPT_STORE_5F,                     4,  8 ; 18
	mapconst GOLDENROD_DEPT_STORE_6F,                     4,  8 ; 19
	mapconst GOLDENROD_DEPT_STORE_ELEVATOR,               2,  2 ; 20
	mapconst GOLDENROD_DEPT_STORE_ROOF,                   6,  8 ; 21
	mapconst GOLDENROD_GAME_CORNER,                       7, 10 ; 22
	mapconst GOLDENROD_POKECOM_CENTER_1F,                 8, 16 ; 23
	mapconst GOLDENROD_POKECOM_CENTER_OFFICE,             4,  4 ; 24
	mapconst ILEX_FOREST_AZALEA_GATE,                     4,  5 ; 25
	mapconst ROUTE_34_ILEX_FOREST_GATE,                   4,  5 ; 26
	mapconst DAYCARE,                                     4,  4 ; 27
	mapconst GOLDENROD_HP_UP_HOUSE,                       4,  4 ; 28
	mapconst GOLDENROD_NET_BALL_HOUSE,                    4,  4 ; 29
	mapconst GOLDENROD_BAND_HOUSE,                        4,  4 ; 30
	mapconst GOLDENROD_SPEECH_HOUSE,                      4,  4 ; 31
	mapconst MAGNET_TUNNEL_WEST,                         11, 10 ; 32
	mapconst MAGNET_TUNNEL_INSIDE,                       13, 23 ; 33

	newgroup                                                    ; 12

	mapconst ROUTE_6,                                    16, 15 ;  1
	mapconst ROUTE_11,                                    9, 26 ;  2
	mapconst VERMILION_CITY,                             20, 20 ;  3
	mapconst VERMILION_HOUSE_FISHING_SPEECH_HOUSE,        4,  4 ;  4
	mapconst VERMILION_POKECENTER_1F,                     4,  6 ;  5
	mapconst POKEMON_FAN_CLUB,                            4,  5 ;  6
	mapconst VERMILION_MAGNET_TRAIN_SPEECH_HOUSE,         4,  4 ;  7
	mapconst VERMILION_MART,                              4,  6 ;  8
	mapconst VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE,  4,  4 ;  9
	mapconst VERMILION_GYM,                               9,  5 ; 10
	mapconst ROUTE_6_SAFFRON_GATE,                        4,  5 ; 11
	mapconst ROUTE_6_UNDERGROUND_ENTRANCE,                4,  4 ; 12
	mapconst ROUTE_11_GATE,                               5,  5 ; 13
	mapconst ROUTE_11_GATE_2F,                            4,  4 ; 14
	mapconst VERMILION_POLLUTION_SPEECH_HOUSE,            4,  4 ; 15
	mapconst VERMILION_S_S_ANNE_SPEECH_HOUSE,             4,  4 ; 16

	newgroup                                                    ; 13

	mapconst ROUTE_1,                                    18, 12 ;  1
	mapconst PALLET_TOWN,                                 9, 10 ;  2
	mapconst REDS_HOUSE_1F,                               4,  4 ;  3
	mapconst REDS_HOUSE_2F,                               4,  4 ;  4
	mapconst BLUES_HOUSE_1F,                              4,  4 ;  5
	mapconst BLUES_HOUSE_2F,                              4,  4 ;  6
	mapconst OAKS_LAB,                                    6,  5 ;  7

	newgroup                                                    ; 14

	mapconst ROUTE_2_NORTH,                              18, 10 ;  1
	mapconst ROUTE_3,                                    11, 36 ;  2
	mapconst ROUTE_3_POKECENTER_1F,                       4,  6 ;  3
	mapconst PEWTER_CITY,                                18, 20 ;  4
	mapconst PEWTER_NIDORAN_SPEECH_HOUSE,                 4,  4 ;  5
	mapconst PEWTER_GYM,                                  7,  5 ;  6
	mapconst PEWTER_MART,                                 4,  6 ;  7
	mapconst PEWTER_POKECENTER_1F,                        4,  6 ;  8
	mapconst PEWTER_SNOOZE_SPEECH_HOUSE,                  4,  4 ;  9
	mapconst PEWTER_MUSEUM_OF_SCIENCE_1F,                 4, 10 ; 10
	mapconst PEWTER_MUSEUM_OF_SCIENCE_2F,                 4,  7 ; 11

	newgroup                                                    ; 15

	mapconst OLIVINE_PORT,                               16, 10 ;  1
	mapconst VERMILION_PORT,                             13, 10 ;  2
	mapconst FAST_SHIP_1F,                                9, 16 ;  3
	mapconst FAST_SHIP_CABINS_NNW_NNE_NE,                16,  4 ;  4
	mapconst FAST_SHIP_CABINS_SW_SSW_NW,                 16,  4 ;  5
	mapconst FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN,     17,  5 ;  6
	mapconst FAST_SHIP_B1F,                               7, 14 ;  7
	mapconst OLIVINE_PORT_PASSAGE,                       15,  4 ;  8
	mapconst VERMILION_PORT_PASSAGE,                     15,  4 ;  9
	mapconst MOUNT_MOON_SQUARE,                           9, 15 ; 10
	mapconst MOUNT_MOON_GIFT_SHOP,                        4,  4 ; 11
	mapconst TIN_TOWER_ROOF,                              9,  7 ; 12

	newgroup                                                    ; 16

	mapconst ROUTE_23,                                   70, 10 ;  1
	mapconst INDIGO_PLATEAU,                             13, 10 ;  2
	mapconst INDIGO_PLATEAU_POKECENTER_1F,                7,  8 ;  3
	mapconst WILLS_ROOM,                                  9,  5 ;  4
	mapconst KOGAS_ROOM,                                  9,  5 ;  5
	mapconst BRUNOS_ROOM,                                 9,  5 ;  6
	mapconst KARENS_ROOM,                                 9,  5 ;  7
	mapconst LANCES_ROOM,                                12,  5 ;  8
	mapconst HALL_OF_FAME,                                7,  5 ;  9
	mapconst BELLCHIME_TRAIL,                             7, 12 ; 10

	newgroup                                                    ; 17

	mapconst ROUTE_12_SOUTH,                             44, 10 ;  1
	mapconst ROUTE_13_EAST,                              10, 23 ;  2
	mapconst ROUTE_13_WEST,                              10, 12 ;  3
	mapconst ROUTE_14,                                   19, 12 ;  4
	mapconst ROUTE_15,                                    9, 20 ;  5
	mapconst ROUTE_18_EAST,                              11, 14 ;  6
	mapconst FUCHSIA_CITY,                               18, 20 ;  7
	mapconst FUCHSIA_MART,                                4,  6 ;  8
	mapconst FUCHSIA_GYM,                                 9,  5 ;  9
	mapconst FUCHSIA_BILL_SPEECH_HOUSE,                   4,  4 ; 10
	mapconst FUCHSIA_SAFARI_BALL_HOUSE,                   4,  4 ; 11
	mapconst FUCHSIA_POKECENTER_1F,                       4,  6 ; 12
	mapconst SAFARI_ZONE_WARDENS_HOME,                    4,  5 ; 13
	mapconst SAFARI_ZONE_FUCHSIA_GATE,                    4,  5 ; 14
	mapconst ROUTE_12_GATE,                               5,  5 ; 15
	mapconst ROUTE_12_GATE_2F,                            4,  4 ; 16
	mapconst ROUTE_15_FUCHSIA_GATE,                       5,  5 ; 17
	mapconst ROUTE_15_FUCHSIA_GATE_2F,                    4,  4 ; 18
	mapconst ROUTE_19_FUCHSIA_GATE,                       4,  5 ; 19
	mapconst ROUTE_12_SUPER_ROD_HOUSE,                    4,  4 ; 20
	mapconst LUCKY_ISLAND,                               17, 23 ; 21

	newgroup                                                    ; 18

	mapconst ROUTE_8,                                    11, 26 ;  1
	mapconst ROUTE_8_SAFFRON_GATE,                        4,  5 ;  2
	mapconst ROUTE_10_SOUTH,                              9, 10 ;  3
	mapconst ROUTE_12_NORTH,                              9, 10 ;  4
	mapconst LAVENDER_TOWN,                              10, 10 ;  5
	mapconst LAVENDER_POKECENTER_1F,                      4,  6 ;  6
	mapconst MR_FUJIS_HOUSE,                              4,  5 ;  7
	mapconst LAVENDER_TOWN_SPEECH_HOUSE,                  4,  4 ;  8
	mapconst LAVENDER_NAME_RATER,                         4,  4 ;  9
	mapconst LAVENDER_MART,                               4,  6 ; 10
	mapconst SOUL_HOUSE,                                  5,  5 ; 11
	mapconst SOUL_HOUSE_B1F,                              9, 10 ; 12
	mapconst SOUL_HOUSE_B2F,                              9, 10 ; 13
	mapconst SOUL_HOUSE_B3F,                              9,  4 ; 14
	mapconst LAV_RADIO_TOWER_1F,                          4, 10 ; 15
	mapconst LAV_RADIO_TOWER_2F,                          4,  9 ; 16
	mapconst LAV_RADIO_TOWER_3F,                          4,  9 ; 17
	mapconst LAV_RADIO_TOWER_4F,                          4,  9 ; 18
	mapconst LAV_RADIO_TOWER_5F,                          4,  7 ; 19
	mapconst HAUNTED_RADIO_TOWER_2F,                      4,  9 ; 20
	mapconst HAUNTED_RADIO_TOWER_3F,                      4,  9 ; 21
	mapconst HAUNTED_RADIO_TOWER_4F,                      4,  9 ; 22
	mapconst HAUNTED_RADIO_TOWER_5F,                      9,  8 ; 23
	mapconst HAUNTED_RADIO_TOWER_6F,                      9,  8 ; 24

	newgroup                                                    ; 19

	mapconst ROUTE_28,                                    9, 19 ;  1
	mapconst SILVER_CAVE_OUTSIDE,                        15, 20 ;  2
	mapconst SILVER_CAVE_POKECENTER_1F,                   4,  6 ;  3
	mapconst ROUTE_28_FAMOUS_SPEECH_HOUSE,                4,  4 ;  4
	mapconst NAVEL_ROCK_OUTSIDE,                         16, 13 ;  5
	mapconst NAVEL_ROCK_INSIDE,                          45, 20 ;  6
	mapconst NAVEL_ROCK_ROOF,                            11,  8 ;  7
	mapconst FARAWAY_ISLAND,                             23, 17 ;  8
	mapconst FARAWAY_JUNGLE,                             12, 14 ;  9
	mapconst SEAGALLOP_FERRY_VERMILION_GATE,              6,  7 ;  10
	mapconst SEAGALLOP_FERRY_NAVEL_GATE,                  6,  7 ;  11
	mapconst SEAGALLOP_FERRY_SHAMOUTI_GATE,               6,  7 ;  12

	newgroup                                                    ; 20

	mapconst POKECENTER_2F,                               4,  8 ;  1
	mapconst TRADE_CENTER,                                4,  5 ;  2
	mapconst COLOSSEUM,                                   4,  5 ;  3
	mapconst HIDDEN_TREE_GROTTO,                          9,  5 ;  4
	mapconst HIDDEN_CAVE_GROTTO,                         45, 20 ;  5
	mapconst YELLOW_FOREST_GATE,                          4,  5 ;  6
	mapconst YELLOW_FOREST,                              26, 29 ;  7
	mapconst ECRUTEAK_SHRINE_OUTSIDE,                     9,  6 ;  8
	mapconst ECRUTEAK_SHRINE_INSIDE,                      6,  6 ;  9

	newgroup                                                    ; 21

	mapconst ROUTE_7,                                     9, 10 ;  1
	mapconst ROUTE_16_NORTHEAST,                         11, 11 ;  2
	mapconst ROUTE_16_SOUTH,                             11, 11 ;  3
	mapconst ROUTE_17,                                   63, 10 ;  4
	mapconst ROUTE_18_WEST,                               9, 10 ;  5
	mapconst URAGA_CHANNEL_EAST,                          9, 23 ;  6
	mapconst CELADON_CITY,                               18, 22 ;  7
	mapconst CELADON_DEPT_STORE_1F,                       4,  8 ;  8
	mapconst CELADON_DEPT_STORE_2F,                       4,  8 ;  9
	mapconst CELADON_DEPT_STORE_3F,                       4,  8 ; 10
	mapconst CELADON_DEPT_STORE_4F,                       4,  8 ; 11
	mapconst CELADON_DEPT_STORE_5F,                       4,  8 ; 12
	mapconst CELADON_DEPT_STORE_6F,                       4,  8 ; 13
	mapconst CELADON_DEPT_STORE_ELEVATOR,                 2,  2 ; 14
	mapconst CELADON_MANSION_1F,                          5,  4 ; 15
	mapconst CELADON_MANSION_2F,                          5,  4 ; 16
	mapconst CELADON_MANSION_3F,                          5,  4 ; 17
	mapconst CELADON_MANSION_ROOF,                        7,  4 ; 18
	mapconst CELADON_MANSION_ROOF_HOUSE,                  4,  4 ; 19
	mapconst CELADON_POKECENTER_1F,                       4,  6 ; 20
	mapconst CELADON_GAME_CORNER,                         7, 10 ; 21
	mapconst CELADON_GAME_CORNER_PRIZE_ROOM,              4,  4 ; 22
	mapconst CELADON_GYM,                                 9,  5 ; 23
	mapconst CELADON_CAFE,                                4,  6 ; 24
	mapconst CELADON_CHIEF_HOUSE,                         4,  4 ; 25
	mapconst CELADON_HOTEL_1F,                            4,  9 ; 26
	mapconst CELADON_HOTEL_2F,                            2,  9 ; 27
	mapconst CELADON_HOTEL_ROOM_1,                        3,  3 ; 28
	mapconst CELADON_HOTEL_ROOM_2,                        3,  3 ; 29
	mapconst CELADON_HOTEL_ROOM_3,                        3,  3 ; 30
	mapconst CELADON_HOTEL_POOL,                          4,  7 ; 31
	mapconst EUSINES_HOUSE,                               4,  4 ; 32
	mapconst PSYCHIC_INVERS_HOUSE,                        4,  4 ; 33
	mapconst ROUTE_16_FUCHSIA_SPEECH_HOUSE,               4,  4 ; 34
	mapconst ROUTE_16_GATE,                               4,  5 ; 35
	mapconst ROUTE_16_17_GATE,                            5,  5 ; 36
	mapconst ROUTE_16_17_GATE_2F,                         4,  4 ; 37
	mapconst ROUTE_7_SAFFRON_GATE,                        4,  5 ; 38
	mapconst ROUTE_18_GATE,                               5,  5 ; 39
	mapconst ROUTE_18_GATE_2F,                            4,  4 ; 40
	mapconst CELADON_HOME_DECOR_STORE_1F,                 4,  5 ; 41
	mapconst CELADON_HOME_DECOR_STORE_2F,                 4,  5 ; 42
	mapconst CELADON_HOME_DECOR_STORE_3F,                 4,  5 ; 43
	mapconst CELADON_HOME_DECOR_STORE_4F,                 4,  5 ; 44
	mapconst CELADON_UNIVERSITY_1F,                      10, 15 ; 45
	mapconst CELADON_UNIVERSITY_2F,                       7, 13 ; 46
	mapconst CELADON_UNIVERSITY_LIBRARY_1F,               6,  7 ; 47
	mapconst CELADON_UNIVERSITY_LIBRARY_2F,               6,  7 ; 48
	mapconst CELADON_UNIVERSITY_PRINCIPALS_OFFICE,        4,  3 ; 49
	mapconst CELADON_UNIVERSITY_WESTWOODS_OFFICE,         3,  3 ; 50
	mapconst CELADON_UNIVERSITY_WILLOWS_OFFICE,           3,  3 ; 51
	mapconst CELADON_UNIVERSITY_LOUNGE,                   6,  4 ; 52
	mapconst CELADON_UNIVERSITY_CAFETERIA,                4,  8 ; 53
	mapconst CELADON_UNIVERSITY_HYPER_TEST_ROOM,          6,  4 ; 54
	mapconst CELADON_UNIVERSITY_POOL,                     5,  8 ; 55
	mapconst CELADON_UNIVERSITY_CLASSROOM_1,              6,  4 ; 56
	mapconst CELADON_UNIVERSITY_CLASSROOM_2,              6,  4 ; 57
	mapconst CELADON_UNIVERSITY_CLASSROOM_3,              6,  4 ; 58
	mapconst CELADON_UNIVERSITY_CLASSROOM_4,              6,  4 ; 59
	mapconst CELADON_OLD_MAN_SPEECH_HOUSE,                4,  4 ; 60
	mapconst CELADON_DEVELOPMENT_SPEECH_HOUSE,            4,  4 ; 61
	mapconst CELADON_OUTSKIRTS,                           6, 10 ; 62

	newgroup                                                    ; 22

	mapconst ROUTE_40,                                   20, 10 ;  1
	mapconst ROUTE_41,                                   27, 32 ;  2
	mapconst CIANWOOD_CITY,                              27, 15 ;  3
	mapconst MANIAS_HOUSE,                                4,  4 ;  4
	mapconst CIANWOOD_GYM,                                9,  5 ;  5
	mapconst CIANWOOD_POKECENTER_1F,                      4,  6 ;  6
	mapconst CIANWOOD_PHARMACY,                           4,  4 ;  7
	mapconst CIANWOOD_CITY_PHOTO_STUDIO,                  4,  4 ;  8
	mapconst CIANWOOD_LUGIA_SPEECH_HOUSE,                 4,  4 ;  9
	mapconst STATS_JUDGES_HOUSE,                          4,  4 ; 10
	mapconst BATTLE_TOWER_1F,                             7, 11 ; 11
	mapconst BATTLE_TOWER_2F,                             5, 11 ; 12
	mapconst BATTLE_TOWER_BATTLE_ROOM,                    4,  4 ; 13
	mapconst BATTLE_TOWER_ELEVATOR,                       2,  2 ; 14
	mapconst BATTLE_TOWER_HALLWAY,                        2, 11 ; 15
	mapconst ROUTE_40_BATTLE_TOWER_GATE,                  4,  5 ; 16
	mapconst BATTLE_TOWER_OUTSIDE,                       13, 10 ; 17

	newgroup                                                    ; 23

	mapconst ROUTE_2_SOUTH,                              18, 10 ;  1
	mapconst ROUTE_22,                                    9, 15 ;  2
	mapconst VIRIDIAN_CITY,                              18, 20 ;  3
	mapconst VIRIDIAN_GYM,                               23,  7 ;  4
	mapconst VIRIDIAN_NICKNAME_SPEECH_HOUSE,              4,  4 ;  5
	mapconst VIRIDIAN_SCHOOL_HOUSE,                       5,  4 ;  6
	mapconst TRAINER_HOUSE_1F,                            6,  5 ;  7
	mapconst TRAINER_HOUSE_B1F,                           8,  5 ;  8
	mapconst VIRIDIAN_MART,                               4,  6 ;  9
	mapconst VIRIDIAN_POKECENTER_1F,                      4,  6 ; 11
	mapconst ROUTE_2_NUGGET_SPEECH_HOUSE,                 4,  4 ; 12
	mapconst ROUTE_2_GATE,                                4,  5 ; 13
	mapconst POKEMON_LEAGUE_GATE,                         9, 11 ; 14
	mapconst VIRIDIAN_FOREST,                            26, 19 ; 15
	mapconst VIRIDIAN_FOREST_VIRIDIAN_GATE,                4, 5 ; 16
	mapconst VIRIDIAN_FOREST_PEWTER_GATE,                  4, 5 ; 17
	mapconst ROUTE_1_VIRIDIAN_GATE,                        4, 5 ; 18
	mapconst ROUTE_16_NORTHWEST,                         11, 11 ; 19
	mapconst ROUTE_16_WEST,                              11, 34 ; 20

	newgroup                                                    ; 24

	mapconst ROUTE_26,                                   54, 10 ;  1
	mapconst ROUTE_27,                                    9, 40 ;  2
	mapconst ROUTE_29,                                    9, 30 ;  3
	mapconst NEW_BARK_TOWN,                               9, 10 ;  4
	mapconst ELMS_LAB,                                    6,  5 ;  5
	mapconst KRISS_HOUSE_1F,                              4,  5 ;  6
	mapconst KRISS_HOUSE_2F,                              3,  4 ;  7
	mapconst KRISS_NEIGHBORS_HOUSE,                       4,  4 ;  8
	mapconst LYRAS_HOUSE_1F,                              4,  5 ;  9
	mapconst LYRAS_HOUSE_2F,                              3,  4 ; 10
	mapconst ELMS_HOUSE,                                  4,  4 ; 11
	mapconst ROUTE_26_HEAL_SPEECH_HOUSE,                  4,  4 ; 12
	mapconst ROUTE_26_DAY_OF_WEEK_SIBLINGS_HOUSE,         4,  4 ; 13
	mapconst ROUTE_27_REST_HOUSE,                         4,  4 ; 14
	mapconst ROUTE_29_46_GATE,                            4,  5 ; 15

	newgroup                                                    ; 25

	mapconst FIGHTING_DOJO,                               6,  5 ;  1
	mapconst SAFFRON_GYM,                                 9, 10 ;  2
	mapconst SAFFRON_MART,                                4,  6 ;  3
	mapconst SAFFRON_POKECENTER_1F,                       4,  6 ;  4
	mapconst MR_PSYCHICS_HOUSE,                           4,  4 ;  5
	mapconst SAFFRON_TRAIN_STATION,                       9, 10 ;  6
	mapconst SILPH_CO_1F,                                 4,  8 ;  7
	mapconst SILPH_CO_2F,                                 4,  8 ;  8
	mapconst SILPH_CO_3F,                                 4,  8 ;  9
	mapconst COPYCATS_HOUSE_1F,                           4,  4 ; 10
	mapconst COPYCATS_HOUSE_2F,                           3,  4 ; 11
	mapconst ROUTE_5,                                    17, 10 ; 12
	mapconst ROUTE_5_UNDERGROUND_ENTRANCE,                4,  4 ; 13
	mapconst ROUTE_5_SAFFRON_CITY_GATE,                   4,  5 ; 14
	mapconst ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE,            4,  4 ; 15
	mapconst POKEMON_TRAINER_FAN_CLUB,                    5,  4 ; 16
	mapconst SAFFRON_HITMONTOP_KID_HOUSE,                 4,  4 ; 17
	mapconst SAFFRON_BOOK_SPEECH_HOUSE,                   4,  4 ; 18
	mapconst SAFFRON_ORRE_SPEECH_HOUSE,                   4,  4 ; 19
	mapconst SAFFRON_RICH_SPEECH_HOUSE,                   4,  4 ; 20

	newgroup                                                    ; 26

	mapconst ROUTE_30,                                   27, 10 ;  1
	mapconst ROUTE_31,                                    9, 22 ;  2
	mapconst CHERRYGROVE_BAY,                            25, 15 ;  3
	mapconst CHERRYGROVE_CITY,                           10, 20 ;  4
	mapconst CHERRYGROVE_MART,                            4,  6 ;  5
	mapconst CHERRYGROVE_POKECENTER_1F,                   4,  6 ;  6
	mapconst CHERRYGROVE_GYM_SPEECH_HOUSE,                4,  4 ;  7
	mapconst GUIDE_GENTS_HOUSE,                           4,  4 ;  8
	mapconst CHERRYGROVE_EVOLUTION_SPEECH_HOUSE,          4,  4 ;  9
	mapconst ROUTE_30_BERRY_SPEECH_HOUSE,                 4,  4 ; 10
	mapconst MR_POKEMONS_HOUSE,                           4,  4 ; 11
	mapconst ROUTE_31_VIOLET_GATE,                        4,  5 ; 12

	newgroup                                                    ; 27

	mapconst CLIFF_EDGE_GATE,                            11, 10 ;  1
	mapconst CLIFF_CAVE,                                 18,  6 ;  2
	mapconst ROUTE_47,                                   19, 39 ;  3
	mapconst ROUTE_48,                                   11, 18 ;  4
	mapconst QUIET_CAVE_1F,                              18, 18 ;  5
	mapconst QUIET_CAVE_B1F,                             18, 18 ;  6
	mapconst QUIET_CAVE_B2F,                             18, 18 ;  7
	mapconst QUIET_CAVE_B3F,                             18, 18 ;  8

	newgroup                                                    ; 28

	mapconst ROUTE_9,                                     9, 26 ;  1
	mapconst ROUTE_10_NORTH,                             29, 10 ;  2
	mapconst DIM_CAVE_1F,                                18, 17 ;  3
	mapconst DIM_CAVE_2F,                                18, 17 ;  4
	mapconst DIM_CAVE_3F,                                17, 16 ;  5
	mapconst DIM_CAVE_4F,                                16, 16 ;  6
	mapconst DIM_CAVE_5F,                                17, 17 ;  7

	newgroup                                                    ; 29

	mapconst GOLDENROD_HARBOR,                           18, 24 ;  1
	mapconst GOLDENROD_HARBOR_GATE,                       4,  5 ;  2

	newgroup                                                    ; 30

	mapconst RUINS_OF_ALPH_OUTSIDE,                      21, 11 ;  1
	mapconst RUINS_OF_ALPH_HO_OH_CHAMBER,                 5,  4 ;  2
	mapconst RUINS_OF_ALPH_KABUTO_CHAMBER,                5,  4 ;  3
	mapconst RUINS_OF_ALPH_OMANYTE_CHAMBER,               5,  4 ;  4
	mapconst RUINS_OF_ALPH_AERODACTYL_CHAMBER,            5,  4 ;  5
	mapconst RUINS_OF_ALPH_ENTRANCE_CHAMBER,              4,  4 ;  6
	mapconst RUINS_OF_ALPH_INNER_CHAMBER,                14, 10 ;  7
	mapconst RUINS_OF_ALPH_RESEARCH_CENTER,               4,  4 ;  8
	mapconst RUINS_OF_ALPH_HO_OH_ITEM_ROOM,               5,  4 ;  9
	mapconst RUINS_OF_ALPH_KABUTO_ITEM_ROOM,              5,  4 ; 10
	mapconst RUINS_OF_ALPH_OMANYTE_ITEM_ROOM,             5,  4 ; 11
	mapconst RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM,          5,  4 ; 12
	mapconst RUINS_OF_ALPH_HO_OH_WORD_ROOM,              12, 10 ; 13
	mapconst RUINS_OF_ALPH_KABUTO_WORD_ROOM,              7, 10 ; 14
	mapconst RUINS_OF_ALPH_OMANYTE_WORD_ROOM,             8, 10 ; 15
	mapconst RUINS_OF_ALPH_AERODACTYL_WORD_ROOM,          7, 10 ; 16
	mapconst RUINS_OF_ALPH_SINJOH_CHAMBER,                5,  5 ; 17
	mapconst ROUTE_22_PAST,                               6,  6 ; 18

	newgroup                                                    ; 31

	mapconst SHAMOUTI_ISLAND,                            15, 18 ;  1
	mapconst BEAUTIFUL_BEACH,                            15, 21 ;  2
	mapconst WARM_BEACH,                                 13, 12 ;  3
	mapconst SHAMOUTI_COAST,                             10, 48 ;  4
	mapconst ROCKY_BEACH,                                15, 20 ;  5
	mapconst SHAMOUTI_TUNNEL,                            10, 18 ;  6
	mapconst NOISY_FOREST,                               20, 22 ;  7
	mapconst SHAMOUTI_POKECENTER_1F,                      4,  6 ;  8
	mapconst SHAMOUTI_HOTEL_1F,                           4,  9 ;  9
	mapconst SHAMOUTI_HOTEL_2F,                           2,  9 ; 10
	mapconst SHAMOUTI_HOTEL_3F,                           2,  9 ; 11
	mapconst SHAMOUTI_HOTEL_ROOM_2A,                      3,  3 ; 12
	mapconst SHAMOUTI_HOTEL_ROOM_2B,                      3,  3 ; 13
	mapconst SHAMOUTI_HOTEL_ROOM_3B,                      3,  3 ; 14
	mapconst SHAMOUTI_HOTEL_ROOM_3C,                      3,  3 ; 15
	mapconst SHAMOUTI_HOTEL_RESTAURANT,                   4,  9 ; 16
	mapconst SHAMOUTI_TOURIST_CENTER,                     4,  4 ; 17
	mapconst SHAMOUTI_MERCHANT,                           4,  4 ; 18
	mapconst SHAMOUTI_HOUSE,                              4,  4 ; 19
	mapconst BEAUTIFUL_BEACH_VILLA,                       4,  6 ; 20
	mapconst WARM_BEACH_SHACK,                            4,  4 ; 21
	mapconst WARM_BEACH_HOUSE,                            4,  4 ; 22
	mapconst ROCKY_BEACH_HOUSE,                           4,  4 ; 23
	mapconst FIRE_ISLAND,                                16, 13 ; 24
	mapconst FIRE_ISLAND_ROOF,                            6,  6 ; 25
	mapconst ICE_ISLAND,                                 16, 13 ; 26
	mapconst ICE_ISLAND_ROOF,                             6,  6 ; 27
	mapconst LIGHTNING_ISLAND,                           16, 13 ; 28
	mapconst LIGHTNING_ISLAND_ROOF,                       6,  6 ; 29

	newgroup                                                    ; 32

	mapconst SAFARI_ZONE_HUB,                            16, 17 ;  1
	mapconst SAFARI_ZONE_EAST,                           15, 17 ;  2
	mapconst SAFARI_ZONE_NORTH,                          20, 22 ;  3
	mapconst SAFARI_ZONE_WEST,                           15, 17 ;  4
	mapconst SAFARI_ZONE_HUB_REST_HOUSE,                  4,  4 ;  5
	mapconst SAFARI_ZONE_EAST_REST_HOUSE,                 4,  4 ;  6
	mapconst SAFARI_ZONE_NORTH_REST_HOUSE,                4,  4 ;  7
	mapconst SAFARI_ZONE_WEST_REST_HOUSE_1,               4,  4 ;  8
	mapconst SAFARI_ZONE_WEST_REST_HOUSE_2,               4,  4 ;  9

	newgroup                                                    ; 33

	mapconst VALENCIA_ISLAND,                            12, 14 ;  1
	mapconst ROUTE_49,                                   11, 20 ;  2
	mapconst IVYS_LAB,                                    6,  5 ;  3
	mapconst IVYS_HOUSE,                                  4,  4 ;  4
	mapconst VALENCIA_HOUSE,                              4,  4 ;  5
	mapconst VALENCIA_PORT,                               9, 11 ;  6

	newgroup                                                    ; 34

	mapconst SINJOH_RUINS,                               13,  9 ;  1
	mapconst SINJOH_RUINS_HOUSE,                           4, 4 ;  2
	mapconst MYSTRI_STAGE,                                9,  7 ;  3
	mapconst EMBEDDED_TOWER,                             12,  7 ;  4

	newgroup                                                    ; 35

	mapconst SAFFRON_CITY,                               19, 20 ;  1
	mapconst SHAMOUTI_SHRINE_RUINS,                      17, 12 ;  2

	newgroup                                                    ; 36

	mapconst ROUTE_35,                                   18, 12 ;  1
	mapconst ROUTE_36,                                    9, 32 ;  2
	mapconst ROUTE_35_GOLDENROD_GATE,                     4,  5 ;  3
	mapconst ROUTE_35_NATIONAL_PARK_GATE,                 4, 10 ;  4
	mapconst ROUTE_36_RUINS_OF_ALPH_GATE,                 4,  5 ;  5
	mapconst ROUTE_36_NATIONAL_PARK_GATE,                 4,  5 ;  6
	mapconst ROUTE_36_VIOLET_GATE,                        4,  5 ;  7
