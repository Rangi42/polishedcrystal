FireIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

FireIsland_MapEventHeader:

.Warps: db 14
	warp_def 29, 5, 1, SHAMOUTI_COAST
	warp_def 29, 19, 1, FIRE_ISLAND_ROOF
	warp_def 5, 7, 4, FIRE_ISLAND
	warp_def 5, 21, 3, FIRE_ISLAND
	warp_def 9, 7, 6, FIRE_ISLAND
	warp_def 9, 21, 5, FIRE_ISLAND
	warp_def 16, 2, 8, FIRE_ISLAND
	warp_def 16, 16, 7, FIRE_ISLAND
	warp_def 19, 9, 10, FIRE_ISLAND
	warp_def 19, 23, 9, FIRE_ISLAND
	warp_def 23, 3, 12, FIRE_ISLAND
	warp_def 23, 17, 11, FIRE_ISLAND
	warp_def 27, 20, 14, FIRE_ISLAND
	warp_def 27, 6, 13, FIRE_ISLAND ; hole

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 19, 2, HEAT_ROCK, 1, EVENT_FIRE_ISLAND_HEAT_ROCK

