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
	text_far _SavingRecordText
	text_end

InitDisplayForLeafCredits:
	call ClearDisplayForEndgame
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	call EnableLCD
FinishDisplayForEndgame:
	call ApplyAttrAndTilemapInVBlank
	jmp SetDefaultBGPAndOBP

ClearDisplayForEndgame:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, ' '
	rst ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	rst ByteFill
	ret

ResetDisplayBetweenHallOfFameMons:
	ldh a, [rWBK]
	push af
	ld a, $6
	ldh [rWBK], a
	ld hl, wScratchTileMap
	ld bc, TILEMAP_AREA
	ld a, ' '
	rst ByteFill
	hlbgcoord 0, 0
	ld de, wScratchTileMap
	lb bc, $0, $40
	call Request2bpp
	pop af
	ldh [rWBK], a
	ret
