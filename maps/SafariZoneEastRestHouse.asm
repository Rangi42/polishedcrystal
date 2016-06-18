const_value set 2

SafariZoneEastRestHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SafariZoneEastRestHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 5, SAFARI_ZONE_EAST
	warp_def $7, $3, 5, SAFARI_ZONE_EAST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
