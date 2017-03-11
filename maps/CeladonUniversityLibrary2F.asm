const_value set 2

CeladonUniversityLibrary2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityLibrary2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $7, 3, CELADON_UNIVERSITY_LIBRARY_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
