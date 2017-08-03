WhirlIslandSW_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandSW_MapEventHeader:

.Warps: db 5
	warp_def $7, $5, 3, ROUTE_41
	warp_def $3, $11, 5, WHIRL_ISLAND_B1F
	warp_def $3, $3, 4, WHIRL_ISLAND_B1F
	warp_def $f, $3, 3, WHIRL_ISLAND_NW
	warp_def $f, $11, 4, WHIRL_ISLAND_B2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 2, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_SW_ULTRA_BALL

