TinTower10F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TinTower10F_MapEventHeader:
	db 2 ; warps
	warp_def 9, 5, 4, TIN_TOWER_9F
	warp_def 15, 7, 1, TIN_TOWER_ROOF

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
