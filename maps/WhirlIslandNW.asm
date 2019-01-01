WhirlIslandNW_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  5, 33, ROUTE_41, 1
	warp_event  5, 29, WHIRL_ISLAND_B1F, 1
	warp_event 15, 31, WHIRL_ISLAND_SW, 4
	warp_event 19, 31, WHIRL_ISLAND_CAVE, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
