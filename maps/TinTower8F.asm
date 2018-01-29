TinTower8F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower8F_MapEventHeader:
	db 6 ; warps
	warp_def 5, 0, 2, TIN_TOWER_7F
	warp_def 11, 0, 1, TIN_TOWER_9F
	warp_def 7, 14, 2, TIN_TOWER_9F
	warp_def 3, 8, 3, TIN_TOWER_9F
	warp_def 15, 12, 6, TIN_TOWER_9F
	warp_def 9, 4, 7, TIN_TOWER_9F

	db 0 ; xy triggers

	db 0 ; signposts

	db 3 ; person events
	itemball_event 13, 5, BIG_NUGGET, 1, EVENT_TIN_TOWER_8F_BIG_NUGGET
	itemball_event 6, 9, MAX_ELIXER, 1, EVENT_TIN_TOWER_8F_MAX_ELIXER
	itemball_event 1, 1, FULL_RESTORE, 1, EVENT_TIN_TOWER_8F_FULL_RESTORE

