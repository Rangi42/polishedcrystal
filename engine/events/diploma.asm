_Diploma:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst CopyBytes
	ld de, .PlayerString
	hlcoord 2, 5
	rst PlaceString
	ld de, wPlayerName
	hlcoord 9, 5
	rst PlaceString
	ld de, .DiplomaString
	hlcoord 2, 8
	rst PlaceString
	call EnableLCD
	call ApplyTilemapInVBlank
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	call WaitPressAorB_BlinkCursor

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $7f
	rst ByteFill
	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst CopyBytes
	ld de, .PolishedCrystal
	hlcoord 2, 1
	rst PlaceString
	ld de, .PlayTime
	hlcoord 3, 15
	rst PlaceString
	hlcoord 12, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	ld a, ":"
	ld [hli], a
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	jmp WaitPressAorB_BlinkCursor

.PlayerString:
	db "Player@"

.DiplomaString:
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #dex."
	next "Congratulations!@"

.PlayTime:
	db "Play Time@"

.PolishedCrystal:
	db "Polished Crystal@"

DiplomaGFX:
INCBIN "gfx/diploma/diploma.2bpp.lz"

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap"
