const_value set 2

CeladonUniversityClassroom2_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityClassroom2_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 7, CELADON_UNIVERSITY_1F
	warp_def $b, $3, 7, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
