QuietCaveB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 21, 3, 6, QUIET_CAVE_B1F
	warp_event 17, 25, 7, QUIET_CAVE_B1F
	warp_event 23, 33, 8, QUIET_CAVE_B1F
	warp_event 29, 3, 9, QUIET_CAVE_B1F
	warp_event 10, 31, 1, QUIET_CAVE_B3F
	warp_event 33, 5, 2, QUIET_CAVE_B3F

	db 0 ; coord events

	db 1 ; bg events
	bg_event 16, 11, SIGNPOST_ITEM + CALCIUM, EVENT_QUIET_CAVE_B2F_HIDDEN_CALCIUM

	db 3 ; object events
	itemball_event 10, 3, DUSK_BALL, 1, EVENT_QUIET_CAVE_B2F_DUSK_BALL
	itemball_event 9, 23, RAZOR_CLAW, 1, EVENT_QUIET_CAVE_B2F_RAZOR_CLAW
	itemball_event 19, 11, SAFE_GOGGLES, 1, EVENT_QUIET_CAVE_B2F_SAFE_GOGGLES
