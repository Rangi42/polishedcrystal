const_value set 2

CliffEdgeGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CliffEdgeGateHiddenBigPearl:
	dwb EVENT_CLIFF_EDGE_GATE_HIDDEN_BIG_PEARL, BIG_PEARL

CliffEdgeGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $11, 8, CIANWOOD_CITY
	warp_def $13, $3, 1, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 8, 17, SIGNPOST_ITEM, CliffEdgeGateHiddenBigPearl

.PersonEvents:
	db 0
