const_value set 2

ViridianForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ViridianForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $3, $1, 1, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $3, $2, 2, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $30, $10, 1, VIRIDIAN_FOREST_VIRIDIAN_GATE
	warp_def $30, $11, 2, VIRIDIAN_FOREST_VIRIDIAN_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
