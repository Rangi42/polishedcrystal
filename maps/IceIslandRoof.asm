const_value set 2

IceIslandRoof_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IceIslandRoof_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $3, 2, ICE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
