TinTower3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower3F_MapEventHeader:

.Warps: db 2
	warp_def 14, 8, 1, TIN_TOWER_2F
	warp_def 2, 14, 2, TIN_TOWER_4F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 14, 1, FULL_HEAL, 1, EVENT_TIN_TOWER_3F_FULL_HEAL

