TinTower8F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower8F_MapEventHeader:

.Warps: db 6
	warp_def 5, 0, 2, TIN_TOWER_7F
	warp_def 11, 0, 1, TIN_TOWER_9F
	warp_def 7, 14, 2, TIN_TOWER_9F
	warp_def 3, 8, 3, TIN_TOWER_9F
	warp_def 15, 12, 6, TIN_TOWER_9F
	warp_def 9, 4, 7, TIN_TOWER_9F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	itemball_event 13, 5, BIG_NUGGET, 1, EVENT_TIN_TOWER_8F_BIG_NUGGET
	itemball_event 6, 9, MAX_ELIXER, 1, EVENT_TIN_TOWER_8F_MAX_ELIXER
	itemball_event 1, 1, FULL_RESTORE, 1, EVENT_TIN_TOWER_8F_FULL_RESTORE

