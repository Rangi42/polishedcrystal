DoOverworldWeather:
	push de
	push hl
	push bc
	ld a, [wOverworldWeatherDelay]
	and %1 ; 30 fps
	jr z, .done
	ld a, [wOverworldWeatherCooldown]
	and a
	jr z, .no_cooldown
	dec a
	ld [wOverworldWeatherCooldown], a
.no_cooldown
	ldh a, [hUsedOAMIndex]
	cpl
	add (SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS) + 1
	ld hl, hUsedWeatherSpriteIndex
	cp [hl]
	jr nc, .ok
	add -SPRITEOAMSTRUCT_LENGTH
	ldh [hUsedWeatherSpriteIndex], a
.ok
	ld a, [wOverworldWeatherCooldown]
	and a
	jr nz, .on_cooldown
	ld a, [wCurrentWeather]
	dec a ; OW_WEATHER_RAIN
	call z, DoOverworldRain
	ld a, [wCurrentWeather]
	cp OW_WEATHER_SNOW
	call z, DoOverworldSnow
	ld a, [wCurrentWeather]
	cp OW_WEATHER_THUNDERSTORM
	call z, DoOverworldRain
	ld a, [wCurrentWeather]
	cp OW_WEATHER_SANDSTORM
	call z, DoOverworldSandstorm
.done
	farcall OWFadePalettesStep
	ld hl, wOverworldWeatherDelay
	inc [hl]
	call WeatherSpriteLimitCheck
	pop bc
	pop hl
	pop de
	ret

.on_cooldown
	ld a, [wPrevWeather]
	cp OW_WEATHER_RAIN
	jr z, .rain_cooldown
	cp OW_WEATHER_THUNDERSTORM
	jr z, .rain_cooldown
	cp OW_WEATHER_SNOW
	jr z, .snow_cooldown
	call DoSandFall
	jr .cooldown_cleanup
.snow_cooldown
	call DoSnowFall
	jr .cooldown_cleanup
.rain_cooldown
	call DoRainFall
	call RainSplashCleanup
.cooldown_cleanup
	ld a, [wOverworldWeatherCooldown]
	dec a
	call z, ClearWeather
	jr .done

SpawnRandomWeatherFullScreen::
	lb bc, SCREEN_WIDTH_PX, SCREEN_HEIGHT_PX
; fallthrough
SpawnRandomWeatherCoords::
; This is used to randomize the weather's starting position within an area
; assumes minimum sprite x/y coords are 0.
; bc = max screen x/y coords
	ld a, [wCurrentWeather]
	and a
	ret z
	ld a, [wCurrentWeather]
	dec a ; rain
	jr z, .rain
.snow_loop
	push bc
	call ScanForEmptyOAM
	pop bc
	ret c
	ld a, c
	call RandomRange
	ld [hli], a
	ld a, b
	call RandomRange
	ld [hli], a
	ld a, $6d
	ld [hli], a
	ld a, 6 ; pallete 6
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	jr nc, .snow_loop
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	jr .snow_loop

.rain
	push bc
	call ScanForEmptyOAM
	pop bc
	ret c
	ld a, c
	call RandomRange
	ld [hli], a
	ld a, b
	call RandomRange
	ld [hli], a
	call Random
	cp 20 percent ; 20 percent splashes
	ld a, $6e
	jr c, .got_tile
	ld a, $6d
.got_tile
	ld [hli], a
	ld a, 6 ; pallete 6
	ld [hld], a
	dec hl
	dec hl
	ldh a, [hUsedWeatherSpriteIndex]
	cp l
	jr nc, .rain
	ld a, l
	ldh [hUsedWeatherSpriteIndex], a
	jr .rain

DoOverworldSnow:
	ld a, [wLoadedObjPal6]
	inc a
	jr z, .continue
	farcall LoadWeatherPal
.continue
	call ScanForEmptyOAM
	call nc, SpawnSnowFlake
	call ScanForEmptyOAM
	call nc, SpawnSnowFlake
; fallthrough
DoSnowFall:
	ld de, wShadowOAM
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	ld hl, SPRITEOAMSTRUCT_YCOORD
	ld a, [hl]
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	jr z, .next
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hli]
	cp $6d ; tile id
	jr nz, .next
	ld a, [hl]
	cp 6 ; pallete 6
	jr nz, .next

	call Random
	cp 1 percent
	jr nc, .ok
	call Random
	cp 10 percent
	jr c, .despawn
.ok

	ld a, [wPlayerStepVectorY]
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, [hl]
	sub c
	ld c, a
	call GetDropSpeedModifier
	add c
	add 2
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	ld [hl], a
	jr nc, .despawn

	ld a, [wPlayerStepVectorX]
	add a
	ld c, a
	call Random
	and 1
	ld a, c
	jr nz, .no_add_1
	inc a
.no_add_1
	ld c, a
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	ld a, [hl]
	sub c
	inc a
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	sub 1 ; no-optimize a++|a-- (need to set carry)
	ld [hl], a
	jr c, .despawn
.next
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
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
	ld a, [wCurrentWeather]
	cp OW_WEATHER_THUNDERSTORM
	jr nz, .no_lightning
	call Random
	cp 1 percent
	jr nc, .no_lightning
	call Random
	cp 50 percent
	call c, Lightning ; Do you get the reference?
.no_lightning
	call ScanForEmptyOAM
	call nc, SpawnRainDrop
	call ScanForEmptyOAM
	call nc, SpawnRainDrop
	call ScanForEmptyOAM
	call nc, SpawnRainDrop
	call DoRainFall
; fallthrough
RainSplashCleanup:
	ld a, [wOverworldWeatherDelay]
	and %1110
	ret nz
	ld de, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hli]
	cp $6e ; tile id
	jr nz, .next
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld [hl], SCREEN_HEIGHT_PX + (TILE_WIDTH * 2) ; offscreen
.next
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

SpawnSnowFlake:
	call Random
	cp 40 percent
	ret nc
	call Random
	and %11
	jr z, .spawn_on_right
	xor a
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	inc a
	ld [hli], a
.finish
	ld a, $6d ; tile id
	ld [hli], a
	ld a, 6 ; pallete 6
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
	ld a, SCREEN_HEIGHT_PX + 8
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 8
	ld [hli], a
	jr .finish

ScanForEmptyOAM:
; return empty OAM slot in de or carry set if none
	ld de, wShadowOAM
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	ld a, [hl]
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2) ; offscreen
	ret z
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	; all sprites are onscreen
	scf
	ret

SpawnRainDrop:
	call Random
	and 1
	jr z, .spawn_on_right
	xor a
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	add 8
	ld [hli], a
.finish
	ld a, $6d ; tile id
	ld [hli], a
	ld a, 6 ; pallete 6
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
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + TILE_WIDTH
	ld [hli], a
	jr .finish

ClearWeather:
	xor a
	ldh [hUsedWeatherSpriteIndex], a
	ret

DoRainFall:
	ld de, wShadowOAM
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	ld hl, SPRITEOAMSTRUCT_YCOORD
	ld a, [hl]
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	jr z, .next
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hli]
	cp $6e
	jr z, .update_splash
	cp $6d ; rain tile id
	jr nz, .next
	ld a, [hl]
	cp 6 ; pallete 6
	jr nz, .next

	call Random
	cp 5 percent
	jr c, .splash

	ld a, [wPlayerStepVectorY]
	add a
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, [hl]
	sub c
	ld c, a
	call GetDropSpeedModifier
	add a
	add c
	add 8
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	ld [hl], a
	jr nc, .despawn

	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	ld a, [hl]
	sub c
	ld c, a
	call GetDropSpeedModifier
	cpl
	inc a
	add a
	add c
	sub 4
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	ld [hl], a
	jr c, .despawn
.next
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .next

.update_splash
	ld a, [hl]
	cp 6 ; pallete 6
	jr nz, .next
	ld a, [wPlayerStepVectorY]
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, [hl]
	sub c
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	jr nc, .despawn
	ld [hli], a
	ld a, [wPlayerStepVectorX]
	add a
	ld c, a
	ld a, [hl]
	sub c
	ld [hl], a
	jr .next


.splash
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld [hl], $6e ; tile id
	jr .next


DoOverworldSandstorm:
	ld a, [wLoadedObjPal6]
	cp PAL_OW_SAND
	jr z, .continue
	farcall LoadWeatherPal
.continue
	call ScanForEmptyOAM
	call nc, SpawnSandDrop
	call ScanForEmptyOAM
	call nc, SpawnSandDrop
	call ScanForEmptyOAM
	call nc, SpawnSandDrop
; fallthrough
DoSandFall:
	ld de, wShadowOAM
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	ld hl, SPRITEOAMSTRUCT_YCOORD
	ld a, [hl]
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	jr z, .next
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hli]
	cp $6d ; sand tile id
	jr nz, .next
	ld a, [hl]
	cp 6 ; pallete 6
	jr nz, .next

	call Random
	cp 5 percent
	jr c, .despawn

	ld a, [wPlayerStepVectorY]
	add a
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, [hl]
	sub c
	ld c, a
	call GetDropSpeedModifier
	add a
	add c
	sub 4
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	cp SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	ld [hl], a
	jr nc, .despawn

	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	ld a, [hl]
	sub c
	ld c, a
	call GetDropSpeedModifier
	cpl
	inc a
	add a
	add c
	sub 12
	ld hl, SPRITEOAMSTRUCT_XCOORD
	add hl, de
	ld [hl], a
	jr c, .despawn
.next
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	dec b
	jr nz, .loop
	ret

.despawn
	ld hl, SPRITEOAMSTRUCT_YCOORD
	add hl, de
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .next

SpawnSandDrop:
	call Random
	and 1
	jr z, .spawn_on_right
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 1)
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + 7
	call RandomRange
	add 8
	ld [hli], a
.finish
	ld a, $6d ; tile id
	ld [hli], a
	ld a, 6 ; pallete 6
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
	ld a, SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
	call RandomRange
	ld [hli], a
	ld a, SCREEN_WIDTH_PX + TILE_WIDTH
	ld [hli], a
	jr .finish

GetDropSpeedModifier:
; input: e = sprite index
; output: a = is_even(e / 4)
	ld a, e
	rra
	rra ; / 4
	and 1
	ret

WeatherSpriteLimitCheck:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wWeatherScratch)
	ldh [rSVBK], a
	xor a
	; clear wWeatherScratch
	ld hl, wWeatherScratch
	ld bc, SCREEN_HEIGHT_PX
	rst ByteFill
	ld hl, wShadowOAM
	ld de, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
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
	ld hl, SPRITEOAMSTRUCT_LENGTH
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
	ldh [rSVBK], a
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
	ld hl, wShadowOAM + (NUM_SPRITE_OAM_STRUCTS - 1) * SPRITEOAMSTRUCT_LENGTH
	ld e, l ; d is still set to HIGH(wShadowOAM)
rept NUM_SPRITE_OAM_STRUCTS
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
	ld hl, -SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld e, l
endr
	pop af
	pop hl
	ret

.delete_sprite
	; hl = sprite to delete
	ld a, [hl]
	ld [hl], SCREEN_HEIGHT_PX + (TILE_WIDTH * 2)
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
	call SetWhitePals
	farcall ApplyPals
	call DelayFrame
	farcall LoadMapPals
	farcall ClearSavedObjPals
	ld hl, wPalFlags
	set NO_DYN_PAL_APPLY_UNTIL_RESET_F, [hl]
	farcall CheckForUsedObjPals
	farjp OWFadePalettesInit

LoadWeatherGraphics:
	ld a, [wCurrentWeather]
	and a
	ret z
	dec a
	jr z, .rain
	dec a
	jr z, .snow
	dec a
	jr z, .rain
; standstorm
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
	ld hl, vTiles0 tile $6d
	jmp Get2bpp


RainGFX:   INCBIN "gfx/overworld/rain.2bpp"
SplashGFX: INCBIN "gfx/overworld/rain_splash.2bpp"
SnowGFX:   INCBIN "gfx/overworld/snow.2bpp"
SandGFX:   INCBIN "gfx/overworld/sand.2bpp"