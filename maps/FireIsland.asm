const_value set 0

FireIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

FireIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 12
	warp_def $1d, $5, 1, SHAMOUTI_COAST
	warp_def $1d, $13, 1, FIRE_ISLAND_ROOF
	warp_def $5, $7, 4, FIRE_ISLAND
	warp_def $5, $15, 3, FIRE_ISLAND
	warp_def $9, $7, 6, FIRE_ISLAND
	warp_def $9, $15, 5, FIRE_ISLAND
	warp_def $10, $2, 8, FIRE_ISLAND
	warp_def $10, $10, 7, FIRE_ISLAND
	warp_def $13, $9, 10, FIRE_ISLAND
	warp_def $13, $17, 9, FIRE_ISLAND
	warp_def $17, $3, 12, FIRE_ISLAND
	warp_def $17, $11, 11, FIRE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
