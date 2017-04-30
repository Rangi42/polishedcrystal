WhirlIslandCave_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

WhirlIslandCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $2b, $25, 9, WHIRL_ISLAND_B1F
	warp_def $33, $21, 4, WHIRL_ISLAND_NW

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
