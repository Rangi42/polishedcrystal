const_value set 2

CeruleanCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeruleanCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $13, $1b, 7, CERULEAN_CITY
	warp_def $3, $9, 1, CERULEAN_CAVE_2F
	warp_def $3, $1d, 2, CERULEAN_CAVE_2F
	warp_def $5, $3, 3, CERULEAN_CAVE_2F
	warp_def $8, $2, 1, CERULEAN_CAVE_B1F
	warp_def $9, $19, 4, CERULEAN_CAVE_2F
	warp_def $b, $14, 5, CERULEAN_CAVE_2F
	warp_def $d, $5, 6, CERULEAN_CAVE_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
