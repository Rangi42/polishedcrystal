const_value set 2

PsychicInversHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PsychicInversHouseBookshelf:
	jumpstd difficultbookshelf

PsychicInversHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 1, ROUTE_16_WEST
	warp_def $7, $3, 1, ROUTE_16_WEST

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_READ, PsychicInversHouseBookshelf

.PersonEvents:
	db 0
