const_value set 2

ScaryCaveB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ScaryCaveB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $5, 3, SCARY_CAVE_1F
	warp_def $3, $13, 4, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
