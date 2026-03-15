MACRO harsh_sun_area
	assert const_value < $ff, "harsh_sun_area overflow"
	const \1
	for x, 2, _NARG + 1
		map_id \<x>
	endr
	db -1 ; terminator
ENDM

HarshSunAliasedMapGroups:
	const_def NUM_MAP_GROUPS + 1 ; aliased groups start after normal groups
	harsh_sun_area SUN_AREA_ROUTE_32, ROUTE_32, MAGNET_TUNNEL_EAST
	harsh_sun_area SUN_AREA_AZALEA, AZALEA_TOWN, ROUTE_33
	harsh_sun_area SUN_AREA_ROUTE_34, ROUTE_34, ROUTE_34_COAST
	harsh_sun_area SUN_AREA_GOLDENROD, GOLDENROD_CITY, MAGNET_TUNNEL_WEST
	harsh_sun_area SUN_AREA_NATIONAL_PARK, NATIONAL_PARK, NATIONAL_PARK_BUG_CONTEST
	harsh_sun_area SUN_AREA_ECRUTEAK, ECRUTEAK_CITY, ECRUTEAK_SHRINE_OUTSIDE, BELLCHIME_TRAIL
	harsh_sun_area SUN_AREA_ROUTE_35_COAST, ROUTE_35_COAST_NORTH, ROUTE_35_COAST_SOUTH
	harsh_sun_area SUN_AREA_ROUTE_40, ROUTE_40, BATTLE_TOWER_OUTSIDE
	harsh_sun_area SUN_AREA_ROUTES_47_48, ROUTE_47, ROUTE_48
	harsh_sun_area SUN_AREA_ROUTE_42, ROUTE_42, VIOLET_OUTSKIRTS
	harsh_sun_area SUN_AREA_LAKE_OF_RAGE, ROUTE_43, LAKE_OF_RAGE
	harsh_sun_area SUN_AREA_ROUTE_2, ROUTE_2_NORTH, ROUTE_2_SOUTH
	harsh_sun_area SUN_AREA_ROUTE_10, ROUTE_10_NORTH, ROUTE_10_SOUTH
	harsh_sun_area SUN_AREA_ROUTE_12, ROUTE_12_NORTH, ROUTE_12_SOUTH
	harsh_sun_area SUN_AREA_ROUTE_13, ROUTE_13_EAST, ROUTE_13_WEST
	harsh_sun_area SUN_AREA_ROUTE_16, ROUTE_16_EAST, ROUTE_16_NORTH, ROUTE_16_WEST
	harsh_sun_area SUN_AREA_ROUTE_17, ROUTE_17_NORTH, ROUTE_17_SOUTH
	harsh_sun_area SUN_AREA_ROUTE_18, ROUTE_18_EAST, ROUTE_18_WEST
	harsh_sun_area SUN_AREA_URAGA_CHANNEL, URAGA_CHANNEL_EAST, URAGA_CHANNEL_WEST

MACRO harsh_sun_map
	const_skip
	if !DEF(GROUP_\1) && STRFIND("\1", "SUN_AREA_") == 0
		db \1, 0
	else
		map_id \1
	endc
ENDM

HarshSunMapsJohto:
	const_def
	harsh_sun_map BLACKTHORN_CITY
	harsh_sun_map CHERRYGROVE_BAY
	harsh_sun_map CHERRYGROVE_CITY
	harsh_sun_map CIANWOOD_CITY
	harsh_sun_map GOLDENROD_HARBOR
	harsh_sun_map MAHOGANY_TOWN
	harsh_sun_map NEW_BARK_TOWN
	harsh_sun_map OLIVINE_CITY
	harsh_sun_map OLIVINE_CITY_ROUTE_35_COAST_DUAL
	harsh_sun_map OLIVINE_PORT
	harsh_sun_map ROUTE_29
	harsh_sun_map ROUTE_30
	harsh_sun_map ROUTE_31
	harsh_sun_map ROUTE_32_COAST
	harsh_sun_map ROUTE_35
	harsh_sun_map ROUTE_36
	harsh_sun_map ROUTE_37
	harsh_sun_map ROUTE_38
	harsh_sun_map ROUTE_39
	harsh_sun_map ROUTE_41
	harsh_sun_map ROUTE_44
	harsh_sun_map ROUTE_45
	harsh_sun_map ROUTE_46
	harsh_sun_map RUINS_OF_ALPH_OUTSIDE
	harsh_sun_map SILVER_CAVE_OUTSIDE
	harsh_sun_map SINJOH_RUINS
	harsh_sun_map STORMY_BEACH
	harsh_sun_map VIOLET_CITY
	harsh_sun_map YELLOW_FOREST
	; aliases
	harsh_sun_map SUN_AREA_ROUTE_32
	harsh_sun_map SUN_AREA_AZALEA
	harsh_sun_map SUN_AREA_ROUTE_34
	harsh_sun_map SUN_AREA_GOLDENROD
	harsh_sun_map SUN_AREA_NATIONAL_PARK
	harsh_sun_map SUN_AREA_ECRUTEAK
	harsh_sun_map SUN_AREA_ROUTE_35_COAST
	harsh_sun_map SUN_AREA_ROUTE_40
	harsh_sun_map SUN_AREA_ROUTES_47_48
	harsh_sun_map SUN_AREA_ROUTE_42
	harsh_sun_map SUN_AREA_LAKE_OF_RAGE
	DEF NUM_JOHTO_HARSH_SUN_MAPS EQU const_value

HarshSunMapsKanto:
	const_def
	harsh_sun_map BEAUTIFUL_BEACH
	harsh_sun_map CELADON_CITY
	harsh_sun_map CERULEAN_CAPE
	harsh_sun_map CERULEAN_CITY
	harsh_sun_map CINNABAR_ISLAND
	harsh_sun_map FARAWAY_ISLAND
	harsh_sun_map FARAWAY_JUNGLE
	harsh_sun_map FIRE_ISLAND_ROOF
	harsh_sun_map FUCHSIA_CITY
	harsh_sun_map ICE_ISLAND_ROOF
	harsh_sun_map INDIGO_PLATEAU
	harsh_sun_map LAVENDER_TOWN
	harsh_sun_map LIGHTNING_ISLAND_ROOF
	harsh_sun_map LUCKY_ISLAND
	harsh_sun_map MOUNT_MOON_SQUARE
	harsh_sun_map PALLET_TOWN
	harsh_sun_map PEWTER_CITY
	harsh_sun_map ROCKY_BEACH
	harsh_sun_map ROUTE_1
	harsh_sun_map ROUTE_11
	harsh_sun_map ROUTE_14
	harsh_sun_map ROUTE_15
	harsh_sun_map ROUTE_19
	harsh_sun_map ROUTE_20
	harsh_sun_map ROUTE_21
	harsh_sun_map ROUTE_22
	harsh_sun_map ROUTE_23_NORTH
	harsh_sun_map ROUTE_23_SOUTH
	harsh_sun_map ROUTE_24
	harsh_sun_map ROUTE_25
	harsh_sun_map ROUTE_26
	harsh_sun_map ROUTE_27
	harsh_sun_map ROUTE_28
	harsh_sun_map ROUTE_3
	harsh_sun_map ROUTE_4
	harsh_sun_map ROUTE_49
	harsh_sun_map ROUTE_5
	harsh_sun_map ROUTE_6
	harsh_sun_map ROUTE_7
	harsh_sun_map ROUTE_8
	harsh_sun_map ROUTE_9
	harsh_sun_map SAFARI_ZONE_EAST
	harsh_sun_map SAFARI_ZONE_HUB
	harsh_sun_map SAFARI_ZONE_NORTH
	harsh_sun_map SAFARI_ZONE_WEST
	harsh_sun_map SAFFRON_CITY
	harsh_sun_map SHAMOUTI_COAST
	harsh_sun_map SHAMOUTI_ISLAND
	harsh_sun_map SHAMOUTI_SHRINE_RUINS
	harsh_sun_map VALENCIA_ISLAND
	harsh_sun_map VERMILION_CITY
	harsh_sun_map VERMILION_PORT
	harsh_sun_map VIRIDIAN_CITY
	harsh_sun_map VIRIDIAN_FOREST
	harsh_sun_map WARM_BEACH
	; aliases
	harsh_sun_map SUN_AREA_ROUTE_2
	harsh_sun_map SUN_AREA_ROUTE_10
	harsh_sun_map SUN_AREA_ROUTE_12
	harsh_sun_map SUN_AREA_ROUTE_13
	harsh_sun_map SUN_AREA_ROUTE_16
	harsh_sun_map SUN_AREA_ROUTE_17
	harsh_sun_map SUN_AREA_ROUTE_18
	harsh_sun_map SUN_AREA_URAGA_CHANNEL
	DEF NUM_KANTO_HARSH_SUN_MAPS EQU const_value
