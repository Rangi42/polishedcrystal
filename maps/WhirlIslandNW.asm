WhirlIslandNW_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 5, 33, 1, ROUTE_41
	warp_event 5, 29, 1, WHIRL_ISLAND_B1F
	warp_event 15, 31, 4, WHIRL_ISLAND_SW
	warp_event 19, 31, 2, WHIRL_ISLAND_CAVE

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
