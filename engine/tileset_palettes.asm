	const_def 1
	const PAL_FOR_MAP
	const PAL_FOR_LANDMARK
	const PAL_FOR_TILESET
	const PAL_FOR_OVERCAST

	const_def 1
	const PAL_SINGLE
	const PAL_TIMEOFDAY
	const PAL_SPECIAL


LoadBlindingFlashPalette::
	ld a, $5
	ld de, wUnknBGPals palette PAL_BG_TEXT
	ld hl, BlindingFlashPalette
	ld bc, 1 palettes
	jp FarCopyWRAM

LoadLinkTradePalette:
	ld a, $5
	ld de, wUnknBGPals palette 2
	ld hl, LinkTradePalette
	ld bc, 6 palettes
	jp FarCopyWRAM


LoadSpecialMapPalette: ; 494ac
; Don't load a special palette if it's dark and we haven't used Flash.
	call GetMapHeaderTimeOfDayNybble
	cp PALETTE_DARK
	jr nz, .not_dark
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	jr z, .not_special

.not_dark
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
	jr z, LoadEightBGPalettes
	dec a ; PAL_TIMEOFDAY?
	jr z, LoadEightTimeOfDayBGPalettes
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

LoadEightTimeOfDayBGPalettes:
	ld a, [wTimeOfDayPal]
	and 3
	ld bc, 8 palettes
	rst AddNTimes
LoadEightBGPalettes:
	ld a, $5
	ld de, wUnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	scf
	ret


PokeCenterSpecialCase:
	ld hl, wMapGroup
	call .check_shamouti_pokecenter
	jr z, LoadEightBGPalettes
	ld hl, wBackupMapGroup
	call .check_shamouti_pokecenter
	jr z, LoadEightBGPalettes
	ld hl, PokeCenterPalette
	jr LoadEightBGPalettes

.check_shamouti_pokecenter
	ld a, [hli]
	cp GROUP_SHAMOUTI_POKECENTER_1F
	ret nz
	ld a, [hl]
	cp MAP_SHAMOUTI_POKECENTER_1F
	ld hl, ShamoutiPokeCenterPalette
	ret

MartSpecialCase:
	GLOBAL GenericMart_BlockData
	ld hl, MartPalette
	call LoadEightBGPalettes
	ld hl, wMapBlockDataBank
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
	ld a, $5
	ld de, wUnknBGPals palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyWRAM
.not_generic_mart
	scf
	ret


LoadSpecialMapOBPalette:
; Load a special map, landmark, or tileset palette if one applies.
	call InitializeSpecialPaletteRegisters
	ld hl, SpecialOBPalettes
.loop
	ld a, [hli]
	and a
	ret z
	call CheckIfSpecialPaletteApplies
	jr nz, .next

	; bc = source
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a

	; a = skip bytes
	ld a, [hli]
	and a
	jr z, .no_skip
	push hl
	ld h, b
	ld l, c
	ld c, a
	ld b, 0
	ld a, [wTimeOfDayPal]
	and 3
	rst AddNTimes
	ld b, h
	ld c, l
	pop hl
.no_skip

	; de = destination
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; a = length
	ld a, [hl]

	ld h, b
	ld l, c
	ld c, a
	ld b, 0
	ld a, $5
	jp FarCopyWRAM

.next
rept 6
	inc hl
endr
	jr .loop


InitializeSpecialPaletteRegisters:
	; b, c, d, e = [wMapGroup], [wMapNumber], landmark, [wTileset]
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld d, a
	ld a, [wTileset]
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
	; PAL_FOR_OVERCAST
	push hl
	call GetOvercastIndex
	pop hl
	; invert z
	sub 1 ; underflows if a == 0, setting carry
	sbc a ; sets a to 0 if carry was not set, i.e. a != 0
	ret


INCLUDE "data/maps/palettes.asm"
