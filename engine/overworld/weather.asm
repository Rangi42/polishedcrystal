DEF WEATHER_TILE_1  EQU $6d
DEF WEATHER_TILE_2  EQU $6e
DEF RAINDROP_TILE   EQU WEATHER_TILE_1
DEF RAINSPLASH_TILE EQU WEATHER_TILE_2
DEF SNOWFLAKE_TILE  EQU WEATHER_TILE_1
DEF SANDSTORM_TILE  EQU WEATHER_TILE_1
DEF PAL_OW_WEATHER  EQU 6

DoOverworldWeather:
	push hl
	push de
	push bc

	; if weather is disabled, we are done
	ld hl, wWeatherFlags
	bit OW_WEATHER_DISABLED_F, [hl]
	jr nz, .done

	; rolling counter from 0 to 255 used to run weather
	; in 30fps or every odd frame.
	ld a, [wOverworldWeatherTimer]
	and %1
	jr z, .done

	; we are running weather, so decrement the cooldown if needed.
	ld a, [wOverworldWeatherCooldown]
	and a
	jr z, .no_cooldown
	dec a
	ld [wOverworldWeatherCooldown], a
.no_cooldown

	; if hUsedWeatherSpriteIndex >= the first object OAM index,
	; then we need to set hUsedWeatherSpriteIndex the OAM index before the first object OAM index.
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a
	cpl
	add OAM_SIZE + 1
	ld hl, hUsedWeatherSpriteIndex
	cp [hl]
	jr nc, .ok
	add -OBJ_SIZE
	ldh [hUsedWeatherSpriteIndex], a
.ok
	; if cooldown is not 0, we don't want to spawn new weather sprites
	; instead we want to slowly finishing dropping the current sprites.
	ld a, [wOverworldWeatherCooldown]
	and a
	jr nz, .on_cooldown

	ld a, [wCurWeather]
	ld hl, .DoWeather_Jumptable
	call JumpTable
.done
	; we are done, increment the weather delay rolling counter (0->255->0)
	ld hl, wOverworldWeatherTimer
	inc [hl]
	; always check if we have exceeded the sprite limit
	call WeatherSpriteLimitCheck
	jmp PopBCDEHL

.DoWeather_Jumptable:
	table_width 2
	dw DoNothing
	dw DoOverworldRain
	dw DoOverworldSnow
	dw DoOverworldRain
	dw DoOverworldSandstorm
	assert_table_length NUM_OW_WEATHERS + 1

.on_cooldown
	ld a, [wPrevWeather]
	call StackJumpTable

.Cooldown_Jumptable:
	table_width 2
	dw .cooldown_cleanup
	dw .rain_cooldown
	dw .snow_cooldown
	dw .rain_cooldown
	dw .sand_cooldown
	assert_table_length NUM_OW_WEATHERS + 1

.sand_cooldown
	call DoSandFall
	jr .cooldown_cleanup
.snow_cooldown
	call DoSnowFall
	jr .cooldown_cleanup
.rain_cooldown
	call DoRainFall
	call RainSplashCleanup
.cooldown_cleanup
	; decrement the weather cooldown until it is 0
	ld a, [wOverworldWeatherCooldown]
	dec a
	jr nz, .done
	call ClearWeather
	call LoadWeatherGraphics
	jr .done

SpawnRandomWeatherFullScreen::
	lb bc, SCREEN_WIDTH_PX, SCREEN_HEIGHT_PX
; fallthrough
SpawnRandomWeatherCoords::
; This is used to randomize the weather's starting positions on the screen from
; randomize weather sprite x/y coords from (0,0) to (b,c)
	ld a, [wCurWeather]
	assert OW_WEATHER_NONE == 0
	and a
	ret z
	ld a, [wCurWeather]
	assert OW_WEATHER_RAIN == 1
	dec a
	jr z, .rain
	assert OW_WEATHER_SNOW == 2
	dec a
	jr z, .snow
	assert OW_WEATHER_THUNDERSTORM == 3
	dec a
	jr z, .rain
	assert OW_WEATHER_SANDSTORM == 4
.sand
	call .find_oam_and_radomize
	ret c
	ld a, SANDSTORM_TILE
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	jr nc, .sand
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	jr .sand

.snow
	call .find_oam_and_radomize
	ret c
	ld a, SNOWFLAKE_TILE
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	jr nc, .snow
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	jr .snow

.rain
	call .find_oam_and_radomize
	ret c
	call Random
	cp 20 percent ; 20 percent splashes
	; a = carry ? RAINSPLASH_TILE : RAINDROP_TILE
	assert RAINDROP_TILE + 1 == RAINSPLASH_TILE
	ccf
	sbc a
	add RAINSPLASH_TILE
.got_tile
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	jr nc, .rain
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	jr .rain

.find_oam_and_radomize
	push bc
	call ScanForEmptyOAM
	pop bc
	ret c
	; sprite coord is (RandomRange(0, b), RandomRange(0, c))
	ld a, c
	call RandomRange
	ld [hli], a
	ld a, b
	call RandomRange
	ld [hli], a
	or 1
	ret

DoOverworldSnow:
	ld a, [wLoadedObjPal6]
	inc a
	jr z, .continue
	farcall LoadWeatherPal
.continue
rept 2
	; spawn two snowflakes
	call ScanForEmptyOAM
	call nc, SpawnSnowFlake
endr
; fallthrough
DoSnowFall:
	ld de, wShadowOAM
	ld h, d
	ld l, e
	ld b, OAM_COUNT
.loop ; for (wShadowOAM -> wShadowOAMEnd)
	; if the sprite is hidden, skip it
	ld hl, OAMA_Y
	ld a, [hl]
	cp OAM_YCOORD_HIDDEN
	jr z, .next

	; if the sprite is not a snowflake, skip it
	ld hl, OAMA_TILEID
	add hl, de
	ld a, [hli]
	cp SNOWFLAKE_TILE
	jr nz, .next

	; if the sprite doesn't use the weather palette, skip it
	ld a, [hl]
	cp PAL_OW_WEATHER
	jr nz, .next

	; the snowflake has a 0.1% chance of despawning
	call Random
	cp 1 percent
	jr nc, .ok
	call Random
	cp 10 percent
	jr c, .despawn
.ok

	xor a
	ld hl, wWeatherFlags
	bit OW_WEATHER_IGNORE_PLAYER_Y, [hl]
	jr nz, .skip_y_adjust
	; double the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorY]
	add a
.skip_y_adjust
	ld c, a

	; get the sprite's y coord and subtract the player's doubled step vector
	ld hl, OAMA_Y
	add hl, de
	ld a, [hl]
	sub c
	ld c, a

	; sprites with an even index move down 1 faster.
	call IsEvenSpriteIndex
	add c

	; minimum fall speed is 2
	add 2

	; if the sprite goes offscreen, despawn it, otherwise update its y coord
	ld hl, OAMA_Y
	add hl, de
	cp OAM_YCOORD_HIDDEN
	ld [hl], a
	jr nc, .despawn

	; double the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorX]
	add a
	ld c, a

	; sprite has a 50% chance to wiggle left 1.
	call Random
	and 1
	ld a, c
	jr nz, .no_add_1
	inc a
.no_add_1
	ld c, a

	; get the sprite's x coord and subtract the player's doubled step vector + wiggle
	ld hl, OAMA_X
	add hl, de
	ld a, [hl]
	sub c

	; sprite can have 0 change in x coord (no wiggle or step vector)
	; so we increment a before subtracting to check for despawn (offscreen)
	inc a
	ld hl, OAMA_X
	add hl, de
	sub 1 ; no-optimize a++|a-- (need to set carry)
	ld [hl], a
	jr c, .despawn
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, OAMA_Y
	add hl, de
	ld a, OAM_YCOORD_HIDDEN
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .next

DoOverworldRain:
	ld a, [wLoadedObjPal6]
	cp PAL_OW_RAIN
	jr z, .continue
	farcall LoadWeatherPal
.continue
	ld a, [wCurWeather]
	cp OW_WEATHER_THUNDERSTORM
	jr nz, .no_lightning

	; 0.5% chance of lightning
	call Random
	cp 1 percent
	jr nc, .no_lightning
	call Random
	cp 50 percent
	call c, Lightning
.no_lightning
rept 3
	; spawn three raindrops
	call ScanForEmptyOAM
	call nc, SpawnRainDrop
endr
	call DoRainFall
; fallthrough
RainSplashCleanup:
	; we leave rain splashs on screen for approx 3.75fps.
	; we have to ignore the LSB as we only run weather every odd frame.
	ld a, [wOverworldWeatherTimer]
	and %1110
	ret nz

	ld de, wShadowOAM
	ld b, OAM_COUNT
.loop ; for (wShadowOAM -> wShadowOAMEnd)
	; if sprite tile is not a rain splash, skip it
	ld hl, OAMA_TILEID
	add hl, de
	ld a, [hli]
	cp RAINSPLASH_TILE
	jr nz, .next

	; hide the rain splash
	ld hl, OAMA_Y
	add hl, de
	ld [hl], OAM_YCOORD_HIDDEN ; offscreen
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

SpawnSnowFlake:
	; 40% chance of spawning a snowflake.
	call Random
	cp 40 percent
	ret nc
	; 25% chance of spawning a snowflake on the right side of the screen.
	call Random
	and %11
	jr z, .spawn_on_right

	; sprite coord is (0, RandomRange(0, SCREEN_WIDTH_PX + 7) + TILE_WIDTH)
	xor a
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	; x-coord less than TILE_WIDTH is offscreen, so add TILE_WIDTH
	add TILE_WIDTH
	ld [hli], a
.finish
	ld a, SNOWFLAKE_TILE
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	ret nc
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	ret

.spawn_on_right
	; sprite coord is (SCREEN_WIDTH_PX + TILE_WIDTH, RandomRange(0, OAM_YCOORD_HIDDEN))
	ld a, OAM_YCOORD_HIDDEN
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + TILE_WIDTH
	ld [hli], a
	jr .finish

ScanForEmptyOAM:
; return empty OAM slot in de or carry set if none
	ld de, wShadowOAM
	ld h, d
	ld l, e
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a
	cpl
	add OAM_SIZE + 1
	; a = a / 4
	rrca
	rrca
	ld b, a
.loop ; Scan (wShadowOAM --> index of first object OAM slot)
	; if the sprite is hidden, return the slot
	ld a, [hl]
	cp OAM_YCOORD_HIDDEN
	ret z
	; next slot
	ld hl, OBJ_SIZE
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	; no empty slots
	scf
	ret

SpawnRainDrop:
	; 50% chance of spawning a raindop on the right
	call Random
	and 1
	jr z, .spawn_on_right

	; sprite coord is (0, RandomRange(0, SCREEN_WIDTH_PX + 7) + TILE_WIDTH)
	xor a
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	; x-coord less than TILE_WIDTH is offscreen, so add TILE_WIDTH
	add TILE_WIDTH
	ld [hli], a
.finish
	ld a, RAINDROP_TILE
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	ret nc
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	ret

.spawn_on_right
	; sprite coord is (SCREEN_WIDTH_PX + TILE_WIDTH, RandomRange(0, OAM_YCOORD_HIDDEN))
	ld a, OAM_YCOORD_HIDDEN
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + TILE_WIDTH
	ld [hli], a
	jr .finish

ClearWeather:
	; doing this will cause _UpdateSprites to hide all weather sprites.
	xor a
	ldh [hUsedWeatherSpriteIndex], a
	ret

DoRainFall:
	ld de, wShadowOAM
	ld h, d
	ld l, e
	ld b, OAM_COUNT
.loop ; for (wShadowOAM -> wShadowOAMEnd)
	; if the sprite is hidden, skip it
	ld hl, OAMA_Y
	ld a, [hl]
	cp OAM_YCOORD_HIDDEN
	jr z, .next

	; if the sprite is a splash, update splash.
	ld hl, OAMA_TILEID
	add hl, de
	ld a, [hli]
	cp RAINSPLASH_TILE
	jr z, .update_splash

	; if the sprite is not a raindrop, skip it
	cp RAINDROP_TILE
	jr nz, .next

	; if the sprite doesn't use the weather palette, skip it
	ld a, [hl]
	cp PAL_OW_WEATHER
	jr nz, .next

	; raindrops have a 5% chance of splashing.
	call Random
	cp 5 percent
	jmp c, .splash

	xor a
	ld hl, wWeatherFlags
	bit OW_WEATHER_IGNORE_PLAYER_Y, [hl]
	jr nz, .skip_y_adjust_1
	; quadruple the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorY]
	add a
	add a
.skip_y_adjust_1

	; get the sprite's y coord and subtract the player's quadrupled step vector
	ld c, a
	ld hl, OAMA_Y
	add hl, de
	ld a, [hl]
	sub c
	ld c, a

	; sprites with an even index move down 2 faster.
	call IsEvenSpriteIndex
	add a
	add c

	; minimum fall speed is 8
	add 8

	; if the sprite goes offscreen, despawn it, otherwise update its y coord
	ld hl, OAMA_Y
	add hl, de
	cp OAM_YCOORD_HIDDEN
	ld [hl], a
	jr nc, .despawn

	; quadruple the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a

	; get the sprite's x coord and subtract the player's quadrupled step vector
	ld hl, OAMA_X
	add hl, de
	ld a, [hl]
	sub c
	ld c, a

	; sprites with an even index move left 2 faster.
	call IsEvenSpriteIndex
	cpl
	inc a
	add a
	add c

	; minimum horizontal movement left is 4.
	sub 4

	; if the sprite goes offscreen, despawn it, otherwise update its x coord
	ld hl, OAMA_X
	add hl, de
	ld [hl], a
	jr c, .despawn
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, OAMA_Y
	add hl, de
	ld a, OAM_YCOORD_HIDDEN
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .next

.update_splash
	; if the sprite doesn't use the weather palette, skip it
	ld a, [hl]
	cp PAL_OW_WEATHER
	jr nz, .next

	xor a
	ld hl, wWeatherFlags
	bit OW_WEATHER_IGNORE_PLAYER_Y, [hl]
	jr nz, .skip_y_adjust_2
	; double the player's step vector
	ld a, [wPlayerStepVectorY]
	add a
.skip_y_adjust_2
	ld c, a

	; get the sprite's y coord and subtract the player's doubled step vector
	ld hl, OAMA_Y
	add hl, de
	ld a, [hl]
	sub c

	; if the sprite goes offscreen, despawn it, otherwise update its y coord
	cp OAM_YCOORD_HIDDEN
	jr nc, .despawn
	ld [hli], a

	; double the player's step vector
	ld a, [wPlayerStepVectorX]
	add a
	ld c, a

	; get the sprite's x coord and subtract the player's doubled step vector
	ld a, [hl]
	sub c
	ld [hl], a
	jr .next

.splash
	; convert raindrop to splash
	ld hl, OAMA_TILEID
	add hl, de
	ld [hl], RAINSPLASH_TILE
	jr .next

DoOverworldSandstorm:
	ld a, [wLoadedObjPal6]
	cp PAL_OW_SAND
	jr z, .continue
	farcall LoadWeatherPal
.continue
rept 3
	; spawn three sand drops
	call ScanForEmptyOAM
	call nc, SpawnSandDrop
endr
; fallthrough
DoSandFall:
	ld de, wShadowOAM
	ld h, d
	ld l, e
	ld b, OAM_COUNT
.loop ; for (wShadowOAM -> wShadowOAMEnd)
	; if the sprite is hidden, skip it
	ld hl, OAMA_Y
	ld a, [hl]
	cp OAM_YCOORD_HIDDEN
	jr z, .next

	; if the sprite is not a sand drop, skip it
	ld hl, OAMA_TILEID
	add hl, de
	ld a, [hli]
	cp SANDSTORM_TILE
	jr nz, .next

	; if the sprite doesn't use the weather palette, skip it
	ld a, [hl]
	cp PAL_OW_WEATHER
	jr nz, .next

	; sand drops have a 5% chance of despawning.
	call Random
	cp 5 percent
	jr c, .despawn

	xor a
	ld hl, wWeatherFlags
	bit OW_WEATHER_IGNORE_PLAYER_Y, [hl]
	jr nz, .skip_y_adjust
	; quadruple the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorY]
	add a
	add a
.skip_y_adjust
	ld c, a

	; get the sprite's y coord and subtract the player's quadrupled step vector
	ld hl, OAMA_Y
	add hl, de
	ld a, [hl]
	sub c
	ld c, a

	; sprites with an even index move up 2 slower.
	call IsEvenSpriteIndex
	add a
	add c

	; minimum rise speed is 4
	sub 4

	; if the sprite goes offscreen, despawn it, otherwise update its y coord
	ld hl, OAMA_Y
	add hl, de
	cp OAM_YCOORD_HIDDEN
	ld [hl], a
	jr nc, .despawn

	; quadruple the player's step vector (may be positive or negative)
	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a

	; get the sprite's x coord and subtract the player's quadrupled step vector
	ld hl, OAMA_X
	add hl, de
	ld a, [hl]
	sub c
	ld c, a

	; sprites with an even index move left 2 faster.
	call IsEvenSpriteIndex
	cpl
	inc a
	add a
	add c

	; minimum horizontal movement left is 12
	sub 12

	; if the sprite goes offscreen, despawn it, otherwise update its x coord
	ld hl, OAMA_X
	add hl, de
	ld [hl], a
	jr c, .despawn
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, OAMA_Y
	add hl, de
	ld a, OAM_YCOORD_HIDDEN
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .next

SpawnSandDrop:
	; 50% chance of spawning a sand drop on the right
	call Random
	and 1
	jr z, .spawn_on_right

	; sprite coord is (RandomRange(0, SCREEN_WIDTH_PX + 7) + TILE_WIDTH, SCREEN_HEIGHT_PX + TILE_WIDTH)
	ld a, SCREEN_HEIGHT_PX + TILE_WIDTH
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	add TILE_WIDTH
	ld [hli], a
.finish
	ld a, SANDSTORM_TILE
	ld [hli], a
	ld a, PAL_OW_WEATHER
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	ret nc
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	ret

.spawn_on_right
	; sprite coord is (SCREEN_WIDTH_PX + TILE_WIDTH, RandomRange(0, OAM_YCOORD_HIDDEN))
	ld a, OAM_YCOORD_HIDDEN
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + TILE_WIDTH
	ld [hli], a
	jr .finish

IsEvenSpriteIndex:
; input: e = sprite index
; output: a = is_even(e / 4)
	ld a, e
	rra
	rra ; / 4
	and 1
	ret

WeatherSpriteLimitCheck:
	ldh a, [rWBK]
	push af
	ld a, BANK(wWeatherScratch)
	ldh [rWBK], a
	xor a

	; clear wWeatherScratch
	ld hl, wWeatherScratch
	ld bc, SCREEN_HEIGHT_PX
	rst ByteFill

	ld hl, wShadowOAM
	ld d, h
	ld e, l
	ld b, OAM_COUNT
.loop ; for (wShadowOAM -> wShadowOAMEnd)
	ld a, [hl]
	; convert OAM y cord to screen y cord
	sub TILE_WIDTH * 2
	jr c, .next ; OAM is above the screen
	cp SCREEN_HEIGHT_PX + 1
	jr nc, .next ; OAM is below the screen
	; incerement bytes in wWeatherScratch associated with this sprite
	ld h, HIGH(wWeatherScratch)
	ld l, a
rept TILE_WIDTH - 1
	inc [hl]
	inc l
endr
	inc [hl]
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld e, l
	dec b
	jr nz, .loop

	; scan wWeatherScratch for scanlines with more than 10 sprites
	ld hl, wWeatherScratch
	ld a, 10 ; horizontal sprite limit
rept SCREEN_HEIGHT_PX - 1
	cp [hl]
	call c, SpriteLimitExceeded
	inc hl
endr
	cp [hl]
	call c, SpriteLimitExceeded

	pop af
	ldh [rWBK], a
	ret

SpriteLimitExceeded:
	push hl
	push af
	; initliaze wSpriteOverlapCount to 0.
	xor a
	ld [wSpriteOverlapCount], a
	ld a, l
	; convert screen y cord to OAM y cord
	add TILE_WIDTH * 2
	ld c, a
	ld hl, wShadowOAM + (OAM_COUNT - 1) * OBJ_SIZE
	ld e, l ; d is still set to HIGH(wShadowOAM)
rept OAM_COUNT
	; check if OAM y cord is <= (scanline + 16)
	ld a, [hl]
	sub c ; get distance between OAM y cord and (scanline + 16)
	jr z, .continue_\@ ; Sprite starts on the scanline; continue
	jr nc, .next_\@ ; OAM's y cord is below the scanline; skip sprite
.continue_\@
	; use two's complement to make a positive number
	cpl
	inc a
	; check if distance <= TILE_WIDTH
	cp TILE_WIDTH
	jr nc, .next_\@ ; distance is greater than TILE_WIDTH; skip sprite
	ld a, [wSpriteOverlapCount]
	inc a
	cp 11 ; horizontal sprite limit + 1
	ld [wSpriteOverlapCount], a
	call nc, .delete_sprite ; for all sprites after the 10th, delete them
.next_\@
	ld hl, -OBJ_SIZE
	add hl, de
	ld e, l
endr
	pop af
	pop hl
	ret

.delete_sprite
	; hl = sprite to delete
	ld a, [hl]
	ld [hl], OAM_YCOORD_HIDDEN
	; convert OAM y cord to screen y cord
	sub TILE_WIDTH * 2
	; decerement bytes in wWeatherScratch associated with this sprite
	ld h, HIGH(wWeatherScratch)
	ld l, a
rept TILE_WIDTH - 1
	dec [hl]
	inc l
endr
	dec [hl]
	ret

Lightning:
	ld hl, wWeatherFlags
	bit OW_WEATHER_DO_FLY_F, [hl]
	ret nz
	bit OW_WEATHER_LIGHTNING_DISABLED_F, [hl]
	ret nz
	call SetWhitePals
	farcall ApplyPals
	ld de, SFX_THUNDER_OW
	call PlaySFX
	call DelayFrame
	farcall LoadMapPals
	farcall ClearSavedObjPals
	ld hl, wPalFlags
	set NO_DYN_PAL_APPLY_UNTIL_RESET_F, [hl]
	farcall CheckForUsedObjPals
	farjp OWFadePalettesInit

LoadWeatherGraphics:
	ld a, [wCurWeather]
	assert OW_WEATHER_NONE == 0
	and a
	ret z
	assert OW_WEATHER_RAIN == 1
	dec a
	jr z, .rain
	assert OW_WEATHER_SNOW == 2
	dec a
	jr z, .snow
	assert OW_WEATHER_THUNDERSTORM == 3
	dec a
	jr z, .rain
	assert OW_WEATHER_SANDSTORM == 4
; sandstorm
	lb bc, BANK(SandGFX), 1
	ld de, SandGFX
	jr .continue
.rain
	lb bc, BANK(RainGFX), 2
	ld de, RainGFX
	jr .continue
.snow
	lb bc, BANK(SnowGFX), 1
	ld de, SnowGFX
.continue
	ld hl, vTiles0 tile WEATHER_TILE_1
	jmp Get2bpp


RainGFX: INCBIN "gfx/overworld/rain_splash.2bpp"
SnowGFX: INCBIN "gfx/overworld/snow.2bpp"
SandGFX: INCBIN "gfx/overworld/sand.2bpp"
