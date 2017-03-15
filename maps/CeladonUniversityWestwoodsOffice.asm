const_value set 2

CeladonUniversityWestwoodsOffice_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityWestwoodsOffice_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $5, $3, 5, CELADON_UNIVERSITY_2F
	warp_def $5, $4, 5, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
