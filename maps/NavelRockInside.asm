const_value set 2

NavelRockInside_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NavelRockInside_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 14
	warp_def $57, $9, 3, NAVEL_ROCK_OUTSIDE
	warp_def $43, $9, 3, NAVEL_ROCK_INSIDE
	warp_def $37, $5, 2, NAVEL_ROCK_INSIDE
	warp_def $39, $b, 5, NAVEL_ROCK_INSIDE
	warp_def $55, $17, 4, NAVEL_ROCK_INSIDE
	warp_def $3, $17, 7, NAVEL_ROCK_INSIDE
	warp_def $4b, $25, 6, NAVEL_ROCK_INSIDE
	warp_def $48, $22, 9, NAVEL_ROCK_INSIDE
	warp_def $3e, $22, 8, NAVEL_ROCK_INSIDE
	warp_def $41, $25, 11, NAVEL_ROCK_INSIDE
	warp_def $37, $25, 10, NAVEL_ROCK_INSIDE
	warp_def $34, $22, 13, NAVEL_ROCK_INSIDE
	warp_def $2a, $22, 12, NAVEL_ROCK_INSIDE
	warp_def $2d, $25, 1, NAVEL_ROCK_ROOF

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
