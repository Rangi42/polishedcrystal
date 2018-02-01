IceIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 6, 29, 2, SHAMOUTI_COAST
	warp_event 20, 29, 1, ICE_ISLAND_ROOF
	warp_event 7, 5, 4, ICE_ISLAND
	warp_event 21, 5, 3, ICE_ISLAND
	warp_event 21, 26, 6, ICE_ISLAND
	warp_event 7, 26, 5, ICE_ISLAND ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 19, 6, ICY_ROCK, 1, EVENT_ICE_ISLAND_ICY_ROCK

