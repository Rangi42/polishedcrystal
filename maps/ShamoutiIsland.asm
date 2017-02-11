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
	db 6
	warp_def $d, $15, 1, SHAMOUTI_POKECENTER_1F
	warp_def $5, $21, 1, SHAMOUTI_HOTEL
	warp_def $7, $10, 1, SHAMOUTI_TUNNEL
	warp_def $5, $1b, 1, SHAMOUTI_TOURIST_CENTER
	warp_def $c, $1f, 1, SHAMOUTI_HOUSE
	warp_def $d, $7, 1, SHAMOUTI_MERCHANT

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
