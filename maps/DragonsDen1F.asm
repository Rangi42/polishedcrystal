DragonsDen1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 15, 55, 8, BLACKTHORN_CITY
	warp_event 15, 53, 4, DRAGONS_DEN_1F
	warp_event 5, 55, 1, DRAGONS_DEN_B1F
	warp_event 5, 53, 2, DRAGONS_DEN_1F

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
