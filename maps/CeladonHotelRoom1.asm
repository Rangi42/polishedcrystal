CeladonHotelRoom1_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 5, 3, 2, CELADON_HOTEL_2F
	warp_def 5, 4, 2, CELADON_HOTEL_2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 3 ; person events
	person_event SPRITE_COOLTRAINER_M, 3, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom1CooltrainerMText, -1
	person_event SPRITE_LASS, 3, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom1LassText, -1
	itemball_event 1, 3, POKE_DOLL, 1, EVENT_CELADON_HOTEL_ROOM_1_POKE_DOLL

CeladonHotelRoom1CooltrainerMText:
	text "Where I come from,"
	line "there aren't any"
	cont "# Balls."

	para "People use Capture"
	line "Stylers to be-"
	cont "friend #mon."
	done

CeladonHotelRoom1LassText:
	text "The staff here"
	line "fold our towels"
	cont "into flower shapes"
	cont "every day."

	para "I should ask them"
	line "to teach me how."
	done
