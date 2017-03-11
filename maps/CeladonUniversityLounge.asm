const_value set 2

CeladonUniversityLounge_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityLounge_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 10, CELADON_UNIVERSITY_1F
	warp_def $b, $5, 10, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
