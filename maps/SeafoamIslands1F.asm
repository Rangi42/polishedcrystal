const_value set 2

SeafoamIslands1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .ClearRocks

.ClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	return

SeafoamIslands1FHiddenEscapeRope:
	dwb EVENT_SEAFOAM_ISLANDS_1F_HIDDEN_ESCAPE_ROPE, ESCAPE_ROPE

SeafoamIslands1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $7, $13, 1, ROUTE_20
	warp_def $5, $13, 1, SEAFOAM_GYM
	warp_def $2, $10, 1, SEAFOAM_ISLANDS_B1F
	warp_def $5, $5, 2, ROUTE_20
	warp_def $3, $5, 2, SEAFOAM_ISLANDS_B1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 3, 21, SIGNPOST_ITEM, SeafoamIslands1FHiddenEscapeRope

.PersonEvents:
	db 0
