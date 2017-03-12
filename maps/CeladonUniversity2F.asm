const_value set 2

CeladonUniversity2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversity2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $8, $17, 3, CELADON_UNIVERSITY_1F
	warp_def $0, $7, 1, CELADON_UNIVERSITY_CAFETERIA
	warp_def $0, $13, 1, CELADON_UNIVERSITY_WILLOWS_OFFICE
	warp_def $8, $5, 1, CELADON_UNIVERSITY_HYPER_TEST_ROOM
	warp_def $8, $13, 1, CELADON_UNIVERSITY_WESTWOODS_OFFICE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
