const_value set 2

ScaryCaveShipwreck_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ScaryCaveShipwreck_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $9, $5, 5, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
