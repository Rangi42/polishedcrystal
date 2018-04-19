TrainerHouse1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  4, 11, VIRIDIAN_CITY, 3
	warp_event  5, 11, VIRIDIAN_CITY, 3
	warp_event  8,  2, TRAINER_HOUSE_B1F, 1

	db 0 ; coord events

	db 3 ; bg events
	bg_event  7,  0, SIGNPOST_JUMPTEXT, UnknownText_0x9b1f4
	bg_event  9,  0, SIGNPOST_JUMPTEXT, UnknownText_0x9b25d
	bg_event  4,  6, SIGNPOST_JUMPTEXT, UnknownText_0x9b2c1

	db 5 ; object events
	object_event  0, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9af7f, -1
	object_event  8, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b025, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b0b5, -1
	object_event  7,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b11d, -1
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b1c9, -1

UnknownText_0x9af7f:
	text "Welcome to Trainer"
	line "House, the newest"

	para "and most happening"
	line "place in Viridian."

	para "We're open to"
	line "trainers only."

	para "You can battle"
	line "against the best"

	para "of the best right"
	line "downstairs."
	done

UnknownText_0x9b025:
	text "Viridian is the"
	line "town closest to"
	cont "Indigo Plateau."

	para "It's known as the"
	line "gateway to Indigo"
	cont "Plateau!"

	para "They built this"
	line "place because so"

	para "many trainers pass"
	line "through on their"

	para "way up to the"
	line "#mon League."
	done

UnknownText_0x9b0b5:
	text "They hold practice"
	line "battles downstairs"
	cont "here."

	para "I would love to"
	line "see how well a"

	para "trainer from Johto"
	line "battles."
	done

UnknownText_0x9b11d:
	text "I guess you can't"
	line "become the Champ"

	para "unless you go all"
	line "over the place and"

	para "battle all kinds"
	line "of people."

	para "The Champion from"
	line "Pallet traveled to"

	para "all the cities and"
	line "towns in Kanto."
	done

UnknownText_0x9b1c9:
	text "Whew… I'm taking a"
	line "rest from #mon"
	cont "battles."
	done

UnknownText_0x9b1f4:
	text "Practice battles"
	line "are held in the"

	para "Training Hall"
	line "downstairs."

	para "Skilled trainers"
	line "are invited to"
	cont "participate."
	done

UnknownText_0x9b25d:
	text "There are no rules"
	line "or regulations for"

	para "practice matches."
	line "Just like in field"

	para "battles, anything"
	line "goes!"
	done

UnknownText_0x9b2c1:
	text "…What's this?"
	line "A strategy memo?"

	para "This writing looks"
	line "like Onix tracks…"

	para "It's completely"
	line "illegible…"
	done
