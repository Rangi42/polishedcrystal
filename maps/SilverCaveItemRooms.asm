SilverCaveItemRooms_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 33, 21, 3, SILVER_CAVE_ROOM_2
	warp_def 27, 5, 4, SILVER_CAVE_ROOM_2

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	itemball_event 33, 14, MAX_REVIVE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	itemball_event 23, 13, FULL_RESTORE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE

