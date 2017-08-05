WhirlIslandNE_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandNE_MapEventHeader:

.Warps: db 3
	warp_def $d, $3, 2, ROUTE_41
	warp_def $3, $11, 2, WHIRL_ISLAND_B1F
	warp_def $b, $d, 3, WHIRL_ISLAND_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 11, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_NE_ULTRA_BALL

