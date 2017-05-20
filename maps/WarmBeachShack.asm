const_value set 2

WarmBeachShack_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

WarmBeachShack_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 1, WARM_BEACH
	warp_def $7, $3, 1, WARM_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
