WhirlIslandNE_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 3, 13, 2, ROUTE_41
	warp_event 17, 3, 2, WHIRL_ISLAND_B1F
	warp_event 13, 11, 3, WHIRL_ISLAND_B1F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 11, 11, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_NE_ULTRA_BALL

