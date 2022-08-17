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
	table_width 2, LoadMapGroupRoof.Roofs
	dw NewBarkRoofGFX ; far-ok
	dw VioletRoofGFX ; far-ok
	dw AzaleaRoofGFX ; far-ok
	dw OlivineRoofGFX ; far-ok
	assert_table_length NUM_ROOFS

INCLUDE "data/maps/roofs.asm"
