const_value set 2

CeladonUniversityLibrary1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityLibrary1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $b, $6, 4, CELADON_UNIVERSITY_1F
	warp_def $b, $7, 4, CELADON_UNIVERSITY_1F
	warp_def $0, $7, 1, CELADON_UNIVERSITY_LIBRARY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
