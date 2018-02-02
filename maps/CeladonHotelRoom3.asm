CeladonHotelRoom3_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  5, CELADON_HOTEL_2F, 4
	warp_event  4,  5, CELADON_HOTEL_2F, 4

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  2,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom3GrampsText, -1

CeladonHotelRoom3GrampsText:
	text "I've been staying"
	line "at this hotel"
	cont "every year since"
	cont "I was a wee lad."

	para "It almost feels"
	line "like a second"
	cont "home!"
	done
