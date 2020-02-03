LoadMapGroupRoof::
	ld a, [wMapGroup]
	ld e, a
	ld d, 0
	ld hl, MapGroupRoofs
	add hl, de
	ld a, [hl]
	cp -1
	ret z
	ld hl, Roofs
	ld bc, 9 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	lb bc, BANK(Roofs), 9
	ld hl, VTiles2 tile $0a
	jp Get2bpp

INCLUDE "data/maps/roofs.asm"
