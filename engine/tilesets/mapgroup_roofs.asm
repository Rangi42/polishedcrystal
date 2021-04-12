LoadMapGroupRoof::
	ld a, [wMapGroup]
	ld e, a
	ld d, 0
	ld hl, MapGroupRoofs
	add hl, de
	ld a, [hl]
	cp -1
	ret z
	ld l, a
	ld h, 0
	add hl, hl
	ld bc, .Roofs
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $0a
	lb bc, BANK("Roof Graphics"), 9
	jmp DecompressRequest2bpp

.Roofs:
	dw Roof0GFX ; far-ok
	dw Roof1GFX ; far-ok
	dw Roof2GFX ; far-ok
	dw Roof3GFX ; far-ok

INCLUDE "data/maps/roofs.asm"
