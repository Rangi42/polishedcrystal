const_value set 2

ShamoutiEastBeach_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiEastBeach_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $0, $0, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def $0, $0, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def $0, $0, 1, SHAMOUTI_EAST_BEACH_VILLA

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
