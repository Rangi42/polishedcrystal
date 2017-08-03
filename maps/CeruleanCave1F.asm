CeruleanCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCave1F_MapEventHeader:

.Warps: db 8
	warp_def $13, $1b, 7, CERULEAN_CITY
	warp_def $3, $9, 1, CERULEAN_CAVE_2F
	warp_def $3, $1d, 2, CERULEAN_CAVE_2F
	warp_def $5, $3, 3, CERULEAN_CAVE_2F
	warp_def $8, $2, 1, CERULEAN_CAVE_B1F
	warp_def $9, $19, 4, CERULEAN_CAVE_2F
	warp_def $b, $14, 5, CERULEAN_CAVE_2F
	warp_def $d, $5, 6, CERULEAN_CAVE_2F

.XYTriggers: db 0

.Signposts: db 3
	signpost 11, 10, SIGNPOST_ITEM, CeruleanCave1FHiddenUltraBall
	signpost 14, 5, SIGNPOST_ITEM, CeruleanCave1FHiddenPPUp
	signpost 13, 16, SIGNPOST_ITEM, CeruleanCave1FHiddenRareCandy

.PersonEvents: db 3
	person_event SPRITE_BALL_CUT_FRUIT, 4, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave1FBigNugget, EVENT_CERULEAN_CAVE_1F_BIG_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 15, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave1FFullRestore, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE
	person_event SPRITE_BALL_CUT_FRUIT, 5, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave1FMaxRevive, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE

CeruleanCave1FBigNugget:
	itemball BIG_NUGGET

CeruleanCave1FFullRestore:
	itemball FULL_RESTORE

CeruleanCave1FMaxRevive:
	itemball MAX_REVIVE

CeruleanCave1FHiddenUltraBall:
	dwb EVENT_CERULEAN_CAVE_1F_HIDDEN_ULTRA_BALL, ULTRA_BALL

CeruleanCave1FHiddenPPUp:
	dwb EVENT_CERULEAN_CAVE_1F_HIDDEN_PP_UP, PP_UP

CeruleanCave1FHiddenRareCandy:
	dwb EVENT_CERULEAN_CAVE_1F_HIDDEN_RARE_CANDY, RARE_CANDY
