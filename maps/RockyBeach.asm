const_value set 2

RockyBeach_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RockyBeach_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $0, 1, ROCKY_BEACH_HOUSE
	warp_def $0, $0, 1, NOISY_FOREST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
