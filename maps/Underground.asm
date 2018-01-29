Underground_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Underground_MapEventHeader:
	db 2 ; warps
	warp_def 2, 3, 3, ROUTE_5_UNDERGROUND_ENTRANCE
	warp_def 32, 3, 3, ROUTE_6_UNDERGROUND_ENTRANCE

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 9, 3, SIGNPOST_ITEM + FULL_RESTORE, EVENT_UNDERGROUND_HIDDEN_FULL_RESTORE
	signpost 21, 1, SIGNPOST_ITEM + X_SPCL_ATK, EVENT_UNDERGROUND_HIDDEN_X_SPCL_ATK

	db 1 ; person events
	tmhmball_event 15, 4, TM_EXPLOSION, EVENT_UNDERGROUND_TM_EXPLOSION
