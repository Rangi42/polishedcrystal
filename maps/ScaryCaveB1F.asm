ScaryCaveB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ScaryCaveB1F_MapEventHeader:

.Warps: db 2
	warp_def 19, 5, 3, SCARY_CAVE_1F
	warp_def 3, 19, 4, SCARY_CAVE_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	itemball_event 15, 2, BIG_NUGGET, 1, EVENT_SCARY_CAVE_B1F_BIG_NUGGET
	itemball_event 19, 21, BLACK_SLUDGE, 1, EVENT_SCARY_CAVE_B1F_BLACK_SLUDGE

