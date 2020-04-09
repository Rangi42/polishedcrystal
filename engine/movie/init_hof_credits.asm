InitDisplayForHallOfFame:
	call ClearDisplayForEndgame
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
	ld hl, .SavingRecordDontTurnOff
	call PrintText
	jr FinishDisplayForEndgame

.SavingRecordDontTurnOff:
	; SAVING RECORD… DON'T TURN OFF!
	text_jump UnknownText_0x1bd39e
	text_end

InitDisplayForLeafCredits:
	call ClearDisplayForEndgame
	ld hl, wBGPals1
	ld c, 4 tiles
if !DEF(MONOCHROME)
	ld a, $ff ; RGB 31, 31, 31
endc
.load_white_palettes
if !DEF(MONOCHROME)
	ld [hli], a
	ld [hli], a
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
endc
	dec c
	jr nz, .load_white_palettes
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
FinishDisplayForEndgame:
	call ApplyAttrAndTilemapInVBlank
	jp SetPalettes

ClearDisplayForEndgame:
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
	ret

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
