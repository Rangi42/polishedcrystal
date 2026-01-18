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
	jr z, .not_in_alias_group
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

.not_in_alias_group
	pop hl
	inc hl ; skip map id
	dec d
	jr nz, .loop_overcast_maps
; fallthrough
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

INCLUDE "data/maps/overcast_maps.asm"
