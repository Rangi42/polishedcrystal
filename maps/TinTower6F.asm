TinTower6F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower6F_MapEventHeader:
	db 2 ; warps
	warp_def 9, 1, 1, TIN_TOWER_7F
	warp_def 15, 9, 1, TIN_TOWER_5F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 8, 6, MAX_POTION, 1, EVENT_TIN_TOWER_6F_MAX_POTION

