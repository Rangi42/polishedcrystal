_CopyTreePal:
	ld de, wOBPals1 + 6 palettes
	ld a, PAL_OW_COPY_BG_GREEN
	ld [wNeededPalIndex], a
CopySpritePal::
	push af
	push bc
	push hl
	push de
	ld a, [wNeededPalIndex]
	ld hl, wBGPals1 + PAL_BG_BROWN palettes
	cp PAL_OW_COPY_BG_BROWN
	jr z, .got_pal
	cp PAL_OW_COPY_BG_GREEN
	ld hl, wBGPals1 + PAL_BG_GREEN palettes
	jr z, .got_pal
	cp PAL_OW_COPY_BG_GRAY
	ld hl, wBGPals1 + PAL_BG_GRAY palettes
	jr z, .got_pal

	; CHECK DARKNESS
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
	ld hl, DarknessOBPalette
	ld bc, 1 palettes
	rst AddNTimes
	jr .got_pal

.not_darkness
	; CHECK OVERCAST
	farcall GetOvercastIndex
	and a
	jr z, .not_overcast
	ld a, [wNeededPalIndex]
	ld hl, OvercastOBPalette
	ld bc, 1 palettes
	rst AddNTimes
	jr .check_daytimes

.not_overcast
	ld a, [wNeededPalIndex]
	cp LAST_TIME_OF_DAY_OW_PAL
	jr c, .time_of_day_pal
	ld hl, SingleObjectPals
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
	ld bc, LAST_TIME_OF_DAY_OW_PAL palettes
	rst AddNTimes
.got_pal
	ld bc, 1 palettes
	pop de
	call FarCopyColorWRAM
	ld hl, wPalFlags
	bit NO_DYN_PAL_APPLY_F, [hl]
	jr nz, .skip_apply
	call ApplyOBPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.skip_apply
	pop af
	pop bc
	pop hl
	ret

ApplyOBPals:
	ld hl, wOBPals1
	ld de, wOBPals2
	ld bc, 8 palettes
	jmp FarCopyColorWRAM

MapObjectPals:
	table_width 1 palettes, MapObjectPals
if DEF(HGSS)
INCLUDE "gfx/tilesets/palettes/hgss/ob.pal"
elif DEF(MONOCHROME)
INCLUDE "gfx/tilesets/palettes/monochrome/ob.pal"
else
INCLUDE "gfx/overworld/npc_sprites.pal"
endc
	assert_table_length LAST_TIME_OF_DAY_OW_PAL * NUM_DAYTIMES ; morn, day, nite, eve

SingleObjectPals:
	table_width 1 palettes, SingleObjectPals
INCLUDE "gfx/overworld/npc_single_object.pal"
	assert_table_length LAST_INDIVIDUAL_OW_PAL - LAST_TIME_OF_DAY_OW_PAL

DarknessOBPalette:
	table_width 1 palettes, DarknessOBPalette
INCLUDE "gfx/overworld/npc_sprites_darkness.pal"
	assert_table_length LAST_INDIVIDUAL_OW_PAL

OvercastOBPalette:
	table_width 1 palettes, OvercastOBPalette
if DEF(HGSS)
INCLUDE "gfx/tilesets/palettes/hgss/ob_overcast.pal"
elif DEF(MONOCHROME)
INCLUDE "gfx/tilesets/palettes/monochrome/ob_overcast.pal"
else
INCLUDE "gfx/overworld/npc_sprites_overcast.pal"
endc
	assert_table_length LAST_TIME_OF_DAY_OW_PAL * NUM_DAYTIMES
