SilverCaveItemRooms_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 21, 33, SILVER_CAVE_ROOM_2, 3
	warp_event  5, 27, SILVER_CAVE_ROOM_2, 4

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	itemball_event 14, 33, MAX_REVIVE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	itemball_event 13, 23, FULL_RESTORE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE

