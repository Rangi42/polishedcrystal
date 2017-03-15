const_value set 2

CeladonUniversity1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversity1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 10
	warp_def $13, $e, 13, CELADON_CITY
	warp_def $13, $f, 13, CELADON_CITY
	warp_def $c, $19, 1, CELADON_UNIVERSITY_2F
	warp_def $c, $15, 1, CELADON_UNIVERSITY_LIBRARY_1F
	warp_def $0, $f, 1, CELADON_UNIVERSITY_DEANS_OFFICE
	warp_def $4, $3, 1, CELADON_UNIVERSITY_CLASSROOM_1
	warp_def $4, $9, 1, CELADON_UNIVERSITY_CLASSROOM_2
	warp_def $4, $15, 1, CELADON_UNIVERSITY_CLASSROOM_3
	warp_def $4, $1b, 1, CELADON_UNIVERSITY_CLASSROOM_4
	warp_def $c, $3, 1, CELADON_UNIVERSITY_LOUNGE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
