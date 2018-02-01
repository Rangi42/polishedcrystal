WhirlIslandSW_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 5 ; warps
	warp_def 7, 5, 3, ROUTE_41
	warp_def 3, 17, 5, WHIRL_ISLAND_B1F
	warp_def 3, 3, 4, WHIRL_ISLAND_B1F
	warp_def 15, 3, 3, WHIRL_ISLAND_NW
	warp_def 15, 17, 4, WHIRL_ISLAND_B2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 2, 15, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_SW_ULTRA_BALL

