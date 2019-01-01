IceIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event  6, 29, SHAMOUTI_COAST, 2
	warp_event 20, 29, ICE_ISLAND_ROOF, 1
	warp_event  7,  5, ICE_ISLAND, 4
	warp_event 21,  5, ICE_ISLAND, 3
	warp_event 21, 26, ICE_ISLAND, 6
	warp_event  7, 26, ICE_ISLAND, 5 ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 19,  6, ICY_ROCK, 1, EVENT_ICE_ISLAND_ICY_ROCK

