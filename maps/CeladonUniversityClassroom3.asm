const_value set 2

CeladonUniversityClassroom3_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityClassroom3_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 8, CELADON_UNIVERSITY_1F
	warp_def $b, $3, 8, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
