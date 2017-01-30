const_value set 2

StormyBeach_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

StormyBeach_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $4, $1e, 1, MURKY_SWAMP
	warp_def $4, $1f, 2, MURKY_SWAMP

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
