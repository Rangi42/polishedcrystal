InitDisplayForHallOfFame:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, " "
	rst ByteFill
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	rst ByteFill
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
	ld hl, .SavingRecordDontTurnOff
	call PrintText
	call ApplyAttrAndTilemapInVBlank
	jp SetPalettes

.SavingRecordDontTurnOff:
	; SAVING RECORD… DON'T TURN OFF!
	text_jump UnknownText_0x1bd39e
	db "@"

InitDisplayForLeafCredits:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, " "
	rst ByteFill
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	rst ByteFill
	ld hl, wUnknBGPals
	ld c, 4 tiles
.load_white_palettes
if !DEF(MONOCHROME)
	ld a, (palred 31 + palgreen 31 + palblue 31) % $100
	ld [hli], a
	ld a, (palred 31 + palgreen 31 + palblue 31) / $100
	ld [hli], a
else
	ld a, PAL_MONOCHROME_WHITE % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_WHITE / $100
	ld [hli], a
endc
	dec c
	jr nz, .load_white_palettes
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
	call ApplyAttrAndTilemapInVBlank
	jp SetPalettes

ResetDisplayBetweenHallOfFameMons:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	ld hl, wScratchTileMap
	ld bc, BG_MAP_WIDTH * BG_MAP_HEIGHT
	ld a, " "
	rst ByteFill
	hlbgcoord 0, 0
	ld de, wScratchTileMap
	lb bc, $0, $40
	call Request2bpp
	pop af
	ldh [rSVBK], a
	ret
