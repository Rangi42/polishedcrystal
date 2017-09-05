SilverCaveRoom2_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCaveRoom2_MapEventHeader:

.Warps: db 4
	warp_def 31, 17, 2, SILVER_CAVE_ROOM_1
	warp_def 5, 11, 1, SILVER_CAVE_ROOM_3
	warp_def 21, 13, 1, SILVER_CAVE_ITEM_ROOMS
	warp_def 3, 23, 2, SILVER_CAVE_ITEM_ROOMS

.XYTriggers: db 0

.Signposts: db 1
	signpost 31, 14, SIGNPOST_ITEM + MAX_POTION, EVENT_SILVER_CAVE_ROOM_2_HIDDEN_MAX_POTION

.PersonEvents: db 3
	itemball_event 10, 24, CALCIUM, 1, EVENT_SILVER_CAVE_ROOM_2_CALCIUM
	itemball_event 24, 22, ULTRA_BALL, 1, EVENT_SILVER_CAVE_ROOM_2_ULTRA_BALL
	itemball_event 20, 4, PP_UP, 1, EVENT_SILVER_CAVE_ROOM_2_PP_UP
