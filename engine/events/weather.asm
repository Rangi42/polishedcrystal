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
	ld d, a
	ld a, [hl]
	ld e, a
	ld b, CHECK_FLAG
	push hl
	push de
	call EventFlagAction
	pop de
	pop hl
	jr nz, .skip_row
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
	ld [wCurrentWeather], a
	farcall LoadWeatherGraphics
	xor a
	ld [wOverworldWeatherCooldown], a
	ret

.skip_row
	ld hl, 8
	add hl, bc
	ld b, h
	ld c, l
	jr .loop





;SetCurrentWeather::
; This could be populated with a more robust weather system, but for now it's just random
;	ld a, [wCurrentWeather]
;	ld b, a
;	call GetMapEnvironment
;	call CheckOutdoorMap
;	ld a, OW_WEATHER_NONE
;	jr nz, .got_weather ; no weather indoors.
;	ld a, NUM_WEATHERS
;	call RandomRange
;.got_weather
;	ld [wCurrentWeather], a
;	dec a ; OW_WEATHER_RAIN
;	ld a, WEATHER_RAIN
;	ld [wBattleWeather], a
;	jr z, .done_battle_weather
;	; OW_WEATHER_HAIL
;	ld a, WEATHER_HAIL
;	ld [wBattleWeather], a
;	farcall LoadWeatherGraphics
;.done_battle_weather
;	ld a, 255
;	ld [wWeatherCount], a
;	xor a
;	ld [wOverworldWeatherCooldown], a
;	ld a, [wCurrentWeather]
;	cp b
;	ret z
;	ld a, 90
;	ld [wOverworldWeatherCooldown], a
;	ret
