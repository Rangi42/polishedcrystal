const_value set 2

PewterMuseumOfScience1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PewterMuseumOfScience1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $7, $a, 6, PEWTER_CITY
	warp_def $7, $b, 6, PEWTER_CITY
	warp_def $7, $10, 7, PEWTER_CITY
	warp_def $7, $11, 7, PEWTER_CITY
	warp_def $7, $7, 1, PEWTER_MUSEUM_OF_SCIENCE_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
