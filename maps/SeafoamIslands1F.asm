SeafoamIslands1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, SeafoamIslands1FClearRocks

SeafoamIslands1F_MapEventHeader:

.Warps: db 5
	warp_def 33, 15, 1, ROUTE_20
	warp_def 31, 15, 1, SEAFOAM_GYM
	warp_def 28, 12, 1, SEAFOAM_ISLANDS_B1F
	warp_def 5, 5, 2, ROUTE_20
	warp_def 3, 5, 2, SEAFOAM_ISLANDS_B1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 29, 17, SIGNPOST_ITEM + ESCAPE_ROPE, EVENT_SEAFOAM_ISLANDS_1F_HIDDEN_ESCAPE_ROPE

.PersonEvents: db 0

SeafoamIslands1FClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	return
