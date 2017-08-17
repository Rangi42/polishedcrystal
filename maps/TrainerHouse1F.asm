TrainerHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TrainerHouse1F_MapEventHeader:

.Warps: db 3
	warp_def 11, 4, 3, VIRIDIAN_CITY
	warp_def 11, 5, 3, VIRIDIAN_CITY
	warp_def 2, 8, 1, TRAINER_HOUSE_B1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 0, 7, SIGNPOST_JUMPTEXT, UnknownText_0x9b1f4
	signpost 0, 9, SIGNPOST_JUMPTEXT, UnknownText_0x9b25d
	signpost 6, 4, SIGNPOST_JUMPTEXT, UnknownText_0x9b2c1

.PersonEvents: db 5
	person_event SPRITE_RECEPTIONIST, 10, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9af7f, -1
	person_event SPRITE_COOLTRAINER_M, 10, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b025, -1
	person_event SPRITE_COOLTRAINER_F, 2, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b0b5, -1
	person_event SPRITE_YOUNGSTER, 7, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b11d, -1
	person_event SPRITE_GENTLEMAN, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b1c9, -1

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

	para "They built this"
	line "place because so"

	para "many trainers pass"
	line "through on their"

	para "way up to Indigo"
	line "Plateau."
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
