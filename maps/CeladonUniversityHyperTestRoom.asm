const_value set 2

CeladonUniversityHyperTestRoom_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityHyperTestRoom_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 4, CELADON_UNIVERSITY_2F
	warp_def $b, $3, 4, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
