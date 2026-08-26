	const_def 1
	const PAL_FOR_MAP
	const PAL_FOR_LANDMARK
	const PAL_FOR_TILESET
	const PAL_FOR_OVERCAST
	const PAL_FOR_DARKNESS

DEF PALSET_TYPE_MASK  EQU %11000000
DEF PALSET_START_MASK EQU %00111000
DEF PALSET_COUNT_MASK EQU %00000111

	const_def
	const PALTYPE_SINGLE      ; 0
	const PALTYPE_TIMEOFDAY   ; 1
	const PALTYPE_TIMEWEATHER ; 2
	const PALTYPE_SPECIAL     ; 3

LoadBlindingFlashPalette::
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld hl, BlindingFlashPalette
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

LoadLinkTradePalette:
	ld de, wBGPals1 palette 2
	ld hl, LinkTradePalette
	ld bc, 6 palettes
	jmp FarCopyColorWRAM

LoadSpecialMapPalette:
; Load a special map, landmark, or tileset palette if one applies.
	call InitializeSpecialPaletteRegisters
	ld hl, SpecialBGPalettes
.loop
	ld a, [hli]
	and a
	jr z, .not_special
	call CheckIfSpecialPaletteApplies
	jr nz, .next

	; b = type
	ld a, [hli]
	ld b, a
	and PALSET_START_MASK
	ld [wSpecialPalStart], a
	ld a, b
	rlca
	rlca
	ld b, a
	rlca
	and PALSET_COUNT_MASK << 3
	add 1 << 3
	ld [wSpecialPalCount], a
	ld a, b
	and PALSET_TYPE_MASK >> 6
	ld b, a
	; hl = source
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, b
	and a ; PAL_SINGLE?
	jr z, LoadSpecialBGPalettes
	dec a ; PAL_TIMEOFDAY?
	jr z, LoadSpecialTimeOfDayBGPalettes
	dec a ; PAL_TIMEWEATHER?
	jr z, LoadSpecialTimeWeatherBGPalettes
	; PAL_SPECIAL
	jp hl

.next
rept 3
	inc hl
endr
	jr .loop

.not_special
	and a
	ret

LoadSpecialTimeWeatherBGPalettes:
	push hl
	farcall GetOvercastIndex
	pop hl
	and a
	jr z, LoadSpecialTimeOfDayBGPalettes
	; skip the four regular time-of-day pals to reach the four overcast time-of-day pals
	ld a, [wSpecialPalCount]
	add a ; * 2 (most we can do in 8-bit without overflow)
	ld c, a
	ld b, 0
	add hl, bc ; + 2
	add hl, bc ; + 4
	; fallthrough
; don't copy the eighth palette, it's loaded based on the map's sign
LoadSpecialTimeOfDayBGPalettes:
	ld a, [wSpecialPalCount]
	ld c, a
	ld b, 0
	ld a, [wTimeOfDayPal]
	and 3
	rst AddNTimes
	; fallthrough
LoadSpecialBGPalettes:
	; de = wBGPals1 + [wSpecialPalStart]
	ld a, [wSpecialPalStart]
	add LOW(wBGPals1)
	ld e, a
	adc HIGH(wBGPals1)
	sub e
	ld d, a
	; bc = [wSpecialPalCount]
	ld a, [wSpecialPalCount]
	ld c, a
	ld b, 0
	call FarCopyColorWRAM
	scf
	ret

PokeCenterSpecialCase:
	ld hl, PokeCenterPalette
	call LoadSpecialBGPalettes
	; Shamouti has the default orange floors
	call RegionCheck
	ld a, e
	cp ORANGE_REGION
	jr z, .done
	; Kanto has blue floors
	ld hl, wBGPals1 palette PAL_BG_WATER
	dec e ; KANTO_REGION?
	jr z, .got_roof_pal
	; Snowtop Mountain has brown floors
	call GetWorldMapLocation
	cp SNOWTOP_MOUNTAIN
	ld hl, wBGPals1 palette PAL_BG_BROWN
	jr z, .got_roof_pal
	; Johto has red floors
	ld hl, wBGPals1 palette PAL_BG_RED
.got_roof_pal
	ld de, wBGPals1 palette PAL_BG_ROOF
	ld bc, 1 palettes
	call FarCopyColorWRAM
.done
	scf
	ret

MartSpecialCase:
	ld hl, MartPalette
	call LoadSpecialBGPalettes
	ld hl, wMapBlocksBank
	ld a, [hli]
	cp BANK(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld a, [hli]
	cp LOW(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld a, [hl]
	cp HIGH(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld hl, MartBluePalette
	ld de, wBGPals1 palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyColorWRAM
.not_generic_mart
	scf
	ret

MagnetTrainSpecialCase:
	; The Magnet Train animation sets the environment to TOWN instead of INDOOR.
	ld a, [wEnvironment]
	assert TOWN == 1
	dec a
	ret z
	; The Mart palette just replaces YELLOW (for the seats and caution stripes)
	; with the more muted Goldenrod roof palette.
	ld hl, MartPalette
	jr LoadSpecialBGPalettes

HiddenGrottoSpecialCase:
	ld a, [wTimeOfDayPal]
	and 3
	cp NITE
	ld hl, HiddenGrottoPalette
	jr nz, .got_palette
	ld hl, HiddenGrottoPalette + 7 palettes
.got_palette
	call LoadSpecialBGPalettes
	ld a, [wBackupMapGroup]
	ld hl, wBGPals1 palette PAL_BG_RED
	cp GROUP_BELLCHIME_TRAIL
	jr nz, .not_bellchime_trail_grotto
	ld a, [wBackupMapNumber]
	cp MAP_BELLCHIME_TRAIL
	jr z, .continue
.not_bellchime_trail_grotto
	ld hl, wBGPals1 palette PAL_BG_GRAY
	cp GROUP_CHERRYGROVE_BAY
	jr nz, .not_cherrygrove_bay
	ld a, [wBackupMapNumber]
	cp MAP_CHERRYGROVE_BAY
	jr z, .continue
.not_cherrygrove_bay
	ld hl, wBGPals1 palette PAL_BG_WATER
	cp GROUP_YELLOW_FOREST
	jr nz, .done
	ld a, [wBackupMapNumber]
	cp MAP_YELLOW_FOREST
	jr nz, .done
.continue
	ld de, wBGPals1 palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld hl, wBGPals1 palette PAL_BG_GREEN color 1
	ld de, wBGPals1 palette PAL_BG_ROOF color 1
	ld bc, 3 colors
	call FarCopyColorWRAM
.done
	scf
	ret

InitializeSpecialPaletteRegisters:
	; b, c, d, e = [wMapGroup], [wMapNumber], landmark, [wMapTileset]
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld d, a
	ld a, [wMapTileset]
	ld e, a
	ret

CheckIfSpecialPaletteApplies:
	dec a ; PAL_FOR_MAP?
	jr nz, .not_map
	ld a, [hli]
	cp b ; [wMapGroup]
	ld a, [hli]
	ret nz
	cp c ; [wMapNumber]
	ret
.not_map
	dec a ; PAL_FOR_LANDMARK?
	jr nz, .not_landmark
	ld a, [hli]
	cp d ; landmark
	ret
.not_landmark
	dec a ; PAL_FOR_TILESET?
	jr nz, .not_tileset
	ld a, [hli]
	cp e ; [wTileset]
	ret
.not_tileset
	dec a ; PAL_FOR_OVERCAST?
	jr nz, .not_overcast
	push hl
	farcall GetOvercastIndex
	pop hl
	; invert z
	sub 1 ; no-optimize a++|a-- (dec a can't set carry)
	sbc a ; sets a to 0 if carry was not set, i.e. a != 0
	ret
.not_overcast
	; PAL_FOR_DARKNESS
	push hl
	push de
	call GetMapTimeOfDay
	pop de
	pop hl
	or ~IN_DARKNESS
	inc a
	ret nz
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	ret

INCLUDE "data/maps/palettes.asm"
