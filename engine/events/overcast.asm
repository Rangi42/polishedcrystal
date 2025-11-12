GetOvercastIndex::
; Some maps are overcast, depending on certain conditions
	; we never overcast until after slowpokes appear in Azalea Town
	eventflagcheck EVENT_AZALEA_TOWN_SLOWPOKES
	jr nz, .not_overcast
	; roll for generic overcast conditions
	call CheckGenericOvercast
	cp GENERIC_OVERCAST
	ret z

	; we may have extra overcast conditions for specific maps
	ld a, [wMapGroup]
	cp GROUP_AZALEA_TOWN ; GROUP_ROUTE_33
	jr z, .azalea_route_33
	cp GROUP_LAKE_OF_RAGE ; GROUP_ROUTE_43
	jr z, .lake_of_rage_route_43
	cp GROUP_STORMY_BEACH ; GROUP_GOLDENROD_CITY, GROUP_MAGNET_TUNNEL_WEST, GROUP_ROUTE_34, GROUP_ROUTE_34_COAST
	jr z, .stormy_beach_goldenrod_city_route_34
.not_overcast:
	xor a ; NOT_OVERCAST
	ret

.azalea_route_33:
; Azalea Town and Route 33
	ld a, [wMapNumber]
	cp MAP_AZALEA_TOWN
	jr z, .azalea_town
	cp MAP_ROUTE_33
	jr nz, .not_overcast
.azalea_town
; Overcast on Sunday, Tuesday, Thursday, and Saturday
	call GetWeekday
	cp MONDAY
	jr z, .not_overcast
	cp WEDNESDAY
	jr z, .not_overcast
	cp FRIDAY
	jr z, .not_overcast
	ld a, AZALEA_OVERCAST
	ret

.lake_of_rage_route_43:
; Lake of Rage and Route 43
	ld a, [wMapNumber]
	cp MAP_LAKE_OF_RAGE
	jr z, .lake_of_rage
	cp MAP_ROUTE_43
	jr nz, .not_overcast
.lake_of_rage
; Always overcast until civilians appear (Team Rocket beaten)
	eventflagcheck EVENT_LAKE_OF_RAGE_CIVILIANS
	jr nz, .overcast_lake_of_rage
; Overcast on Monday, Wednesday, and Friday
	call GetWeekday
	cp MONDAY
	jr z, .overcast_lake_of_rage
	cp WEDNESDAY
	jr z, .overcast_lake_of_rage
	cp FRIDAY
	jr nz, .not_overcast
.overcast_lake_of_rage
	ld a, LAKE_OF_RAGE_OVERCAST
	ret

.stormy_beach_goldenrod_city_route_34:
; Stormy Beach, Goldenrod City, Magnet Tunnel West, Route 34, Route 34 Coast
	ld a, [wMapNumber]
; Stormy Beach is always overcast
	cp MAP_STORMY_BEACH
	jr z, .overcast_stormy_beach
	cp MAP_ROUTE_34_COAST
	jr z, .maybe_stormy_beach
	cp MAP_ROUTE_34
	jr z, .maybe_stormy_beach
	cp MAP_MAGNET_TUNNEL_WEST
	jr z, .maybe_stormy_beach
	cp MAP_GOLDENROD_CITY
	jr nz, .not_overcast
.maybe_stormy_beach
; Only overcast while Team Rocket is present
	eventflagcheck EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	jr nz, .not_overcast
.overcast_stormy_beach
	ld a, STORMY_BEACH_OVERCAST
	ret

CheckGenericOvercast:
	; Skip indoor/cave/gate/dungeon environments
	ld a, [wEnvironment]
	cp TOWN
	jr z, .can_overcast
	cp ROUTE
	jr z, .can_overcast
	cp ISOLATED
	jr nz, .not_overcast

.can_overcast
	ld a, [wOvercastRandomDay]
	ld b, a
	ld a, [wCurDay]
	cp b
	ld [wOvercastRandomDay], a
	call nz, GenerateNewRandomOvercastMaps

	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a

	ld d, 4
	ld hl, wOvercastRandomMaps
.loop_overcast_maps
	ld a, [hli]
	ld [wOvercastCurIntensity], a
	ld a, [hli]
	cp NUM_MAP_GROUPS + 1
	jr nc, .aliased_group
	; normal group
	cp b
	jr nz, .skip_map
	ld a, [hli]
	cp c
	jr z, .overcast
	dec d
	jr nz, .loop_overcast_maps
	jr .not_overcast

.skip_map
	inc hl
	dec d
	jr nz, .loop_overcast_maps
	jr .not_overcast

.aliased_group
	push hl
	call GetAliasedGroup
.alias_loop
	ld a, [hli]
	cp -1
	jr z, .not_overcast_pop_hl
	cp b
	jr nz, .check_next_alias_map
	ld a, [hli]
	cp c
	jr z, .found_map_in_alias
	jr .alias_loop

.check_next_alias_map
	inc hl
	jr .alias_loop

.found_map_in_alias
	pop hl
	jr .overcast

.not_overcast_pop_hl
	pop hl
.not_overcast
	xor a
	ret

.overcast
	ld a, GENERIC_OVERCAST
	ret

; @input: a = alias id
; @output: hl = aliased group pointer
GetAliasedGroup:
	push bc
	sub NUM_MAP_GROUPS + 1
	ld b, a
	ld hl, RandomAliasedOvercastMapGroups
.outer_loop
	ld a, b
	and a
	jr z, .found
	; consume bytes until we are past the terminator
.inner_loop
	ld a, [hli]
	inc a
	jr nz, .inner_loop
	dec b
	jr .outer_loop

.found
	pop bc
	ret

GenerateNewRandomOvercastMaps:
	ld a, NUM_JOHTO_OVERCAST_MAPS
	ld de, RandomOvercastMapsJohto
	call RandomRange
	ld h, 0
	ld l, a
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wOvercastRandomMapGroupJohto1], a
	ld a, [hli]
	ld [wOvercastRandomMapNumberJohto1], a
	call GenerateRandomIntensity
	ld [wOvercastRandomMapIntensityJohto1], a
	ld a, NUM_JOHTO_OVERCAST_MAPS
	ld de, RandomOvercastMapsJohto
	call RandomRange
	ld h, 0
	ld l, a
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wOvercastRandomMapGroupJohto2], a
	ld a, [hli]
	ld [wOvercastRandomMapNumberJohto2], a
	call GenerateRandomIntensity
	ld [wOvercastRandomMapIntensityJohto2], a
	ld a, NUM_KANTO_OVERCAST_MAPS
	ld de, RandomOvercastMapsKanto
	call RandomRange
	ld h, 0
	ld l, a
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wOvercastRandomMapGroupKanto1], a
	ld a, [hli]
	ld [wOvercastRandomMapNumberKanto1], a
	call GenerateRandomIntensity
	ld [wOvercastRandomMapIntensityKanto1], a
	ld a, NUM_KANTO_OVERCAST_MAPS
	ld de, RandomOvercastMapsKanto
	call RandomRange
	ld h, 0
	ld l, a
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wOvercastRandomMapGroupKanto2], a
	ld a, [hli]
	ld [wOvercastRandomMapNumberKanto2], a
	call GenerateRandomIntensity
	ld [wOvercastRandomMapIntensityKanto2], a
	ret

GenerateRandomIntensity:
	call Random
	cp 50 percent
	jr c, .low_intensity
	cp (50 + 40) percent
	jr c, .medium_intensity
	ld a, OVERCAST_INTENSITY_THUNDERSTORM
	ret
.medium_intensity
	ld a, OVERCAST_INTENSITY_RAIN
	ret
.low_intensity
	ld a, OVERCAST_INTENSITY_OVERCAST
	ret

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
	overcast_area AREA_ROUTE_32, ROUTE_32, MAGNET_TUNNEL_EAST
	overcast_area AREA_AZALEA, AZALEA_TOWN, ROUTE_33
	overcast_area AREA_ROUTE_34, ROUTE_34, ROUTE_34_COAST
	overcast_area AREA_GOLDENROD, GOLDENROD_CITY, MAGNET_TUNNEL_WEST
	overcast_area AREA_NATIONAL_PARK, NATIONAL_PARK, NATIONAL_PARK_BUG_CONTEST
	overcast_area AREA_ECRUTEAK, ECRUTEAK_CITY, ECRUTEAK_SHRINE_OUTSIDE, BELLCHIME_TRAIL
	overcast_area AREA_ROUTE_35_COAST, ROUTE_35_COAST_NORTH, ROUTE_35_COAST_SOUTH
	overcast_area AREA_ROUTES_47_48, ROUTE_47, ROUTE_48
	overcast_area AREA_ROUTE_42, ROUTE_42, VIOLET_OUTSKIRTS
	overcast_area AREA_LAKE_OF_RAGE, ROUTE_43, LAKE_OF_RAGE
	overcast_area AREA_ROUTE_2, ROUTE_2_NORTH, ROUTE_2_SOUTH
	overcast_area AREA_ROUTE_10, ROUTE_10_NORTH, ROUTE_10_SOUTH
	overcast_area AREA_ROUTE_12, ROUTE_12_NORTH, ROUTE_12_SOUTH
	overcast_area AREA_ROUTE_13, ROUTE_13_EAST, ROUTE_13_WEST
	overcast_area AREA_ROUTE_16, ROUTE_16_NORTHEAST, ROUTE_16_NORTHWEST, ROUTE_16_SOUTH, ROUTE_16_WEST
	overcast_area AREA_ROUTE_18, ROUTE_18_EAST, ROUTE_18_WEST
	overcast_area AREA_URAGA_CHANNEL, URAGA_CHANNEL_EAST, URAGA_CHANNEL_WEST

MACRO overcast_map
	const_skip
	if !DEF(GROUP_\1)
		db \1, 0
	else
		map_id \1
	endc
ENDM

RandomOvercastMapsJohto:
	const_def
	overcast_map BATTLE_TOWER_OUTSIDE
	overcast_map BLACKTHORN_CITY
	overcast_map CHERRYGROVE_BAY
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
	overcast_map ROUTE_40
	overcast_map ROUTE_41
	overcast_map ROUTE_44
	overcast_map ROUTE_45
	overcast_map ROUTE_46
	overcast_map RUINS_OF_ALPH_OUTSIDE
	overcast_map SILVER_CAVE_OUTSIDE
	overcast_map SINJOH_RUINS
	overcast_map SNOWTOP_MOUNTAIN_INSIDE
	overcast_map STORMY_BEACH
	overcast_map VIOLET_CITY
	overcast_map YELLOW_FOREST
	; aliases
	overcast_map AREA_ROUTE_32
	overcast_map AREA_AZALEA
	overcast_map AREA_ROUTE_34
	overcast_map AREA_GOLDENROD
	overcast_map AREA_NATIONAL_PARK
	overcast_map AREA_ECRUTEAK
	overcast_map AREA_ROUTE_35_COAST
	overcast_map AREA_ROUTES_47_48
	overcast_map AREA_ROUTE_42
	overcast_map AREA_LAKE_OF_RAGE
	DEF NUM_JOHTO_OVERCAST_MAPS EQU const_value

RandomOvercastMapsKanto:
	const_def
	overcast_map BEAUTIFUL_BEACH
	overcast_map CELADON_CITY
	overcast_map CERULEAN_CAPE
	overcast_map CERULEAN_CITY
	overcast_map CINNABAR_ISLAND
	overcast_map FARAWAY_ISLAND
	overcast_map FARAWAY_JUNGLE
	overcast_map FIRE_ISLAND_ROOF
	overcast_map FUCHSIA_CITY
	overcast_map ICE_ISLAND_ROOF
	overcast_map INDIGO_PLATEAU
	overcast_map LAVENDER_TOWN
	overcast_map LIGHTNING_ISLAND_ROOF
	overcast_map LUCKY_ISLAND
	overcast_map MOUNT_MOON_SQUARE
	overcast_map NAVEL_ROCK_OUTSIDE
	overcast_map PALLET_TOWN
	overcast_map PEWTER_CITY
	overcast_map ROCKY_BEACH
	overcast_map ROUTE_1
	overcast_map ROUTE_11
	overcast_map ROUTE_14
	overcast_map ROUTE_15
	overcast_map ROUTE_17
	overcast_map ROUTE_19
	overcast_map ROUTE_20
	overcast_map ROUTE_21
	overcast_map ROUTE_22
	overcast_map ROUTE_23
	overcast_map ROUTE_24
	overcast_map ROUTE_25
	overcast_map ROUTE_26
	overcast_map ROUTE_27
	overcast_map ROUTE_28
	overcast_map ROUTE_3
	overcast_map ROUTE_4
	overcast_map ROUTE_49
	overcast_map ROUTE_5
	overcast_map ROUTE_6
	overcast_map ROUTE_7
	overcast_map ROUTE_8
	overcast_map ROUTE_9
	overcast_map SAFARI_ZONE_EAST
	overcast_map SAFARI_ZONE_HUB
	overcast_map SAFARI_ZONE_NORTH
	overcast_map SAFARI_ZONE_WEST
	overcast_map SAFFRON_CITY
	overcast_map SHAMOUTI_COAST
	overcast_map SHAMOUTI_ISLAND
	overcast_map SHAMOUTI_SHRINE_RUINS
	overcast_map VALENCIA_ISLAND
	overcast_map VERMILION_CITY
	overcast_map VERMILION_PORT
	overcast_map VIRIDIAN_CITY
	overcast_map VIRIDIAN_FOREST
	overcast_map WARM_BEACH
	; aliases
	overcast_map AREA_ROUTE_2
	overcast_map AREA_ROUTE_10
	overcast_map AREA_ROUTE_12
	overcast_map AREA_ROUTE_13
	overcast_map AREA_ROUTE_16
	overcast_map AREA_ROUTE_18
	overcast_map AREA_URAGA_CHANNEL
	DEF NUM_KANTO_OVERCAST_MAPS EQU const_value
