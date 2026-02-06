; Some maps have object_events whose facings use two palettes via the NEXT_PALETTE constant.
; These facings assume that the second palette exists right after the first in VRAM.

MACRO dual_obj_pal
	map_id \1
	db PAL_OW_\2, PAL_OW_\3
ENDM

DualObjectPalettes:
	dual_obj_pal TIN_TOWER_ROOF, RED, GREEN ; for SPRITE_BIG_HO_OH
	dual_obj_pal WHIRL_ISLAND_LUGIA_CHAMBER, WHITE, BLUE ; for SPRITE_BIG_LUGIA
	dual_obj_pal SHAMOUTI_ISLAND, GREEN, BROWN ; for SPRITE_ALOLAN_EXEGGUTOR
	db -1 ; end
