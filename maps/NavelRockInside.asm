NavelRockInside_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 14 ; warp events
	warp_event 7, 81, 3, NAVEL_ROCK_OUTSIDE
	warp_event 8, 64, 3, NAVEL_ROCK_INSIDE
	warp_event 3, 3, 2, NAVEL_ROCK_INSIDE
	warp_event 9, 5, 5, NAVEL_ROCK_INSIDE
	warp_event 23, 85, 4, NAVEL_ROCK_INSIDE
	warp_event 23, 3, 7, NAVEL_ROCK_INSIDE
	warp_event 5, 45, 6, NAVEL_ROCK_INSIDE
	warp_event 2, 42, 9, NAVEL_ROCK_INSIDE
	warp_event 2, 32, 8, NAVEL_ROCK_INSIDE
	warp_event 5, 35, 11, NAVEL_ROCK_INSIDE
	warp_event 5, 25, 10, NAVEL_ROCK_INSIDE
	warp_event 2, 22, 13, NAVEL_ROCK_INSIDE
	warp_event 2, 12, 12, NAVEL_ROCK_INSIDE
	warp_event 5, 15, 1, NAVEL_ROCK_ROOF

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	itemball_event 12, 12, SACRED_ASH, 1, EVENT_NAVEL_ROCK_SACRED_ASH
	itemball_event 37, 12, MASTER_BALL, 1, EVENT_NAVEL_ROCK_MASTER_BALL

