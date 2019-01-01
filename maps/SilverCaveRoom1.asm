SilverCaveRoom1_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  9, 33, SILVER_CAVE_OUTSIDE, 2
	warp_event 15,  1, SILVER_CAVE_ROOM_2, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event 16, 23, SIGNPOST_ITEM + DIRE_HIT, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT
	bg_event 17, 12, SIGNPOST_ITEM + ULTRA_BALL, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL

	db 4 ; object events
	itemball_event  4,  9, MAX_ELIXER, 1, EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXER
	itemball_event 15, 29, PROTEIN, 1, EVENT_SILVER_CAVE_ROOM_1_PROTEIN
	itemball_event  5, 30, ESCAPE_ROPE, 1, EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE
	itemball_event  7, 18, ULTRA_BALL, 1, EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL
