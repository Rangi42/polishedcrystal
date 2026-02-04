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
	ld bc, MapGroupRoofGFX
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $0a
	lb bc, BANK("Roof Graphics"), 9
	jmp DecompressRequest2bpp

MapGroupRoofGFX:
	table_width 2
	farbank "Roof Graphics"
	fardw NewBarkRoofGFX
	fardw VioletRoofGFX
	fardw AzaleaRoofGFX
	fardw OlivineRoofGFX
	fardw GoldenrodRoofGFX
	assert_table_length NUM_ROOFS

INCLUDE "data/maps/roofs.asm"
