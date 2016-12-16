const_value set 0

ShamoutiHotel_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiHotel_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, SHAMOUTI_ISLAND
	warp_def $7, $3, 2, SHAMOUTI_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
