SilverCaveItemRooms_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCaveItemRooms_MapEventHeader:

.Warps: db 2
	warp_def 33, 21, 3, SILVER_CAVE_ROOM_2
	warp_def 27, 5, 4, SILVER_CAVE_ROOM_2

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	itemball_event 33, 14, MAX_REVIVE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	itemball_event 23, 13, FULL_RESTORE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE

