MACRO overcast_area
	assert const_value < $ff, "overcast_area overflow"
	const \1
	for x, 2, _NARG + 1
		map_id \<x>
	endr
	db -1 ; terminator
ENDM

RandomAliasedOvercastMapGroups:
	const_def NUM_MAP_GROUPS + 1 ; aliased groups start after normal groups
	overcast_area AREA_CHERRYGROVE_BAY, CHERRYGROVE_BAY, CHERRYGROVE_TRAIN_TRACK_DUAL
	overcast_area AREA_ROUTE_32, ROUTE_32, MAGNET_TUNNEL_EAST
	overcast_area AREA_AZALEA, AZALEA_TOWN, ROUTE_33
	overcast_area AREA_ROUTE_34, ROUTE_34, ROUTE_34_COAST
	overcast_area AREA_GOLDENROD, GOLDENROD_CITY, MAGNET_TUNNEL_WEST
	overcast_area AREA_NATIONAL_PARK, NATIONAL_PARK, NATIONAL_PARK_BUG_CONTEST
	overcast_area AREA_ECRUTEAK, ECRUTEAK_CITY, ECRUTEAK_SHRINE_OUTSIDE
	overcast_area AREA_ROUTE_35_COAST, ROUTE_35_COAST_NORTH, ROUTE_35_COAST_SOUTH
	overcast_area AREA_ROUTE_40, ROUTE_40, BATTLE_TOWER_OUTSIDE
	overcast_area AREA_ROUTES_47_48, ROUTE_47, ROUTE_48
	overcast_area AREA_ROUTE_42, ROUTE_42, VIOLET_OUTSKIRTS
	overcast_area AREA_LAKE_OF_RAGE, ROUTE_43, LAKE_OF_RAGE
	overcast_area AREA_ROUTE_2, ROUTE_2_NORTH, ROUTE_2_SOUTH
	overcast_area AREA_ROUTE_10, ROUTE_10_NORTH, ROUTE_10_SOUTH
	overcast_area AREA_ROUTE_12, ROUTE_12_NORTH, ROUTE_12_SOUTH
	overcast_area AREA_ROUTE_16, ROUTE_16_EAST, ROUTE_16_NORTH, ROUTE_16_WEST
	overcast_area AREA_ROUTE_17, ROUTE_17_NORTH, ROUTE_17_SOUTH
	overcast_area AREA_ROUTE_18, ROUTE_18_EAST, ROUTE_18_WEST
	overcast_area AREA_URAGA_CHANNEL, URAGA_CHANNEL_EAST, URAGA_CHANNEL_WEST

MACRO overcast_map
	const_skip
	if !DEF(GROUP_\1) && STRFIND("\1", "AREA_") == 0
		db \1, 0
	else
		map_id \1
	endc
ENDM

RandomOvercastMapsJohto:
	const_def
	overcast_map BLACKTHORN_CITY
	overcast_map CHERRYGROVE_CITY
	overcast_map CIANWOOD_CITY
	overcast_map GOLDENROD_HARBOR
	overcast_map MAHOGANY_TOWN
	overcast_map NEW_BARK_TOWN
	overcast_map OLIVINE_CITY
	overcast_map OLIVINE_CITY_ROUTE_35_COAST_DUAL
	overcast_map OLIVINE_PORT
	overcast_map ROUTE_29
	overcast_map ROUTE_30
	overcast_map ROUTE_31
	overcast_map ROUTE_32_COAST
	overcast_map ROUTE_35
	overcast_map ROUTE_36
	overcast_map ROUTE_37
	overcast_map ROUTE_38
	overcast_map ROUTE_39
	overcast_map ROUTE_41
	overcast_map ROUTE_44
	overcast_map ROUTE_45
	overcast_map ROUTE_46
	overcast_map RUINS_OF_ALPH_OUTSIDE
	overcast_map SILVER_CAVE_OUTSIDE
	overcast_map STORMY_BEACH
	overcast_map VIOLET_CITY
	; aliases
	overcast_map AREA_CHERRYGROVE_BAY
	overcast_map AREA_ROUTE_32
	overcast_map AREA_AZALEA
	overcast_map AREA_ROUTE_34
	overcast_map AREA_GOLDENROD
	overcast_map AREA_NATIONAL_PARK
	overcast_map AREA_ECRUTEAK
	overcast_map AREA_ROUTE_35_COAST
	overcast_map AREA_ROUTE_40
	overcast_map AREA_ROUTES_47_48
	overcast_map AREA_ROUTE_42
	overcast_map AREA_LAKE_OF_RAGE
	DEF NUM_JOHTO_OVERCAST_MAPS EQU const_value

RandomOvercastMapsKanto:
	const_def
	overcast_map CELADON_CITY
	overcast_map CERULEAN_CAPE
	overcast_map CERULEAN_CITY
	overcast_map CINNABAR_ISLAND
	overcast_map FUCHSIA_CITY
	overcast_map INDIGO_PLATEAU
	overcast_map LAVENDER_TOWN
	overcast_map LUCKY_ISLAND
	overcast_map MOUNT_MOON_SQUARE
	overcast_map PALLET_TOWN
	overcast_map PEWTER_CITY
	overcast_map ROUTE_1
	overcast_map ROUTE_3
	overcast_map ROUTE_4
	overcast_map ROUTE_5
	overcast_map ROUTE_6
	overcast_map ROUTE_7
	overcast_map ROUTE_8
	overcast_map ROUTE_9
	overcast_map ROUTE_11
	overcast_map ROUTE_13
	overcast_map ROUTE_14
	overcast_map ROUTE_15
	overcast_map ROUTE_19
	overcast_map ROUTE_20
	overcast_map ROUTE_21
	overcast_map ROUTE_22
	overcast_map ROUTE_23_NORTH
	overcast_map ROUTE_23_SOUTH
	overcast_map ROUTE_24
	overcast_map ROUTE_25
	overcast_map ROUTE_26
	overcast_map ROUTE_27
	overcast_map ROUTE_28
	overcast_map SAFFRON_CITY
	overcast_map VERMILION_CITY
	overcast_map VERMILION_PORT
	overcast_map VIRIDIAN_CITY
	; aliases
	overcast_map AREA_ROUTE_2
	overcast_map AREA_ROUTE_10
	overcast_map AREA_ROUTE_12
	overcast_map AREA_ROUTE_16
	overcast_map AREA_ROUTE_17
	overcast_map AREA_ROUTE_18
	overcast_map AREA_URAGA_CHANNEL
	DEF NUM_KANTO_OVERCAST_MAPS EQU const_value
