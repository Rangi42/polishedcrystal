ScaryCaveB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  5, 19, SCARY_CAVE_1F, 3
	warp_event 19,  3, SCARY_CAVE_1F, 4

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	itemball_event  2, 15, BIG_NUGGET, 1, EVENT_SCARY_CAVE_B1F_BIG_NUGGET
	itemball_event 21, 19, BLACK_SLUDGE, 1, EVENT_SCARY_CAVE_B1F_BLACK_SLUDGE

