ShamoutiHotel2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  2,  0, SHAMOUTI_HOTEL_1F, 3
	warp_event  3,  0, SHAMOUTI_HOTEL_3F, 1
	warp_event  6,  0, SHAMOUTI_HOTEL_ROOM_2A, 1
	warp_event 10,  0, SHAMOUTI_HOTEL_ROOM_2B, 1

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
