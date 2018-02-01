IceIsland_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 6 ; warps
	warp_def 29, 6, 2, SHAMOUTI_COAST
	warp_def 29, 20, 1, ICE_ISLAND_ROOF
	warp_def 5, 7, 4, ICE_ISLAND
	warp_def 5, 21, 3, ICE_ISLAND
	warp_def 26, 21, 6, ICE_ISLAND
	warp_def 26, 7, 5, ICE_ISLAND ; hole

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 6, 19, ICY_ROCK, 1, EVENT_ICE_ISLAND_ICY_ROCK

