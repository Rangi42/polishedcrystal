WhirlIslandNW_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandNW_MapEventHeader:

.Warps: db 4
	warp_def $21, $5, 1, ROUTE_41
	warp_def $1d, $5, 1, WHIRL_ISLAND_B1F
	warp_def $1f, $f, 4, WHIRL_ISLAND_SW
	warp_def $1f, $13, 2, WHIRL_ISLAND_CAVE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0
