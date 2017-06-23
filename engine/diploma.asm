
_Diploma: ; 1dd702
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, VTiles2
	call Decompress
	ld hl, DiplomaTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .PlayerString
	hlcoord 2, 5
	call PlaceString
	ld de, PlayerName
	hlcoord 9, 5
	call PlaceString
	ld de, .DiplomaString
	hlcoord 2, 8
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	jp WaitPressAorB_BlinkCursor
; 1dd760

.PlayerString:
	db "Player@"

.DiplomaString:
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #dex."
	next "Congratulations!"
	db   "@"
; 1dd7ae

DiplomaGFX: ; 1dd805
INCBIN "gfx/misc/diploma.2bpp.lz"

DiplomaTilemap: ; 1ddc4b
INCBIN "gfx/misc/diploma.tilemap"
