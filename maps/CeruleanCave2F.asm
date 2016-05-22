const_value set 2

CeruleanCave2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeruleanCave2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $3, $b, 2, CERULEAN_CAVE_1F
	warp_def $3, $1f, 3, CERULEAN_CAVE_1F
	warp_def $5, $3, 4, CERULEAN_CAVE_1F
	warp_def $8, $18, 6, CERULEAN_CAVE_1F
	warp_def $9, $15, 7, CERULEAN_CAVE_1F
	warp_def $d, $5, 8, CERULEAN_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
