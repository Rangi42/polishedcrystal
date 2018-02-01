TinTower7F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 5 ; warps
	warp_def 9, 1, 1, TIN_TOWER_6F
	warp_def 15, 8, 1, TIN_TOWER_8F
	warp_def 7, 10, 4, TIN_TOWER_7F
	warp_def 3, 6, 3, TIN_TOWER_7F
	warp_def 9, 4, 5, TIN_TOWER_9F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 1, 14, MAX_REVIVE, 1, EVENT_TIN_TOWER_7F_MAX_REVIVE

