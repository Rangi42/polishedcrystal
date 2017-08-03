CeruleanCave2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanCave2F_MapEventHeader:

.Warps: db 6
	warp_def $3, $b, 2, CERULEAN_CAVE_1F
	warp_def $3, $1f, 3, CERULEAN_CAVE_1F
	warp_def $5, $3, 4, CERULEAN_CAVE_1F
	warp_def $8, $18, 6, CERULEAN_CAVE_1F
	warp_def $9, $15, 7, CERULEAN_CAVE_1F
	warp_def $d, $5, 8, CERULEAN_CAVE_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 19, 17, SIGNPOST_ITEM, CeruleanCave2FHiddenProtein
	signpost 4, 16, SIGNPOST_ITEM, CeruleanCave2FHiddenNugget
	signpost 17, 13, SIGNPOST_ITEM, CeruleanCave2FHiddenHyperPotion

.PersonEvents: db 4
	person_event SPRITE_BALL_CUT_FRUIT, 11, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave2FFullRestore, EVENT_CERULEAN_CAVE_2F_FULL_RESTORE
	person_event SPRITE_BALL_CUT_FRUIT, 17, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave2FPPUp, EVENT_CERULEAN_CAVE_2F_PP_UP
	person_event SPRITE_BALL_CUT_FRUIT, 15, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave2FUltraBall, EVENT_CERULEAN_CAVE_2F_ULTRA_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 7, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeruleanCave2FDuskStone, EVENT_CERULEAN_CAVE_2F_DUSK_STONE

CeruleanCave2FFullRestore:
	itemball FULL_RESTORE

CeruleanCave2FPPUp:
	itemball PP_UP

CeruleanCave2FUltraBall:
	itemball ULTRA_BALL

CeruleanCave2FDuskStone:
	itemball DUSK_STONE

CeruleanCave2FHiddenProtein:
	dwb EVENT_CERULEAN_CAVE_2F_HIDDEN_PROTEIN, PROTEIN

CeruleanCave2FHiddenNugget:
	dwb EVENT_CERULEAN_CAVE_2F_HIDDEN_NUGGET, NUGGET

CeruleanCave2FHiddenHyperPotion:
	dwb EVENT_CERULEAN_CAVE_2F_HIDDEN_HYPER_POTION, HYPER_POTION
