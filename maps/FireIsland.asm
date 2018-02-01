FireIsland_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 14 ; warps
	warp_def 29, 5, 1, SHAMOUTI_COAST
	warp_def 29, 19, 1, FIRE_ISLAND_ROOF
	warp_def 5, 7, 4, FIRE_ISLAND
	warp_def 5, 21, 3, FIRE_ISLAND
	warp_def 9, 7, 6, FIRE_ISLAND
	warp_def 9, 21, 5, FIRE_ISLAND
	warp_def 16, 2, 8, FIRE_ISLAND
	warp_def 16, 16, 7, FIRE_ISLAND
	warp_def 19, 9, 10, FIRE_ISLAND
	warp_def 19, 23, 9, FIRE_ISLAND
	warp_def 23, 3, 12, FIRE_ISLAND
	warp_def 23, 17, 11, FIRE_ISLAND
	warp_def 27, 20, 14, FIRE_ISLAND
	warp_def 27, 6, 13, FIRE_ISLAND ; hole

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 19, 2, HEAT_ROCK, 1, EVENT_FIRE_ISLAND_HEAT_ROCK

