Pokepic:: ; 244e3
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	ld a, [wIsCurMonInParty]
	and a
	jr nz, .partymon
	farcall LoadPokemonPalette
	ld a, 1
	ld [wMonVariant], a
	jr .got_palette
.partymon
	farcall LoadPartyMonPalette
	ld hl, wPartyMon1Form
	ld a, [wCurPartyMon]
	farcall GetPartyLocation
	farcall GetVariant
.got_palette
	call UpdateTimePals
	xor a
	ld [hBGMapMode], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld de, VTiles1
	predef GetFrontpic
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
	call LoadGrayscalePalette
	call UpdateTimePals
	xor a
	ld [hBGMapMode], a
	ld a, [wTrainerClass]
	ld de, VTiles1
	farcall GetTrainerPic
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

ClosePokepic:: ; 24528
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemSGBLayout
	xor a
	ld [hBGMapMode], a
	call OverworldTextModeSwitch
	call ApplyTilemap
	call UpdateSprites
	jp LoadStandardFont

PokepicMenuDataHeader: ; 0x24547
	db $40 ; flags
	db 04, 06 ; start coords
	db 13, 14 ; end coords
	dw NULL
	db 1 ; default option

LoadGrayscalePalette:
	ld a, $5
	ld de, wUnknBGPals palette 7 + 2
	ld hl, GrayscalePalette
	ld bc, 4
	jp FarCopyWRAM
; 49418

GrayscalePalette:
if !DEF(MONOCHROME)
	RGB 20, 20, 20
	RGB 10, 10, 10
else
	MONOCHROME_RGB_TWO
endc
