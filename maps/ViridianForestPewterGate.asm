const_value set 2

ViridianForestPewterGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ViridianForestPewterGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $7, $4, 1, VIRIDIAN_FOREST
	warp_def $7, $5, 1, VIRIDIAN_FOREST
	warp_def $0, $4, 7, ROUTE_2
	warp_def $0, $5, 8, ROUTE_2

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
