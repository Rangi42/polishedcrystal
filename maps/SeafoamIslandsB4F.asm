const_value set 2
	const SEAFOAMISLANDSB4F_POKE_BALL1
	const SEAFOAMISLANDSB4F_POKE_BALL2
	const SEAFOAMISLANDSB4F_ARTICUNO

SeafoamIslandsB4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeafoamIslandsB4FNeverMeltIce:
	itemball NEVERMELTICE

SeafoamIslandsB4FUltraBall:
	itemball ULTRA_BALL

SeafoamIslandsB4F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $?, $?, 5, SEAFOAM_ISLANDS_B3F
	warp_def $?, $?, 6, SEAFOAM_ISLANDS_B3F
	warp_def $?, $?, 7, SEAFOAM_ISLANDS_B3F
	warp_def $?, $?, 8, SEAFOAM_ISLANDS_B3F
	warp_def $?, $?, 9, SEAFOAM_ISLANDS_B3F
	warp_def $?, $?, 10, SEAFOAM_ISLANDS_B3F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_POKE_BALL, ?, ?, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB4FNeverMeltIce, EVENT_SEAFOAM_ISLANDS_B4F_NEVERMELTICE
	person_event SPRITE_POKE_BALL, ?, ?, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB4FUltraBall, EVENT_SEAFOAM_ISLANDS_B4F_ULTRA_BALL
	person_event SPRITE_ARTICUNO, ?, ?, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SeafoamIslandsArticuno, EVENT_SEAFOAM_ISLANDS_ARTICUNO
