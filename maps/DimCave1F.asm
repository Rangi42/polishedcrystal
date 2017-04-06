const_value set 2

DimCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

DimCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $2, $1e, 5, DIM_CAVE_2F
	warp_def $11, $5, 6, DIM_CAVE_2F
	warp_def $12, $1c, 7, DIM_CAVE_2F
	warp_def $20, $18, 8, DIM_CAVE_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
