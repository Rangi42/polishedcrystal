const_value set 2

Route47_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route47_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $15, $43, 2, CLIFF_EDGE_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
