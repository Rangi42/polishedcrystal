const_value set 2
	const TINTOWER8F_POKE_BALL1
	const TINTOWER8F_POKE_BALL2
	const TINTOWER8F_POKE_BALL3

TinTower8F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TinTower8FBigNugget:
	itemball BIG_NUGGET

TinTower8FMaxElixer:
	itemball MAX_ELIXER

TinTower8FFullRestore:
	itemball FULL_RESTORE

TinTower8F_MapEventHeader:
.Warps:
	db 6
	warp_def $5, $0, 2, TIN_TOWER_7F
	warp_def $b, $0, 1, TIN_TOWER_9F
	warp_def $7, $e, 2, TIN_TOWER_9F
	warp_def $3, $8, 3, TIN_TOWER_9F
	warp_def $f, $c, 6, TIN_TOWER_9F
	warp_def $9, $4, 7, TIN_TOWER_9F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_BALL_CUT_FRUIT, 13, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower8FBigNugget, EVENT_TIN_TOWER_8F_BIG_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 6, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower8FMaxElixer, EVENT_TIN_TOWER_8F_MAX_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 1, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TinTower8FFullRestore, EVENT_TIN_TOWER_8F_FULL_RESTORE
