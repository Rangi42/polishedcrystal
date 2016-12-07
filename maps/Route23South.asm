Route23South_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route23South_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $3f, $7, 5, VICTORY_ROAD_GATE
	warp_def $3f, $8, 6, VICTORY_ROAD_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
