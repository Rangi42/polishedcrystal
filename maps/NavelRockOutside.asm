NavelRockOutside_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 12, 25, SEAGALLOP_FERRY_NAVEL_GATE, 1
	warp_event 13, 25, SEAGALLOP_FERRY_NAVEL_GATE, 1
	warp_event 12, 15, NAVEL_ROCK_INSIDE, 1

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
