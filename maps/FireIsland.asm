FireIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 14 ; warp events
	warp_event 5, 29, 1, SHAMOUTI_COAST
	warp_event 19, 29, 1, FIRE_ISLAND_ROOF
	warp_event 7, 5, 4, FIRE_ISLAND
	warp_event 21, 5, 3, FIRE_ISLAND
	warp_event 7, 9, 6, FIRE_ISLAND
	warp_event 21, 9, 5, FIRE_ISLAND
	warp_event 2, 16, 8, FIRE_ISLAND
	warp_event 16, 16, 7, FIRE_ISLAND
	warp_event 9, 19, 10, FIRE_ISLAND
	warp_event 23, 19, 9, FIRE_ISLAND
	warp_event 3, 23, 12, FIRE_ISLAND
	warp_event 17, 23, 11, FIRE_ISLAND
	warp_event 20, 27, 14, FIRE_ISLAND
	warp_event 6, 27, 13, FIRE_ISLAND ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 2, 19, HEAT_ROCK, 1, EVENT_FIRE_ISLAND_HEAT_ROCK

