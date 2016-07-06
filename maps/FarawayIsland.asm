const_value set 2

FarawayIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

FarawayIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $6, 1, SEAGALLOP_FERRY_FARAWAY_GATE
	warp_def $9, $7, 1, SEAGALLOP_FERRY_FARAWAY_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
