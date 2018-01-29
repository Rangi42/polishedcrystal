CeladonHotelRoom3_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeladonHotelRoom3_MapEventHeader:
	db 2 ; warps
	warp_def 5, 3, 4, CELADON_HOTEL_2F
	warp_def 5, 4, 4, CELADON_HOTEL_2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_GRAMPS, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom3GrampsText, -1

CeladonHotelRoom3GrampsText:
	text "I've been staying"
	line "at this hotel"
	cont "every year since"
	cont "I was a wee lad."

	para "It almost feels"
	line "like a second"
	cont "home!"
	done
