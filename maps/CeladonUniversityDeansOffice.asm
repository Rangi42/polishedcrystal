const_value set 2

CeladonUniversityDeansOffice_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityDeansOffice_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 5, CELADON_UNIVERSITY_1F
	warp_def $7, $3, 5, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
