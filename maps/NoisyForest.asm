const_value set 0

NoisyForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NoisyForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $4, $6, 2, ROCKY_BEACH
	warp_def $5, $6, 3, ROCKY_BEACH
	warp_def $1c, $23, 1, SHAMOUTI_SHRINE_RUINS
	warp_def $1d, $23, 2, SHAMOUTI_SHRINE_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
