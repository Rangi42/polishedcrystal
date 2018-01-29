ShamoutiHotelRoom3B_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ShamoutiHotelRoom3B_MapEventHeader:
	db 2 ; warps
	warp_def 5, 3, 2, SHAMOUTI_HOTEL_3F
	warp_def 5, 4, 2, SHAMOUTI_HOTEL_3F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
