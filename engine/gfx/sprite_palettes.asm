LoadWeatherPalNoApply:
	ld hl, wPalFlags
	set NO_DYN_PAL_APPLY_ONCE_F, [hl]
LoadWeatherPal::
	ld a, [wCurWeather]
	assert OW_WEATHER_NONE == 0
	and a
	ret z
	dec a
	call StackJumpTable

.Jumptable:
	table_width 2
	dw .rain
	dw .snow
	dw .rain ; thunderstorm
	dw .sand
	dw .cherry
	dw .sun
	assert_table_length NUM_OW_WEATHERS

.rain
	ld a, PAL_OW_RAIN
	jr .use_ow_weather_pal

.sand
	ld a, PAL_OW_SAND
	jr .use_ow_weather_pal

.cherry
	ld a, PAL_OW_PINK
	; fallthrough
.use_ow_weather_pal
	ld [wNeededPalIndex], a
	ld [wLoadedObjPal{d:PAL_OW_WEATHER}], a
	ld de, wOBPals1 palette PAL_OW_WEATHER
	jr CopySpritePalHandler

.sun
	; Harsh sunlight has no dedicated weather sprite palette.
	ret

.snow
	ldh a, [rWBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rWBK], a
	; we are not loading an official palette,
	; so this tells dynamic pals to not associate this
	; palette with a sprite.
	ld a, NO_PAL_LOADED
	ld [wLoadedObjPal7], a
	ld hl, wOBPals1 palette PAL_OW_WEATHER
if !DEF(MONOCHROME)
	assert LOW(NO_PAL_LOADED) == $ff
	ld bc, 1 palettes
	rst ByteFill
else
	ld bc, PAL_MONOCHROME_WHITE
	ld a, 4 colors
.loop
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	dec a
	jr nz, .loop
endc
	ld a, [wPalFlags]
	and NO_DYN_PAL_APPLY
	jr nz, .skip_apply
	call ApplyWeatherPal
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.skip_apply
	pop af
	ldh [rWBK], a
	ret

CopyBGGreenToOBPal7:
; Some overworld effects (Fly leaves, Cut leaves, Cut trees, Headbutt trees)
; have hard-coded OB palette 7 in their OAM data.
	ld a, PAL_OW_COPY_BG_GREEN
	; fallthrough
CopySpritePalToOBPal7:
	ld [wNeededPalIndex], a
	ld [wLoadedObjPal7], a
	ld de, wOBPals1 palette 7
	; fallthrough
CopySpritePalHandler::
	; check if we are fading palettes
	ldh a, [rWBK]
	push af
	ld a, BANK(wPalFadeDelayFrames)
	ldh [rWBK], a
	ld a, [wPalFadeDelayFrames]
	and a
	jr z, .not_fading
	; we are fading, time for fancy stuff.
	; assume we already already have previous pal states saved.
	pop af
	ldh [rWBK], a
	xor a
	assert PREV_PALSTATE == 0
	ld [wPalState], a
	ld a, [wPalFlags]
	push af
	and ~NO_DYN_PAL_APPLY
	ld [wPalFlags], a
	push de
	push hl
	ld a, [wPalWhiteState]
	and a
	jr z, .copy_sprite_pal
	; fading from white
	ld hl, wOBPals2 - wOBPals1
	add hl, de
	ld d, h
	ld e, l
	call CopyWhitePal
	jr .copied_pal
.copy_sprite_pal
	call CopySpritePal
.copied_pal
	pop hl
	pop de
	ld a, [wPalFlags]
	or NO_DYN_PAL_APPLY
	ld [wPalFlags], a
	ld a, CURR_PALSTATE
	ld [wPalState], a
	call CalculateStates
	call CopySpritePal
	push de
	push bc
	ld c, 1 palettes
	ld a, e
	sub LOW(wOBPals1)
	call SimpleDivide
	ld a, b
	pop bc
	pop de
	push bc
	push de
	push hl
	farcall CatchUpObjPaletteFade
	pop hl
	pop de
	pop bc
	pop af
	ld [wPalFlags], a
	ret

.not_fading
	pop af
	ldh [rWBK], a
	ld a, CURR_PALSTATE
	ld [wPalState], a
	call CalculateStates
; fallthrough
CopySpritePal::
	push af
	push bc
	push hl
	push de
	ld a, [wNeededPalIndex]
	sub FIRST_COPY_BG_PAL
	jr c, .not_copy_bg
	; For copy-BG palettes: use the matching BG buffer for the current pal state.
	; PREV_PALSTATE uses wBGPals2 (current display), CURR_PALSTATE uses wBGPals1 (destination).
	push af
	ld a, [wPalState]
	and a ; PREV_PALSTATE == 0
	ld hl, wBGPals2
	jr z, .got_copy_bg_source
	ld hl, wBGPals1
.got_copy_bg_source
	pop af
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.not_copy_bg
	; skip darkness/overcast if USE_DAYTIME_PAL_F
	ld a, [wPalFlags]
	bit USE_DAYTIME_PAL_F, a
	jr nz, .not_overcast

	; check darkness
	ld a, PALSTATE_DARKNESS
	call GetPalState
	and a
	jr z, .not_darkness
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr nc, .not_darkness
	ld hl, DarknessOBPalette
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.not_darkness
	; check overcast
	ld a, PALSTATE_OVERCAST_INDEX
	call GetPalState
	and a
	jr z, .not_overcast
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr nc, .not_overcast
	ld hl, OvercastOBPalette
	ld bc, 1 palettes
	rst AddNTimes
	jr .check_daytimes

.not_overcast
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr c, .time_of_day_pal
	ld hl, SingleObjectPals - NUM_OW_TIME_OF_DAY_PALS palettes
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.time_of_day_pal
	ld hl, MapObjectPals
	ld bc, 1 palettes
	rst AddNTimes
.check_daytimes
	ld a, [wPalFlags]
	bit USE_DAYTIME_PAL_F, a
	ld a, DAY
	jr nz, .daytime
	ld a, PALSTATE_TIME_OF_DAY
	call GetPalState
.daytime
	maskbits NUM_DAYTIMES
	ld bc, NUM_OW_TIME_OF_DAY_PALS palettes
	rst AddNTimes
.got_pal
	pop de
	push de ; push wOBPals1 palette *
	ld bc, 1 palettes
	call FarCopyColorWRAM
	pop hl ; pop wOBPals1 palette *
	; Skip harsh sun saturation for copy-BG palettes (already applied to BG)
	ld a, [wNeededPalIndex]
	cp FIRST_COPY_BG_PAL
	call c, MaybeApplyHarshSunSaturationToPal
	ld a, [wPalFlags]
	and NO_DYN_PAL_APPLY
	jr nz, .skip_apply

	push hl
	ld de, wOBPals2 - wOBPals1
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, 1 palettes
	call FarCopyColorWRAM

	ld a, TRUE
	ldh [hCGBPalUpdate], a
.skip_apply
	pop hl
	pop bc
	pop af
	ret

ApplyWeatherPal:
	ld hl, wOBPals1 palette PAL_OW_WEATHER
	ld de, wOBPals2 palette PAL_OW_WEATHER
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

ApplyOBPals:
	ld hl, wOBPals1
	ld de, wOBPals2
	ld bc, 8 palettes
	jmp FarCopyColorWRAM

GetPalState:
; input: a = state index
; output: a = state value
	push hl
	push de
	add LOW(wPalStates)
	ld l, a
	adc HIGH(wPalStates)
	sub l
	ld h, a
	ld a, [wPalState]
	and a ; prev
	assert PREV_PALSTATE == 0
	jr z, .got_state
	ld de, PALSTATE_SIZE
	add hl, de
.got_state
	ld a, [hl]
	pop de
	pop hl
	ret

SavePrevPalStates:
	xor a
; fallthrough
CalculateStates:
; input: a = 0 (previous), 1 (current)
	push hl
	ld hl, wPrevPalStates
	and a
	jr z, .got_state
	ld hl, wCurPalStates
.got_state
	ld a, [wCurWeather]
	ld [hli], a
	ld a, [wCurPalWeatherArgState]
	ld [hli], a
	push de
	call GetMapTimeOfDay
	pop de
	or ~IN_DARKNESS
	inc a
	jr nz, .not_darkness
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	ld a, 1
	jr z, .got_darkness
.not_darkness
	xor a
.got_darkness
	ld [hli], a
	push hl
	push de
	farcall GetOvercastIndex
	pop de
	pop hl
	ld [hli], a
	ld a, [wTimeOfDayPal]
	ld [hl], a
	pop hl
	ret

MaybeApplyHarshSunSaturationToPal:
; input: hl = palette data in wOBPals1 (1 palettes)
	push af
	push bc
	push de
	push hl

	ld a, PALSTATE_WEATHER
	call GetPalState
	cp OW_WEATHER_HARSH_SUN
	jp nz, .done
	ld a, PALSTATE_WEATHER_ARG
	call GetPalState
	and a
	jp z, .done

	ldh a, [rWBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rWBK], a

	ld b, 4 ; PAL_COLORS
.color_loop
	; load color (little endian)
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; red = e & $1f
	ld a, e
	and $1f
	cp 8
	jr c, .red_low
	add 8
	jr .red_clamp
.red_low
	add 4
.red_clamp
	cp 32
	jr c, .red_ok
	ld a, 31
.red_ok
	push af ; save red

	; green = (e >> 5) | ((d & 3) << 3)
	ld a, e
	srl a
	srl a
	srl a
	srl a
	srl a
	ld c, a
	ld a, d
	and $03
	add a
	add a
	add a
	or c
	cp 8
	jr c, .green_low
	add 6
	jr .green_clamp
.green_low
	add 3
.green_clamp
	cp 32
	jr c, .green_ok
	ld a, 31
.green_ok
	ld c, a ; c = green
	pop af ; a = red

	; low byte = red | ((green & 7) << 5)
	push af
	ld a, c
	and $07
	add a
	add a
	add a
	add a
	add a
	ld e, a
	pop af
	or e
	ld e, a

	; blue = (d >> 2) & $1f
	ld a, d
	srl a
	srl a
	and $1f
	cp 4
	jr c, .blue_zero
	sub 4
	jr .blue_done
.blue_zero
	xor a
.blue_done
	ld d, a ; d = blue

	; high byte = (blue << 2) | (green >> 3)
	ld a, d
	add a
	add a
	and $7c
	ld d, a
	ld a, c
	srl a
	srl a
	srl a
	and $03
	or d
	ld d, a

	; write back (step hl back 2)
	dec hl
	ld [hl], d
	dec hl
	ld [hl], e
	inc hl
	inc hl

	dec b
	jr nz, .color_loop

	pop af
	ldh [rWBK], a

.done
	pop hl
	pop de
	pop bc
	pop af
	ret

CopyWhitePal:
; target palette in de
	push hl
	push bc
	ld h, d
	ld l, e
	ldh a, [rWBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rWBK], a
	; we are not loading an official palette,
	; so this tells dynamic pals to not associate this
	; palette with a sprite.
if !DEF(MONOCHROME)
	ld a, $ff
	ld bc, 1 palettes
	rst ByteFill
else
	ld bc, PAL_MONOCHROME_WHITE
	ld a, 4 colors
.loop
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	dec a
	jr nz, .loop
endc
	pop af
	ldh [rWBK], a
	pop bc
	pop hl
	ret

MapObjectPals:
	table_width 1 palettes
INCLUDE "gfx/overworld/npc_sprites.pal"
	assert_table_length NUM_OW_TIME_OF_DAY_PALS * NUM_DAYTIMES ; morn, day, nite, eve

SingleObjectPals:
	table_width 1 palettes
INCLUDE "gfx/overworld/npc_single_object.pal"
	assert_table_length NUM_OW_INDIVIDUAL_PALS

DarknessOBPalette:
	table_width 1 palettes
INCLUDE "gfx/overworld/npc_sprites_darkness.pal"
	assert_table_length NUM_OW_TIME_OF_DAY_PALS + NUM_OW_INDIVIDUAL_PALS

OvercastOBPalette:
	table_width 1 palettes
INCLUDE "gfx/overworld/npc_sprites_overcast.pal"
	assert_table_length NUM_OW_TIME_OF_DAY_PALS * NUM_DAYTIMES
