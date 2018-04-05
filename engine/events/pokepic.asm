Pokepic:: ; 244e3
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	ld a, [IsCurMonInParty]
	and a
	jr nz, .partymon
	farcall LoadPokemonPalette
	ld a, 1
	ld [MonVariant], a
	jr .got_palette
.partymon
	farcall LoadPartyMonPalette
	ld hl, PartyMon1Form
	ld a, [CurPartyMon]
	farcall GetPartyLocation
	farcall GetVariant
.got_palette
	call UpdateTimePals
	xor a
	ld [hBGMapMode], a
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld de, VTiles1
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
	ld [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	jp WaitBGMap

Trainerpic::
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	farcall LoadTrainerPalette
	call UpdateTimePals
	xor a
	ld [hBGMapMode], a
	ld a, [TrainerClass]
	ld de, VTiles1
	farcall GetTrainerPic
	jr _Displaypic

Paintingpic::
	farcall LoadPaintingPalette
	call UpdateTimePals
	ld de, PaintingFrameGFX
	ld hl, VTiles0 tile ("┌" - 3)
	lb bc, BANK(PaintingFrameGFX), 9
	call Get2bpp
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call MenuBox
	hlcoord 9, 12
	ld a, "┌" - 3
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	call UpdateSprites
	call ApplyTilemap
	xor a
	ld [hBGMapMode], a
	ld a, [TrainerClass]
	ld de, VTiles1
	farcall GetPaintingPic
	jp _Displaypic

ClosePokepic:: ; 24528
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemCGBLayout
	xor a
	ld [hBGMapMode], a
	call OverworldTextModeSwitch
	call ApplyTilemap
	call UpdateSprites
	farjp LoadOverworldFont

PokepicMenuDataHeader: ; 0x24547
	db $40 ; flags
	db 04, 06 ; start coords
	db 12, 14 ; end coords
	dw NULL
	db 1 ; default option
