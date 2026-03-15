SetCurrentWeather::
	farcall GetOvercastIndex
	and a
	jr z, .not_raining
	ld a, [wOvercastCurIntensity]
	assert OVERCAST_INTENSITY_OVERCAST == 0
	and a
	jr z, .not_raining
	ld b, a
	ld a, OW_WEATHER_RAIN
	assert OVERCAST_INTENSITY_RAIN == 1
	dec b
	jr z, .set_weather
	ld a, OW_WEATHER_THUNDERSTORM
.set_weather
	ld b, a
	ld a, [wWeatherFlags]
	bit OW_WEATHER_DO_FLY_F, a
	jr nz, .skip_cooldown
	; if there was weather running then no cooldown
	ld a, [wCurWeather]
	and a
	jr z, .skip_cooldown
	; No cooldown if switching from rain to thunderstorm or vice versa
	ld c, a
	cp OW_WEATHER_RAIN
	jr nz, .not_rain
	ld a, b
	cp OW_WEATHER_THUNDERSTORM
	jr z, .skip_cooldown
.not_rain
	ld a, c
	cp OW_WEATHER_THUNDERSTORM
	jr nz, .compare_cur_and_prev_weather
	ld a, b
	cp OW_WEATHER_RAIN
	jr z, .skip_cooldown
	ld a, c
.compare_cur_and_prev_weather
	; if weather is different from previous weather then do cooldown
	cp b
	jr nz, .do_cooldown
.skip_cooldown
	ld a, b
	ld [wCurWeather], a
	farcall LoadWeatherPal
	call LoadWeatherGraphics
	xor a
	ld [wOverworldWeatherCooldown], a
	ret

.do_cooldown
	ld [wPrevWeather], a
	ld a, b
	ld [wCurWeather], a
	ld a, 32
	ld [wOverworldWeatherCooldown], a
	ret

.not_raining
	ld a, [wMapGroup]
	cp GROUP_SNOWTOP_MOUNTAIN_OUTSIDE
	jr z, .snowtop_mountain
	cp GROUP_SILVER_CAVE_ROOM_3
	jr nz, .not_snowing
	ld a, [wMapNumber]
	cp MAP_SILVER_CAVE_ROOM_3
	jr nz, .not_snowing
	jr .snowing
.snowtop_mountain
	ld a, [wMapNumber]
	cp MAP_SNOWTOP_MOUNTAIN_OUTSIDE
	jr z, .snowing
	cp MAP_SNOWTOP_MOUNTAIN_INSIDE
	jr nz, .not_snowing
.snowing
	ld a, OW_WEATHER_SNOW
	jr .set_weather

.not_snowing
	ld a, [wMapGroup]
	cp GROUP_RUGGED_ROAD_NORTH
	jr nz, .no_sandstorm
	ld a, [wMapNumber]
	cp MAP_RUGGED_ROAD_NORTH
	jr z, .sandstorm
	cp MAP_RUGGED_ROAD_SOUTH
	jr nz, .no_sandstorm
.sandstorm
	ld a, OW_WEATHER_SANDSTORM
	jr .set_weather

.no_sandstorm
	ld a, [wMapGroup]
	cp GROUP_CHERRYGROVE_CITY
	jr nz, .maybe_harsh_sun
	ld a, [wMapNumber]
	cp MAP_CHERRYGROVE_CITY
	jr z, .cherrygrove_city
	cp MAP_CHERRYGROVE_BAY
	jr z, .cherrygrove_bay
	jr .maybe_harsh_sun

.cherrygrove_city
	; Guaranteed in Cherrygrove City until the Mystery Egg has been delivered to Elm.
	eventflagcheck EVENT_GAVE_MYSTERY_EGG_TO_ELM
	jr nz, .cherrygrove_random
	ld a, OW_WEATHER_CHERRY_BLOSSOMS
	jmp .set_weather

.cherrygrove_bay
	; After the initial arrival, cherry blossoms are only a 10% chance,
	; and only when no other map weather is active (handled by control flow).
.cherrygrove_random
	call Random
	cp 10 percent
	jr nc, .maybe_harsh_sun
	ld a, OW_WEATHER_CHERRY_BLOSSOMS
	jmp .set_weather

.maybe_harsh_sun
	call TryGetHarshSunWeather
	and a
	jp nz, .set_weather

.no_weather
	assert OW_WEATHER_NONE == 0
	xor a
	jmp .set_weather

TryGetHarshSunWeather:
	; Harsh sun only starts after Azalea's Slowpoke Well plot is resolved.
	eventflagcheck EVENT_CLEARED_SLOWPOKE_WELL
	jr z, .no_weather

	; Day only; morning/evening/night never qualify.
	farcall CheckTime
	ld a, c
	and 1 << DAY
	jr z, .no_weather

	; Skip indoor/cave/gate/dungeon environments.
	ld a, [wEnvironment]
	cp TOWN
	jr z, .can_harsh_sun
	cp ROUTE
	jr z, .can_harsh_sun
	cp ISOLATED
	jr nz, .no_weather

.can_harsh_sun
	ld a, [wCurDay]
	ld b, a
	ld a, [wHarshSunRandomDay]
	cp b
	jr nz, .reroll_maps
	ld a, [wHarshSunRandomMapJohtoGroup]
	and a
	jr z, .reroll_maps
	ld a, [wHarshSunRandomMapKantoGroup]
	and a
	jr z, .reroll_maps
	jr .got_maps

.reroll_maps
	ld a, b
	ld [wHarshSunRandomDay], a
	call GenerateNewRandomHarshSunMaps

.got_maps
	call CheckHarshSunMap
	jr nc, .no_weather

	ld a, OW_WEATHER_HARSH_SUN
	ret

.no_weather
	xor a
	ret

CheckHarshSunMap:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a

	ld a, [wHarshSunRandomMapJohtoGroup]
	ld hl, wHarshSunRandomMapJohtoNumber
	call .CheckOne
	ret c

	ld a, [wHarshSunRandomMapKantoGroup]
	ld hl, wHarshSunRandomMapKantoNumber
	; fallthrough

.CheckOne
	cp NUM_MAP_GROUPS + 1
	jr nc, .aliased_group
	cp b
	jr nz, .not_match
	ld a, [hl]
	cp c
	jr z, .found

.not_match
	and a
	ret

.aliased_group
	push hl
	call GetHarshSunAliasedGroup
.alias_loop
	ld a, [hli]
	cp -1
	jr z, .not_in_alias_group
	cp b
	jr nz, .check_next_alias_map
	ld a, [hli]
	cp c
	jr z, .found_in_alias
	jr .alias_loop

.check_next_alias_map
	inc hl
	jr .alias_loop

.found_in_alias
	pop hl
.found
	scf
	ret

.not_in_alias_group
	pop hl
	and a
	ret

GenerateNewRandomHarshSunMaps:
	ld bc, wHarshSunRandomMapJohtoGroup
	ld a, NUM_JOHTO_HARSH_SUN_MAPS
	ld de, HarshSunMapsJohto
	call .GenerateNextHarshSunMap

	ld bc, wHarshSunRandomMapKantoGroup
	ld a, NUM_KANTO_HARSH_SUN_MAPS
	ld de, HarshSunMapsKanto
	; fallthrough

.GenerateNextHarshSunMap:
	push bc
	call RandomRange
	ld h, 0
	ld l, a
	add hl, hl
	add hl, de
	pop bc
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hli]
	ld [bc], a
	ret

GetHarshSunAliasedGroup:
	push bc
	sub NUM_MAP_GROUPS + 1
	ld b, a
	ld hl, HarshSunAliasedMapGroups
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

INCLUDE "data/maps/harsh_sun_maps.asm"
