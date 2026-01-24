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
	jr nz, .no_weather
	ld a, [wMapNumber]
	cp MAP_CHERRYGROVE_CITY
	jr z, .cherrygrove_city
	cp MAP_CHERRYGROVE_BAY
	jr z, .cherrygrove_bay
	jr .no_weather

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
	jr nc, .no_weather
	ld a, OW_WEATHER_CHERRY_BLOSSOMS
	jmp .set_weather
; fallthrough
.no_weather
	assert OW_WEATHER_NONE == 0
	xor a
	jmp .set_weather
