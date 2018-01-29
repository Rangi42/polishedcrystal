ShamoutiHotel2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ShamoutiHotel2F_MapEventHeader:
	db 4 ; warps
	warp_def 0, 2, 3, SHAMOUTI_HOTEL_1F
	warp_def 0, 3, 1, SHAMOUTI_HOTEL_3F
	warp_def 0, 6, 1, SHAMOUTI_HOTEL_ROOM_2A
	warp_def 0, 10, 1, SHAMOUTI_HOTEL_ROOM_2B

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
