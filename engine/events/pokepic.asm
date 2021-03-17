Pokepic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call MenuBox
	call UpdateSprites
	ld a, [wCurForm]
	cp -1
	jr z, .partymon
	farcall LoadPokemonPalette
	jr .got_palette
.partymon
	farcall LoadPartyMonPalette
	ld hl, wPartyMon1Form
	ld a, [wCurPartyMon]
	call GetPartyLocation
	farcall GetVariant
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
	jp SafeCopyTilemapAtOnce

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
	lb bc, BANK(PaintingFrameGFX), 9
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
	jp _Displaypic

ClosePokepic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuHeader
	call ClearMenuBoxInterior
	call GetMemCGBLayout
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call UpdateSprites
	ld b, 1
	call SafeCopyTilemapAtOnce
	farjp RefreshSprites

PokepicMenuDataHeader:
	db $40 ; flags
	db 04, 06 ; start coords
	db 12, 14 ; end coords
	dw NULL
	db 1 ; default option
