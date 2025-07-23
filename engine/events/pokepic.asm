Pokepic::
	call BackupSprites
	call ClearSpritesUnderPokePic
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call MenuBox
	call UpdateSprites
	ld de, wBGPals1 palette PAL_BG_TEXT + 2
	ld a, [wCurForm]
	cp -1
	jr z, .partymon
	farcall LoadPokemonPalette
	jr .got_palette
.partymon
	farcall LoadPartyMonPalette
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld [wCurForm], a
.got_palette
	call UpdateTimePals
	xor a
	ldh [hBGMapMode], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld de, vTiles1
	predef GetFrontpic
_Displaypic:
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	ld b, 1
	jmp SafeCopyTilemapAtOnce

ClearSpritesUnderPokePic:
	ld de, wShadowOAMSprite00
	ld h, d
	ld l, e
	ld c, OAM_COUNT
.loop
	; Check if (5 * TILE_WIDTH + 1) ≤ YCoord < (15 * TILE_WIDTH)
	ld a, [hli]
	cp 5 * TILE_WIDTH + 1
	jr c, .next
	cp 15 * TILE_WIDTH
	jr nc, .next
	; Check if (6 * TILE_WIDTH + 1) ≤ XCoord < (16 * TILE_WIDTH)
	ld a, [hl]
	cp 6 * TILE_WIDTH + 1
	jr c, .next
	cp 16 * TILE_WIDTH
	jr c, .clear_sprite
; fallthrough
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld e, l
	dec c
	jr nz, .loop
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hOAMUpdate], a
	ret

.clear_sprite
	dec l
	ld [hl], OAM_YCOORD_HIDDEN
	inc l
	jr .next

Trainerpic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call MenuBox
	call UpdateSprites
	call SafeCopyTilemapAtOnce
	farcall LoadTrainerPalette
	call UpdateTimePals
	xor a
	ldh [hBGMapMode], a
	ld a, [wTrainerClass]
	ld de, vTiles1
	farcall GetTrainerPic
	jr _Displaypic

Paintingpic::
	farcall LoadPaintingPalette
	call UpdateTimePals
	ld de, PaintingFrameGFX
	ld hl, vTiles0 tile ("┌" - 3)
	lb bc, BANK(PaintingFrameGFX), 11
	call Get2bpp
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call MenuBox
	hlcoord 9, 12
	ld a, "┌" - 3
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	call UpdateSprites
	xor a
	ldh [hBGMapMode], a
	ld a, [wTrainerClass]
	ld de, vTiles1
	farcall GetPaintingPic
	jmp _Displaypic

ClosePokepic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call ClearMenuBoxInterior
	call GetMemCGBLayout
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call RestoreSprites
	call UpdateSprites
	ld b, 1
	call SafeCopyTilemapAtOnce
	farjp RefreshSprites

PokepicMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 6, 4, 14, 12
	dw NULL
	db 1 ; default option
