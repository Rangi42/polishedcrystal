const_value set 2

CeladonUniversity1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversity1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $13, $e, 13, CELADON_CITY
	warp_def $13, $f, 13, CELADON_CITY
	warp_def $c, $19, 1, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
