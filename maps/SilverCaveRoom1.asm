SilverCaveRoom1_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCaveRoom1_MapEventHeader:

.Warps: db 2
	warp_def 33, 9, 2, SILVER_CAVE_OUTSIDE
	warp_def 1, 15, 1, SILVER_CAVE_ROOM_2

.XYTriggers: db 0

.Signposts: db 2
	signpost 23, 16, SIGNPOST_ITEM + DIRE_HIT, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT
	signpost 12, 17, SIGNPOST_ITEM + ULTRA_BALL, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL

.PersonEvents: db 4
	itemball_event 9, 4, MAX_ELIXER, 1, EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXER
	itemball_event 29, 15, PROTEIN, 1, EVENT_SILVER_CAVE_ROOM_1_PROTEIN
	itemball_event 30, 5, ESCAPE_ROPE, 1, EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE
	itemball_event 18, 7, ULTRA_BALL, 1, EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL
