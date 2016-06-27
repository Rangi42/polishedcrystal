const_value set 2
	const QUIETCAVE1F_POKE_BALL1
	const QUIETCAVE1F_POKE_BALL2
	const QUIETCAVE1F_POKE_BALL3
	const QUIETCAVE1F_POKE_BALL4

QuietCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

QuietCave1FNugget:
	itemball NUGGET

QuietCave1FTwistedSpoon:
	itemball TWISTEDSPOON

QuietCave1FDuskStone:
	itemball DUSK_STONE

QuietCave1FDuskBall:
	itemball DUSK_BALL

QuietCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $21, $13, 5, ROUTE_47
	warp_def $19, $5, 1, QUIET_CAVE_B1F
	warp_def $17, $1b, 2, QUIET_CAVE_B1F
	warp_def $9, $15, 3, QUIET_CAVE_B1F
	warp_def $11, $3, 4, QUIET_CAVE_B1F
	warp_def $d, $1f, 5, QUIET_CAVE_B1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_POKE_BALL, 23, 10, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCave1FNugget, EVENT_QUIET_CAVE_1F_NUGGET
	person_event SPRITE_POKE_BALL, 4, 26, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCave1FTwistedSpoon, EVENT_QUIET_CAVE_1F_TWISTEDSPOON
	person_event SPRITE_POKE_BALL, 2, 14, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCave1FDuskStone, EVENT_QUIET_CAVE_1F_DUSK_STONE
	person_event SPRITE_POKE_BALL, 3, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, QuietCave1FDuskBall, EVENT_QUIET_CAVE_1F_DUSK_BALL
