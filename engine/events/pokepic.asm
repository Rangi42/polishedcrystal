Pokepic::
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
	farcall UpdateTimePals
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

Trainerpic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call MenuBox
	call UpdateSprites
	call SafeCopyTilemapAtOnce
	farcall LoadTrainerPalette
	farcall UpdateTimePals
	xor a
	ldh [hBGMapMode], a
	ld a, [wTrainerClass]
	ld de, vTiles1
	farcall GetTrainerPic
	jr _Displaypic

Paintingpic::
	farcall LoadPaintingPalette
	farcall UpdateTimePals
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
	jr _Displaypic

ClosePokepic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call ClearMenuBoxInterior
	call GetMemCGBLayout
	xor a
	ldh [hBGMapMode], a
	farcall LoadMapPart
	call UpdateSprites
	ld b, 1
	call SafeCopyTilemapAtOnce
	farjp RefreshSprites

PokepicMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 6, 4, 14, 12
	dw NULL
	db 1 ; default option
