SaffronPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SaffronPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 4, SAFFRON_CITY
	warp_def $7, $6, 4, SAFFRON_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalSabrinaScript

.PersonEvents: db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, pokecenternurse, -1
	person_event SPRITE_TEACHER, 4, 2, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x18a4a3, -1
	person_event SPRITE_FISHER, 5, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x18a48c, -1
	person_event SPRITE_YOUNGSTER, 4, 8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x18a6c5, -1

FisherScript_0x18a48c:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .SolvedKantoPowerCrisis
	jumpopenedtext UnknownText_0x18a5d3

.SolvedKantoPowerCrisis:
	jumpopenedtext UnknownText_0x18a62e

PokemonJournalSabrinaScript:
	setflag ENGINE_READ_SABRINA_JOURNAL
	jumptext PokemonJournalSabrinaText

UnknownText_0x18a4a3:
	text "What are Johto's"
	line "#mon Centers"
	cont "like?"

	para "…Oh, I see. So"
	line "they're not much"

	para "different from the"
	line "ones in Kanto."

	para "I can go to Johto"
	line "without worrying,"
	cont "then!"
	done

UnknownText_0x18a5d3:
	text "I just happened to"
	line "come through Rock"

	para "Tunnel. There was"
	line "some commotion at"
	cont "the Power Plant."
	done

UnknownText_0x18a62e:
	text "Caves collapse"
	line "easily."

	para "Several caves have"
	line "disappeared in the"

	para "past few years,"
	line "like the one out-"
	cont "side Cerulean."

	para "As a pro Hiker,"
	line "that's common"
	cont "knowledge."
	done

UnknownText_0x18a6c5:
	text "Silph Co.'s Head"
	line "Office and the"

	para "Magnet Train Sta-"
	line "tion--they're the"

	para "places to see in"
	line "Saffron."
	done

PokemonJournalSabrinaText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Sabrina!"

	para "People say that"
	line "Sabrina can com-"
	cont "municate with her"

	para "#mon during"
	line "battle without"
	cont "speaking."
	done
