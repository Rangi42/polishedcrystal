TinTower9F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower9F_MapEventHeader:

.Warps: db 7
	warp_def 3, 10, 2, TIN_TOWER_8F
	warp_def 5, 0, 3, TIN_TOWER_8F
	warp_def 7, 10, 4, TIN_TOWER_8F
	warp_def 9, 5, 1, TIN_TOWER_10F
	warp_def 7, 14, 5, TIN_TOWER_7F
	warp_def 13, 4, 5, TIN_TOWER_8F
	warp_def 13, 6, 6, TIN_TOWER_8F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 1, 7, HP_UP, 1, EVENT_TIN_TOWER_9F_HP_UP

