WhirlIslandNE_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandNE_MapEventHeader:

.Warps: db 3
	warp_def 13, 3, 2, ROUTE_41
	warp_def 3, 17, 2, WHIRL_ISLAND_B1F
	warp_def 11, 13, 3, WHIRL_ISLAND_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 11, 11, ULTRA_BALL, 1, EVENT_WHIRL_ISLAND_NE_ULTRA_BALL

