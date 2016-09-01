
_Diploma: ; 1dd702
	call Function1dd709
	call WaitPressAorB_BlinkCursor
	ret
; 1dd709

Function1dd709: ; 1dd709
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, LZ_1dd805
	ld de, VTiles2
	call Decompress
	ld hl, Tilemap_1ddc4b
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, String_1dd760
	hlcoord 2, 5
	call PlaceString
	ld de, String_1dd767
	hlcoord 15, 5
	call PlaceString
	ld de, PlayerName
	hlcoord 9, 5
	call PlaceString
	ld de, String_1dd768
	hlcoord 2, 8
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_08
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	ret
; 1dd760

String_1dd760:
	db "Player@"

String_1dd767:
	db "@"

String_1dd768:
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #dex."
	next "Congratulations!"
	db   "@"
; 1dd7ae

LZ_1dd805: ; 1dd805
INCBIN "gfx/unknown/1dd805.2bpp.lz"

Tilemap_1ddc4b: ; 1ddc4b
INCBIN "gfx/unknown/1ddc4b.tilemap"
