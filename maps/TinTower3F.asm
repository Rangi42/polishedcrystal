TinTower3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TinTower3F_MapEventHeader:

.Warps: db 2
	warp_def $e, $8, 1, TIN_TOWER_2F
	warp_def $2, $e, 2, TIN_TOWER_4F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 14, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower3FFullHeal, EVENT_TIN_TOWER_3F_FULL_HEAL

TinTower3FFullHeal:
	itemball FULL_HEAL
