TinTower3F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower3F_MapEventHeader:
	db 2 ; warps
	warp_def 14, 8, 1, TIN_TOWER_2F
	warp_def 2, 14, 2, TIN_TOWER_4F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 14, 1, FULL_HEAL, 1, EVENT_TIN_TOWER_3F_FULL_HEAL

