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
	db 2
	warp_def $0, $0, 2, ROCKY_BEACH
	warp_def $0, $0, 1, SHAMOUTI_SHRINE_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
