SoulHouseB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 17, 15, SOUL_HOUSE_B1F, 2
	warp_event  3, 15, SOUL_HOUSE_B1F, 3
	warp_event  9,  4, SOUL_HOUSE_B3F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
