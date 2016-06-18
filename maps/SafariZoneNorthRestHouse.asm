const_value set 2

SafariZoneNorthRestHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneNorthRestHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 7, SAFARI_ZONE_NORTH
	warp_def $7, $3, 7, SAFARI_ZONE_NORTH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
