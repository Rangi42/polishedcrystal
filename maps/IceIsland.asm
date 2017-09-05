IceIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IceIsland_MapEventHeader:

.Warps: db 6
	warp_def 29, 6, 2, SHAMOUTI_COAST
	warp_def 29, 20, 1, ICE_ISLAND_ROOF
	warp_def 5, 7, 4, ICE_ISLAND
	warp_def 5, 21, 3, ICE_ISLAND
	warp_def 26, 21, 6, ICE_ISLAND
	warp_def 26, 7, 5, ICE_ISLAND ; hole

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 6, 19, ICY_ROCK, 1, EVENT_ICE_ISLAND_ICY_ROCK

