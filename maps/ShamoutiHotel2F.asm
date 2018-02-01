ShamoutiHotel2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 2, 0, 3, SHAMOUTI_HOTEL_1F
	warp_event 3, 0, 1, SHAMOUTI_HOTEL_3F
	warp_event 6, 0, 1, SHAMOUTI_HOTEL_ROOM_2A
	warp_event 10, 0, 1, SHAMOUTI_HOTEL_ROOM_2B

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
