WhirlIslandNE_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

WhirlIslandNE_MapEventHeader:
	db 3 ; warps
	warp_def 13, 3, 2, ROUTE_41
	warp_def 3, 17, 2, WHIRL_ISLAND_B1F
	warp_def 11, 13, 3, WHIRL_ISLAND_B1F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 11, 11, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_NE_ULTRA_BALL

