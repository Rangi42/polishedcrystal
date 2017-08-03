ScaryCaveB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ScaryCaveB1F_MapEventHeader:

.Warps: db 2
	warp_def $13, $5, 3, SCARY_CAVE_1F
	warp_def $3, $13, 4, SCARY_CAVE_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_BALL_CUT_FRUIT, 15, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ScaryCaveB1FBigNugget, EVENT_SCARY_CAVE_B1F_BIG_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 19, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ScaryCaveB1FBlackSludge, EVENT_SCARY_CAVE_B1F_BLACK_SLUDGE

ScaryCaveB1FBigNugget:
	itemball BIG_NUGGET

ScaryCaveB1FBlackSludge:
	itemball BLACK_SLUDGE
