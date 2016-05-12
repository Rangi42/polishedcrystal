const_value set 2

PewterMuseumOfScience2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PewterMuseumOfScience2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
