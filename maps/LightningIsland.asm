const_value set 0

LightningIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

LightningIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1d, $5, 1, SHAMOUTI_COAST
	warp_def $1d, $13, 1, LIGHTNING_ISLAND_ROOF
	warp_def $3, $6, 4, LIGHTNING_ISLAND
	warp_def $3, $13, 3, LIGHTNING_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
