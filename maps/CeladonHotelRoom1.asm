CeladonHotelRoom1_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  5, CELADON_HOTEL_2F, 2
	warp_event  4,  5, CELADON_HOTEL_2F, 2

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  3,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom1CooltrainerMText, -1
	object_event  1,  3, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelRoom1LassText, -1
	itemball_event  3,  1, POKE_DOLL, 1, EVENT_CELADON_HOTEL_ROOM_1_POKE_DOLL

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
