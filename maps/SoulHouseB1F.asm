SoulHouseB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 17,  5, SOUL_HOUSE, 3
	warp_event 17, 15, SOUL_HOUSE_B2F, 1
	warp_event  3, 15, SOUL_HOUSE_B2F, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
