const_value set 2

ViridianForestViridianGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ViridianForestViridianGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $0, $4, 2, VIRIDIAN_FOREST
	warp_def $0, $5, 3, VIRIDIAN_FOREST
	warp_def $7, $4, 6, ROUTE_2
	warp_def $7, $5, 6, ROUTE_2

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
