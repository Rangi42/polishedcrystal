SeafoamIslands1F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, SeafoamIslands1FClearRocks

	db 5 ; warp events
	warp_event 15, 33, 1, ROUTE_20
	warp_event 15, 31, 1, SEAFOAM_GYM
	warp_event 12, 28, 1, SEAFOAM_ISLANDS_B1F
	warp_event 5, 5, 2, ROUTE_20
	warp_event 5, 3, 2, SEAFOAM_ISLANDS_B1F

	db 0 ; coord events

	db 1 ; bg events
	bg_event 17, 29, SIGNPOST_ITEM + ESCAPE_ROPE, EVENT_SEAFOAM_ISLANDS_1F_HIDDEN_ESCAPE_ROPE

	db 0 ; object events

SeafoamIslands1FClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	return
