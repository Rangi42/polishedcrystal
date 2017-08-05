TinTower7F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower7F_MapEventHeader:

.Warps: db 5
	warp_def $9, $1, 1, TIN_TOWER_6F
	warp_def $f, $8, 1, TIN_TOWER_8F
	warp_def $7, $a, 4, TIN_TOWER_7F
	warp_def $3, $6, 3, TIN_TOWER_7F
	warp_def $9, $4, 5, TIN_TOWER_9F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 1, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, MAX_REVIVE, 1, EVENT_TIN_TOWER_7F_MAX_REVIVE

