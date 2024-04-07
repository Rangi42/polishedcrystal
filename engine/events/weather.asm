MACRO ow_weather_map
	map_id \1
	dw \2 ; event
	shift
	rept NUM_OW_WEATHERS
		shift
		db (\1) percent
	endr
ENDM

OverworldWeatherMaps:
	; map, event, rain %, thunderstorm %, snow %, sandstorm %
	; first matching map & event will be used
	ow_weather_map STORMY_BEACH,                                       -1, 100,   0,   0,   0
	ow_weather_map RUGGED_ROAD_NORTH,                                  -1,   0,   0,   0, 100
	ow_weather_map RUGGED_ROAD_SOUTH,                                  -1,   0,   0,   0, 100
	ow_weather_map SNOWTOP_MOUNTAIN_INSIDE,                            -1,   0,   0, 100,   0
	ow_weather_map SNOWTOP_MOUNTAIN_OUTSIDE,                           -1,   0,   0, 100,   0
	ow_weather_map LAKE_OF_RAGE,             EVENT_LAKE_OF_RAGE_CIVILIANS, 100, 100,   0,   0
	ow_weather_map LAKE_OF_RAGE,                                       -1,  20,   0,   0,   0
	db -1 ; end


SetCurrentWeather::
	ld bc, OverworldWeatherMaps
	ld hl, OverworldWeatherMaps
.loop
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapNumber]
	ld e, a
	ld a, [hli]
	cp -1
	jr z, .no_weather
	cp d
	jr nz, .skip_row
	ld a, [hli]
	cp e
	jr nz, .skip_row
	ld a, [hli]
	cp -1
	jr z, .ignore_flag
	ld e, a
	ld a, [hl]
	ld d, a
	push hl
	push de
	push bc
	ld b, CHECK_FLAG
	call EventFlagAction
	pop bc
	pop de
	pop hl
	jr z, .skip_row
.ignore_flag
	inc hl
	call Random
	ld b, a
	ld a, [hli] ; rain %
	cp b
	ld a, OW_WEATHER_RAIN
	jr nc, .set_weather
	call Random
	ld b, a
	ld a, [hli] ; thunderstorm %
	cp b
	ld a, OW_WEATHER_THUNDERSTORM
	jr nc, .set_weather
	call Random
	ld b, a
	ld a, [hli] ; snow %
	cp b
	ld a, OW_WEATHER_SNOW
	jr nc, .set_weather
	call Random
	ld b, a
	ld a, [hl] ; sandstorm %
	cp b
	ld a, OW_WEATHER_SANDSTORM
	jr nc, .set_weather
.no_weather
	ld a, OW_WEATHER_NONE
.set_weather
	ld b, a
	ld a, [wCurrentWeather]
	cp OW_WEATHER_NONE
	jr nz, .do_cooldown
	ld a, b
	ld [wCurrentWeather], a
	farcall LoadWeatherGraphics
	xor a
	ld [wOverworldWeatherCooldown], a
	ret

.do_cooldown
	ld [wPrevWeather], a
	ld a, b
	ld [wCurrentWeather], a
	ld a, 32
	ld [wOverworldWeatherCooldown], a
	ret


.skip_row
	ld hl, 8
	add hl, bc
	ld b, h
	ld c, l
	jr .loop
