TinTower6F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower6F_MapEventHeader:

.Warps: db 2
	warp_def 9, 1, 1, TIN_TOWER_7F
	warp_def 15, 9, 1, TIN_TOWER_5F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 8, 6, MAX_POTION, 1, EVENT_TIN_TOWER_6F_MAX_POTION

