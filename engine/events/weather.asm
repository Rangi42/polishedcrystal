MACRO ow_weather_map
	map_id \1
	dw \2 ; event
	shift
	rept NUM_OW_WEATHERS
		shift
		db (\1) percent
	endr
ENDM

SetCurrentWeather::
	farcall GetOvercastIndex
	and a
	jr z, .not_overcast
	call Random
	cp 25 percent
	; a = carry ? OW_WEATHER_THUNDERSTORM : OW_WEATHER_RAIN
	sbc a
	and OW_WEATHER_THUNDERSTORM - OW_WEATHER_RAIN
	add OW_WEATHER_RAIN
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

.not_overcast
	ld a, [wMapGroup]
	cp GROUP_SNOWTOP_MOUNTAIN_OUTSIDE
	jr nz, .not_snowing
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
	jr nz, .no_weather
	ld a, [wMapNumber]
	cp MAP_RUGGED_ROAD_NORTH
	jr z, .sandstorm
	cp MAP_RUGGED_ROAD_SOUTH
	jr nz, .no_weather
.sandstorm
	ld a, OW_WEATHER_SANDSTORM
	jr .set_weather

.no_weather
	ld a, OW_WEATHER_NONE
	jr .set_weather


;OverworldWeatherMaps:
	; map, event, rain %, thunderstorm %, snow %, sandstorm %
	; first matching map & event will be used
;	ow_weather_map STORMY_BEACH,                                       -1, 100,   0,   0,   0
;	ow_weather_map RUGGED_ROAD_NORTH,                                  -1,   0,   0,   0, 100
;	ow_weather_map RUGGED_ROAD_SOUTH,                                  -1,   0,   0,   0, 100
;	ow_weather_map SNOWTOP_MOUNTAIN_INSIDE,                            -1,   0,   0, 100,   0
;	ow_weather_map SNOWTOP_MOUNTAIN_OUTSIDE,                           -1,   0,   0, 100,   0
;	ow_weather_map LAKE_OF_RAGE,             EVENT_LAKE_OF_RAGE_CIVILIANS, 100, 100,   0,   0
;	ow_weather_map LAKE_OF_RAGE,                                       -1,  20,   0,   0,   0
;	db -1 ; end


;SetCurrentWeather::
;	ld bc, OverworldWeatherMaps
;	ld hl, OverworldWeatherMaps
;.loop
;	ld a, [wMapGroup]
;	ld d, a
;	ld a, [wMapNumber]
;	ld e, a
;	ld a, [hli]
;	cp -1
;	jr z, .no_weather
;	cp d
;	jr nz, .skip_row
;	ld a, [hli]
;	cp e
;	jr nz, .skip_row
;	ld a, [hli]
;	cp -1
;	jr z, .ignore_flag
;	ld e, a
;	ld a, [hl]
;	ld d, a
;	push hl
;	push de
;	push bc
;	ld b, CHECK_FLAG
;	call EventFlagAction
;	pop bc
;	pop de
;	pop hl
;	jr z, .skip_row
;.ignore_flag
;	inc hl
;	call Random
;	ld b, a
;	ld a, [hli] ; rain %
;	cp b
;	ld a, OW_WEATHER_RAIN
;	jr nc, .set_weather
;	call Random
;	ld b, a
;	ld a, [hli] ; thunderstorm %
;	cp b
;	ld a, OW_WEATHER_THUNDERSTORM
;	jr nc, .set_weather
;	call Random
;	ld b, a
;	ld a, [hli] ; snow %
;	cp b
;	ld a, OW_WEATHER_SNOW
;	jr nc, .set_weather
;	call Random
;	ld b, a
;	ld a, [hl] ; sandstorm %
;	cp b
;	ld a, OW_WEATHER_SANDSTORM
;	jr nc, .set_weather
;.no_weather
;	ld a, OW_WEATHER_NONE
;.set_weather
;	ld b, a
;	ld a, [wCurWeather]
;	cp OW_WEATHER_NONE
;	jr nz, .do_cooldown
;	ld a, b
;	ld [wCurWeather], a
;	farcall LoadWeatherGraphics
;	xor a
;	ld [wOverworldWeatherCooldown], a
;	ret
;
;.do_cooldown
;	ld [wPrevWeather], a
;	ld a, b
;	ld [wCurWeather], a
;	ld a, 32
;	ld [wOverworldWeatherCooldown], a
;	ret
;
;
;.skip_row
;	ld hl, 8
;	add hl, bc
;	ld b, h
;	ld c, l
;	jr .loop
