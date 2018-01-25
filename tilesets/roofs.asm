LoadMapGroupRoof:: ; 1c000
	ld a, [MapGroup]
	ld e, a
	ld d, 0
	ld hl, MapGroupRoofs
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .extra_tiles
	ld hl, Roofs
	ld bc, 9 tiles
	call AddNTimes
	ld de, VTiles2 tile $0a
	ld bc, 9 tiles
	call CopyBytes

.extra_tiles
; Load puddle tiles for Stormy Beach on top of the unused Mart roof tiles
	ld a, [wTileset]
	cp TILESET_JOHTO_MODERN
	ret nz
	ld a, [MapGroup]
	cp GROUP_STORMY_BEACH
	ret nz
	ld a, [rVBK]
	push af
	ld a, $1
	ld [rVBK], a
	ld hl, StormyBeachPuddleGFX
	ld de, VTiles4 tile $c6
	ld bc, 6 tiles
	call CopyBytes
	ld hl, StormyBeachPuddleGFX + 6 tiles
	ld de, VTiles4 tile $d6
	ld bc, 6 tiles
	call CopyBytes
	pop af
	ld [rVBK], a
	ret
; 1c021

INCLUDE "data/maps/roofs.asm"

StormyBeachPuddleGFX:
INCBIN "gfx/tilesets/roofs/puddle.2bpp"
