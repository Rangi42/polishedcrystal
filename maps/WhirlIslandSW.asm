WhirlIslandSW_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 5, 7, 3, ROUTE_41
	warp_event 17, 3, 5, WHIRL_ISLAND_B1F
	warp_event 3, 3, 4, WHIRL_ISLAND_B1F
	warp_event 3, 15, 3, WHIRL_ISLAND_NW
	warp_event 17, 15, 4, WHIRL_ISLAND_B2F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 15, 2, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_SW_ULTRA_BALL

