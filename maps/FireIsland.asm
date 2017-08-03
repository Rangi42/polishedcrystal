FireIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

FireIsland_MapEventHeader:

.Warps: db 14
	warp_def $1d, $5, 1, SHAMOUTI_COAST
	warp_def $1d, $13, 1, FIRE_ISLAND_ROOF
	warp_def $5, $7, 4, FIRE_ISLAND
	warp_def $5, $15, 3, FIRE_ISLAND
	warp_def $9, $7, 6, FIRE_ISLAND
	warp_def $9, $15, 5, FIRE_ISLAND
	warp_def $10, $2, 8, FIRE_ISLAND
	warp_def $10, $10, 7, FIRE_ISLAND
	warp_def $13, $9, 10, FIRE_ISLAND
	warp_def $13, $17, 9, FIRE_ISLAND
	warp_def $17, $3, 12, FIRE_ISLAND
	warp_def $17, $11, 11, FIRE_ISLAND
	warp_def $1b, $14, 14, FIRE_ISLAND
	warp_def $1b, $6, 13, FIRE_ISLAND ; hole

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 19, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, HEAT_ROCK, 1, EVENT_FIRE_ISLAND_HEAT_ROCK

