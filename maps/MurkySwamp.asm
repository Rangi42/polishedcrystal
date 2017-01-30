const_value set 2

MurkySwamp_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MurkySwamp_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $1f, $5, 1, STORMY_BEACH
	warp_def $1f, $6, 2, STORMY_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
