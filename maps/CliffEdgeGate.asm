const_value set 2

CliffEdgeGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CliffEdgeGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $13, $11, 8, CIANWOOD_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
