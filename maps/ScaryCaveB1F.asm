ScaryCaveB1F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ScaryCaveB1F_MapEventHeader:
	db 2 ; warps
	warp_def 19, 5, 3, SCARY_CAVE_1F
	warp_def 3, 19, 4, SCARY_CAVE_1F

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	itemball_event 15, 2, BIG_NUGGET, 1, EVENT_SCARY_CAVE_B1F_BIG_NUGGET
	itemball_event 19, 21, BLACK_SLUDGE, 1, EVENT_SCARY_CAVE_B1F_BLACK_SLUDGE

