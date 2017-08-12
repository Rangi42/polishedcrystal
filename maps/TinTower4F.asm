TinTower4F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower4F_MapEventHeader:

.Warps: db 4
	warp_def $4, $0, 2, TIN_TOWER_5F
	warp_def $2, $e, 2, TIN_TOWER_3F
	warp_def $e, $0, 3, TIN_TOWER_5F
	warp_def $f, $f, 4, TIN_TOWER_5F

.XYTriggers: db 0

.Signposts: db 1
	signpost 6, 9, SIGNPOST_ITEM, TinTower4FHiddenMaxPotion

.PersonEvents: db 3
	itemball_event 10, 12, ULTRA_BALL, 1, EVENT_TIN_TOWER_4F_ULTRA_BALL
	itemball_event 14, 15, PP_UP, 1, EVENT_TIN_TOWER_4F_PP_UP
	itemball_event 12, 0, ESCAPE_ROPE, 1, EVENT_TIN_TOWER_4F_ESCAPE_ROPE

TinTower4FHiddenMaxPotion:
	dwb EVENT_TIN_TOWER_4F_HIDDEN_MAX_POTION, MAX_POTION
