const_value set 2
	const SEAFOAMISLANDSB2F_POKE_BALL

SeafoamIslandsB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeafoamIslandsB2FWaterStone:
	itemball WATER_STONE

SeafoamIslandsB2FHiddenPearl1:
	dwb EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1, PEARL

SeafoamIslandsB2FHiddenPearl2:
	dwb EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2, PEARL

SeafoamIslandsB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $f, $19, 3, SEAFOAM_ISLANDS_B1F
	warp_def $7, $f, 4, SEAFOAM_ISLANDS_B1F
	warp_def $d, $d, 5, SEAFOAM_ISLANDS_B1F
	warp_def $f, $7, 6, SEAFOAM_ISLANDS_B1F
	warp_def $7, $23, 1, SEAFOAM_ISLANDS_B3F
	warp_def $9, $1c, 2, SEAFOAM_ISLANDS_B3F
	warp_def $f, $23, 3, SEAFOAM_ISLANDS_B3F
	warp_def $d, $4, 4, SEAFOAM_ISLANDS_B3F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 9, 7, SIGNPOST_ITEM, SeafoamIslandsB2FHiddenPearl1
	signpost 13, 35, SIGNPOST_ITEM, SeafoamIslandsB2FHiddenPearl2

.PersonEvents:
	db 1
	person_event SPRITE_POKE_BALL, 16, 15, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB2FWaterStone, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE
