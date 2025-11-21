LoadWeatherPalNoApply:
	ld hl, wPalFlags
	set NO_DYN_PAL_APPLY_ONCE_F, [hl]
LoadWeatherPal::
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
	jr z, .rain ; thunderstorm
	assert OW_WEATHER_SANDSTORM == 4
	; fallthrough

	ld a, PAL_OW_SAND
.use_pal_6
	ld [wNeededPalIndex], a
	ld [wLoadedObjPal6], a
	ld de, wOBPals1 palette 6
	jr CopySpritePal

.rain
	ld a, PAL_OW_RAIN
	jr .use_pal_6

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
	ld hl, wOBPals1 palette 6
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
CopySpritePal::
	push af
	push bc
	push hl
	push de
	ld a, [wNeededPalIndex]
	sub FIRST_COPY_BG_PAL
	jr c, .not_copy_bg
	ld hl, wBGPals1
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.not_copy_bg
	; skip darkness/overcast if USE_DAYTIME_PAL_F
	ld a, [wPalFlags]
	bit USE_DAYTIME_PAL_F, a
	jr nz, .not_overcast

	; check darkness
	push hl
	push de
	call GetMapTimeOfDay
	pop de
	pop hl
	or ~IN_DARKNESS
	inc a
	jr nz, .not_darkness
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	jr nz, .not_darkness
	ld a, [wNeededPalIndex]
	cp NUM_OW_TIME_OF_DAY_PALS
	jr nc, .not_darkness
	ld hl, DarknessOBPalette
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.not_darkness
	; check overcast
	farcall GetOvercastIndex
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
	ld a, [wTimeOfDayPal]
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
	ld hl, wOBPals1 palette 6
	ld de, wOBPals2 palette 6
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

ApplyOBPals:
	ld hl, wOBPals1
	ld de, wOBPals2
	ld bc, 8 palettes
	jmp FarCopyColorWRAM

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
