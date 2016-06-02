const_value set 2

CliffCave_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CliffCaveHiddenUltraBall:
	dwb EVENT_CLIFF_CAVE_HIDDEN_ULTRA_BALL, ULTRA_BALL

CliffCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 7
	warp_def $15, $7, 2, ROUTE_47
	warp_def $9, $9, 3, ROUTE_47
	warp_def $25, $7, 4, ROUTE_47
	warp_def $13, $5, 6, CLIFF_CAVE
	warp_def $13, $9, 7, CLIFF_CAVE
	warp_def $3, $5, 4, CLIFF_CAVE
	warp_def $1f, $9, 5, CLIFF_CAVE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 9, 11, SIGNPOST_ITEM, CliffCaveHiddenUltraBall

.PersonEvents:
	db 0
