SilverCaveItemRooms_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCaveItemRooms_MapEventHeader:

.Warps: db 2
	warp_def $21, $15, 3, SILVER_CAVE_ROOM_2
	warp_def $1b, $5, 4, SILVER_CAVE_ROOM_2

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_BALL_CUT_FRUIT, 33, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, MAX_REVIVE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	person_event SPRITE_BALL_CUT_FRUIT, 23, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, FULL_RESTORE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE

