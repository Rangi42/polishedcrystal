const_value set 2

CeruleanCaveB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeruleanCaveB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $5, 5, CERULEAN_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
