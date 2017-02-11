const_value set 0

ShamoutiWestBeachHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiWestBeachHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 3, SHAMOUTI_WEST_BEACH
	warp_def $7, $3, 3, SHAMOUTI_WEST_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
