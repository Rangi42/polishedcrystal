DragonsDen1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 15, 55, BLACKTHORN_CITY, 8
	warp_event 15, 53, DRAGONS_DEN_1F, 4
	warp_event  5, 55, DRAGONS_DEN_B1F, 1
	warp_event  5, 53, DRAGONS_DEN_1F, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
