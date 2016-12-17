const_value set 2

ShamoutiIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $d, $17, 1, SHAMOUTI_POKECENTER_1F
	warp_def $5, $1d, 1, SHAMOUTI_HOTEL
	warp_def $7, $10, 1, SHAMOUTI_TUNNEL

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
