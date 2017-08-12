WhirlIslandB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandB1F_MapEventHeader:

.Warps: db 9
	warp_def $5, $5, 2, WHIRL_ISLAND_NW
	warp_def $3, $23, 2, WHIRL_ISLAND_NE
	warp_def $9, $1d, 3, WHIRL_ISLAND_NE
	warp_def $1f, $9, 3, WHIRL_ISLAND_SW
	warp_def $1f, $17, 2, WHIRL_ISLAND_SW
	warp_def $1d, $1f, 2, WHIRL_ISLAND_SE
	warp_def $15, $19, 1, WHIRL_ISLAND_B2F
	warp_def $1b, $d, 2, WHIRL_ISLAND_B2F
	warp_def $15, $11, 1, WHIRL_ISLAND_CAVE

.XYTriggers: db 0

.Signposts: db 3
	signpost 4, 30, SIGNPOST_ITEM + RARE_CANDY, EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY
	signpost 18, 36, SIGNPOST_ITEM + ULTRA_BALL, EVENT_WHIRL_ISLAND_B1F_HIDDEN_ULTRA_BALL
	signpost 23, 2, SIGNPOST_ITEM + FULL_RESTORE, EVENT_WHIRL_ISLAND_B1F_HIDDEN_FULL_RESTORE

.PersonEvents: db 6
	itemball_event 13, 7, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B1F_FULL_RESTORE
	itemball_event 18, 2, CARBOS, 1, EVENT_WHIRL_ISLAND_B1F_CARBOS
	itemball_event 23, 33, CALCIUM, 1, EVENT_WHIRL_ISLAND_B1F_CALCIUM
	itemball_event 8, 17, BIG_NUGGET, 1, EVENT_WHIRL_ISLAND_B1F_BIG_NUGGET
	itemball_event 26, 19, ESCAPE_ROPE, 1, EVENT_WHIRL_ISLAND_B1F_ESCAPE_ROPE
	strengthboulder_event 26, 23
