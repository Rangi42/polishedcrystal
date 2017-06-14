GBCOnlyScreen: ; 4ea82
	ld a, [hCGB]
	and a
	ret nz
	ld de, MUSIC_NONE
	call PlayMusic
	call ClearTileMap
	ld de, FontNormal
	ld hl, VTiles1
	lb bc, BANK(FontNormal), $80
	call Get1bpp
	ld de, GBCOnlyString
	hlcoord 1, 1
	call PlaceString
	call WaitBGMap
; better luck next time
.loop
	call DelayFrame
	jr .loop
; 4eac5

GBCOnlyString: ; 4eb38
	db   "      Pokémon"
	next " Polished Crystal"
	next "       ERROR"
	next "------------------"
	next "Please report this"
	next "crash to the deve-"
	next "loper, Rangi42, at"
	next "tinyurl.com/pkpc2.@"
; 4eb76
