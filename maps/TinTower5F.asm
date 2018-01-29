TinTower5F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower5F_MapEventHeader:
	db 4 ; warps
	warp_def 15, 9, 2, TIN_TOWER_6F
	warp_def 4, 0, 1, TIN_TOWER_4F
	warp_def 14, 0, 3, TIN_TOWER_4F
	warp_def 15, 15, 4, TIN_TOWER_4F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 14, 14, SIGNPOST_ITEM + FULL_RESTORE, EVENT_TIN_TOWER_5F_HIDDEN_FULL_RESTORE
	signpost 15, 1, SIGNPOST_ITEM + CARBOS, EVENT_TIN_TOWER_5F_HIDDEN_CARBOS

	db 1 ; person events
	itemball_event 9, 7, RARE_CANDY, 1, EVENT_TIN_TOWER_5F_RARE_CANDY
