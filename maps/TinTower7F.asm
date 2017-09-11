TinTower7F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower7F_MapEventHeader:

.Warps: db 5
	warp_def 9, 1, 1, TIN_TOWER_6F
	warp_def 15, 8, 1, TIN_TOWER_8F
	warp_def 7, 10, 4, TIN_TOWER_7F
	warp_def 3, 6, 3, TIN_TOWER_7F
	warp_def 9, 4, 5, TIN_TOWER_9F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 1, 14, MAX_REVIVE, 1, EVENT_TIN_TOWER_7F_MAX_REVIVE

