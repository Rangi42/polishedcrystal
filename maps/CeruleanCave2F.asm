CeruleanCave2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeruleanCave2F_MapEventHeader:
	db 6 ; warps
	warp_def 3, 11, 2, CERULEAN_CAVE_1F
	warp_def 3, 31, 3, CERULEAN_CAVE_1F
	warp_def 5, 3, 4, CERULEAN_CAVE_1F
	warp_def 8, 24, 6, CERULEAN_CAVE_1F
	warp_def 9, 21, 7, CERULEAN_CAVE_1F
	warp_def 13, 5, 8, CERULEAN_CAVE_1F

	db 0 ; xy triggers

	db 3 ; signposts
	signpost 19, 17, SIGNPOST_ITEM + PROTEIN, EVENT_CERULEAN_CAVE_2F_HIDDEN_PROTEIN
	signpost 4, 16, SIGNPOST_ITEM + NUGGET, EVENT_CERULEAN_CAVE_2F_HIDDEN_NUGGET
	signpost 17, 13, SIGNPOST_ITEM + HYPER_POTION, EVENT_CERULEAN_CAVE_2F_HIDDEN_HYPER_POTION

	db 4 ; person events
	itemball_event 11, 31, FULL_RESTORE, 1, EVENT_CERULEAN_CAVE_2F_FULL_RESTORE
	itemball_event 17, 7, PP_UP, 1, EVENT_CERULEAN_CAVE_2F_PP_UP
	itemball_event 15, 27, ULTRA_BALL, 1, EVENT_CERULEAN_CAVE_2F_ULTRA_BALL
	itemball_event 7, 2, DUSK_STONE, 1, EVENT_CERULEAN_CAVE_2F_DUSK_STONE
