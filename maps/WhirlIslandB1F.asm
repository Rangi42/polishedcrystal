WhirlIslandB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 9 ; warp events
	warp_event 5, 5, 2, WHIRL_ISLAND_NW
	warp_event 35, 3, 2, WHIRL_ISLAND_NE
	warp_event 29, 9, 3, WHIRL_ISLAND_NE
	warp_event 9, 31, 3, WHIRL_ISLAND_SW
	warp_event 23, 31, 2, WHIRL_ISLAND_SW
	warp_event 31, 29, 2, WHIRL_ISLAND_SE
	warp_event 25, 21, 1, WHIRL_ISLAND_B2F
	warp_event 13, 27, 2, WHIRL_ISLAND_B2F
	warp_event 17, 21, 1, WHIRL_ISLAND_CAVE

	db 0 ; coord events

	db 3 ; bg events
	bg_event 30, 4, SIGNPOST_ITEM + RARE_CANDY, EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY
	bg_event 36, 18, SIGNPOST_ITEM + ULTRA_BALL, EVENT_WHIRL_ISLAND_B1F_HIDDEN_ULTRA_BALL
	bg_event 2, 23, SIGNPOST_ITEM + FULL_RESTORE, EVENT_WHIRL_ISLAND_B1F_HIDDEN_FULL_RESTORE

	db 6 ; object events
	itemball_event 7, 13, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B1F_FULL_RESTORE
	itemball_event 2, 18, CARBOS, 1, EVENT_WHIRL_ISLAND_B1F_CARBOS
	itemball_event 33, 23, CALCIUM, 1, EVENT_WHIRL_ISLAND_B1F_CALCIUM
	itemball_event 17, 8, BIG_NUGGET, 1, EVENT_WHIRL_ISLAND_B1F_BIG_NUGGET
	itemball_event 19, 26, ESCAPE_ROPE, 1, EVENT_WHIRL_ISLAND_B1F_ESCAPE_ROPE
	strengthboulder_event 23, 26
