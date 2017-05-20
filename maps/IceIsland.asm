const_value set 2

IceIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IceIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1d, $6, 1, SHAMOUTI_COAST
	warp_def $1d, $14, 1, ICE_ISLAND_ROOF
	warp_def $5, $7, 4, ICE_ISLAND
	warp_def $5, $15, 3, ICE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
