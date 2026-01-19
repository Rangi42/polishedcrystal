	const_def 1
	const PAL_FOR_MAP
	const PAL_FOR_LANDMARK
	const PAL_FOR_TILESET
	const PAL_FOR_OVERCAST
	const PAL_FOR_DARKNESS

	const_def 1
	const PAL_SINGLE
	const PAL_TIMEOFDAY
	const PAL_SPECIAL

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
	; hl = source
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, b
	dec a ; PAL_SINGLE?
	jr z, LoadSevenBGPalettes
	dec a ; PAL_TIMEOFDAY?
	jr z, LoadSevenTimeOfDayBGPalettes
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

; don't copy the eighth palette, it's loaded based on the map's sign
LoadSevenTimeOfDayBGPalettes:
	ld a, [wTimeOfDayPal]
	and 3
	ld bc, 8 palettes
	rst AddNTimes
LoadSevenBGPalettes:
	ld de, wBGPals1
	ld bc, 7 palettes
	call FarCopyColorWRAM
	scf
	ret

PokeCenterSpecialCase:
	ld hl, PokeCenterPalette
	call LoadSevenBGPalettes
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
	call LoadSevenBGPalettes
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
INCLUDE "data/maps/palettes_overcast.asm"
