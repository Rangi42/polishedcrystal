const_value set 2

CeladonUniversityCafeteria_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityCafeteria_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $9, 2, CELADON_UNIVERSITY_2F
	warp_def $7, $a, 2, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
