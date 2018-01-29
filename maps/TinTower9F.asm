TinTower9F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower9F_MapEventHeader:
	db 7 ; warps
	warp_def 3, 10, 2, TIN_TOWER_8F
	warp_def 5, 0, 3, TIN_TOWER_8F
	warp_def 7, 10, 4, TIN_TOWER_8F
	warp_def 9, 5, 1, TIN_TOWER_10F
	warp_def 7, 14, 5, TIN_TOWER_7F
	warp_def 13, 4, 5, TIN_TOWER_8F
	warp_def 13, 6, 6, TIN_TOWER_8F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 1, 7, HP_UP, 1, EVENT_TIN_TOWER_9F_HP_UP

