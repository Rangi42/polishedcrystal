const_value set 2
	const TINTOWER6F_POKE_BALL

TinTower6F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TinTower6FMaxPotion:
	itemball MAX_POTION

TinTower6F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $1, 1, TIN_TOWER_7F
	warp_def $f, $9, 1, TIN_TOWER_5F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BALL_CUT_FRUIT, 8, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower6FMaxPotion, EVENT_TIN_TOWER_6F_MAX_POTION
