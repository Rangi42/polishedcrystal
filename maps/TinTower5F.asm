TinTower5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower5F_MapEventHeader:

.Warps: db 4
	warp_def $f, $9, 2, TIN_TOWER_6F
	warp_def $4, $0, 1, TIN_TOWER_4F
	warp_def $e, $0, 3, TIN_TOWER_4F
	warp_def $f, $e, 4, TIN_TOWER_4F

.XYTriggers: db 0

.Signposts: db 2
	signpost 14, 14, SIGNPOST_ITEM, TinTower5FHiddenFullRestore
	signpost 15, 1, SIGNPOST_ITEM, TinTower5FHiddenCarbos

.PersonEvents: db 1
	itemball_event 9, 7, RARE_CANDY, 1, EVENT_TIN_TOWER_5F_RARE_CANDY

TinTower5FHiddenFullRestore:
	dwb EVENT_TIN_TOWER_5F_HIDDEN_FULL_RESTORE, FULL_RESTORE

TinTower5FHiddenCarbos:
	dwb EVENT_TIN_TOWER_5F_HIDDEN_CARBOS, CARBOS
