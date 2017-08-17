CeruleanCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCave1F_MapEventHeader:

.Warps: db 8
	warp_def 19, 27, 7, CERULEAN_CITY
	warp_def 3, 9, 1, CERULEAN_CAVE_2F
	warp_def 3, 29, 2, CERULEAN_CAVE_2F
	warp_def 5, 3, 3, CERULEAN_CAVE_2F
	warp_def 8, 2, 1, CERULEAN_CAVE_B1F
	warp_def 9, 25, 4, CERULEAN_CAVE_2F
	warp_def 11, 20, 5, CERULEAN_CAVE_2F
	warp_def 13, 5, 6, CERULEAN_CAVE_2F

.XYTriggers: db 0

.Signposts: db 3
	signpost 11, 10, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CERULEAN_CAVE_1F_HIDDEN_ULTRA_BALL
	signpost 14, 5, SIGNPOST_ITEM + PP_UP, EVENT_CERULEAN_CAVE_1F_HIDDEN_PP_UP
	signpost 13, 16, SIGNPOST_ITEM + RARE_CANDY, EVENT_CERULEAN_CAVE_1F_HIDDEN_RARE_CANDY

.PersonEvents: db 3
	itemball_event 4, 7, BIG_NUGGET, 1, EVENT_CERULEAN_CAVE_1F_BIG_NUGGET
	itemball_event 15, 9, FULL_RESTORE, 1, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE
	itemball_event 5, 21, MAX_REVIVE, 1, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE
