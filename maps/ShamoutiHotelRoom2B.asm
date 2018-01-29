ShamoutiHotelRoom2B_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ShamoutiHotelRoom2B_MapEventHeader:
	db 2 ; warps
	warp_def 5, 3, 4, SHAMOUTI_HOTEL_2F
	warp_def 5, 4, 4, SHAMOUTI_HOTEL_2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
