Underground_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Underground_MapEventHeader:

.Warps: db 2
	warp_def $2, $3, 3, ROUTE_5_UNDERGROUND_ENTRANCE
	warp_def $20, $3, 3, ROUTE_6_UNDERGROUND_ENTRANCE

.XYTriggers: db 0

.Signposts: db 2
	signpost 9, 3, SIGNPOST_ITEM, UndergroundHiddenFullRestore
	signpost 21, 1, SIGNPOST_ITEM, UndergroundHiddenXSpclAtk

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 15, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEBALL, PLAYEREVENT_TMHMBALL, TM_EXPLOSION, EVENT_UNDERGROUND_TM_EXPLOSION

UndergroundHiddenFullRestore:
	dwb EVENT_UNDERGROUND_HIDDEN_FULL_RESTORE, FULL_RESTORE

UndergroundHiddenXSpclAtk:
	dwb EVENT_UNDERGROUND_HIDDEN_X_SPCL_ATK, X_SPCL_ATK
