const_value set 0

ShamoutiEastBeachVilla_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiEastBeachVilla_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 3, SHAMOUTI_EAST_BEACH
	warp_def $7, $3, 3, SHAMOUTI_EAST_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
