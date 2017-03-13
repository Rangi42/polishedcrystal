const_value set 2

CeladonUniversityPool_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityPool_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $6, 6, CELADON_UNIVERSITY_2F
	warp_def $9, $7, 6, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
