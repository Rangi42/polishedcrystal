SoulHouseB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 17, 15, 2, SOUL_HOUSE_B1F
	warp_event 3, 15, 3, SOUL_HOUSE_B1F
	warp_event 9, 4, 1, SOUL_HOUSE_B3F

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
