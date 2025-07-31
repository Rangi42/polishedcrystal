_Diploma:
	call PlaceDiplomaPage1OnScreen
	call WaitPressAorB_BlinkCursor
	call PlaceDiplomaPage2OnScreen
	jmp WaitPressAorB_BlinkCursor

PlaceDiplomaPage1OnScreen:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	call Decompress
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
	ld a, CGB_NEW_DIPLOMA
	call GetCGBLayout
	call SetDefaultBGPAndOBP
	jmp DelayFrame

.PlayerString:
	text "Player"
	done

.DiplomaString:
	text "This certifies"
	next "that you have"
	next "completed the"
	next "National #dex."
	next "Congratulations!"
	done

PlaceDiplomaPage2OnScreen:
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, $7f
	rst ByteFill

	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	call Decompress
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
	ld a, ':'
	ld [hli], a
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

.PlayTime:
	text "Play Time"
	done

.PolishedCrystal:
	text "Polished Crystal"
	done

DiplomaGFX:
INCBIN "gfx/diploma/diploma.2bpp.lz"

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap.lz"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap.lz"
