NavelRockInside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

NavelRockInside_MapEventHeader:

.Warps: db 14
	warp_def $57, $9, 3, NAVEL_ROCK_OUTSIDE
	warp_def $43, $9, 3, NAVEL_ROCK_INSIDE
	warp_def $3, $3, 2, NAVEL_ROCK_INSIDE
	warp_def $5, $9, 5, NAVEL_ROCK_INSIDE
	warp_def $55, $17, 4, NAVEL_ROCK_INSIDE
	warp_def $3, $17, 7, NAVEL_ROCK_INSIDE
	warp_def $2d, $5, 6, NAVEL_ROCK_INSIDE
	warp_def $2a, $2, 9, NAVEL_ROCK_INSIDE
	warp_def $20, $2, 8, NAVEL_ROCK_INSIDE
	warp_def $23, $5, 11, NAVEL_ROCK_INSIDE
	warp_def $19, $5, 10, NAVEL_ROCK_INSIDE
	warp_def $16, $2, 13, NAVEL_ROCK_INSIDE
	warp_def $c, $2, 12, NAVEL_ROCK_INSIDE
	warp_def $f, $5, 1, NAVEL_ROCK_ROOF

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_BALL_CUT_FRUIT, 12, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, NavelRockInsideSacredAsh, EVENT_NAVEL_ROCK_SACRED_ASH
	person_event SPRITE_BALL_CUT_FRUIT, 12, 37, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, NavelRockInsideMasterBall, EVENT_NAVEL_ROCK_MASTER_BALL

NavelRockInsideSacredAsh:
	itemball SACRED_ASH

NavelRockInsideMasterBall:
	itemball MASTER_BALL
