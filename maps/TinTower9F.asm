const_value set 2
	const TINTOWER9F_POKE_BALL

TinTower9F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TinTower9FHPUp:
	itemball HP_UP

TinTower9F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 7
	warp_def $3, $a, 2, TIN_TOWER_8F
	warp_def $5, $0, 3, TIN_TOWER_8F
	warp_def $7, $a, 4, TIN_TOWER_8F
	warp_def $9, $5, 1, TIN_TOWER_10F
	warp_def $7, $e, 5, TIN_TOWER_7F
	warp_def $d, $4, 5, TIN_TOWER_8F
	warp_def $d, $6, 6, TIN_TOWER_8F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BALL_CUT_FRUIT, 1, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower9FHPUp, EVENT_TIN_TOWER_9F_HP_UP
