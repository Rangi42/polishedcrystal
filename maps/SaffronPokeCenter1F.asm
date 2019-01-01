SaffronPokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, SAFFRON_CITY, 4
	warp_event  6,  7, SAFFRON_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalSabrinaScript

	db 4 ; object events
	pc_nurse_event  5, 1
	object_event 11,  5, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, SaffronPokeCenter1FFisherScript, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FTeacherText, -1
	object_event  8,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FYoungsterText, -1

PokemonJournalSabrinaScript:
	setflag ENGINE_READ_SABRINA_JOURNAL
	thistext

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

SaffronPokeCenter1FFisherScript:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "I just happened to"
	line "come through Rock"

	para "Tunnel. There was"
	line "some commotion at"
	cont "the Power Plant."
	done

.Text2:
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

SaffronPokeCenter1FTeacherText:
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

SaffronPokeCenter1FYoungsterText:
	text "Silph Co.'s Head"
	line "Office and the"

	para "Magnet Train Sta-"
	line "tion--they're the"

	para "places to see in"
	line "Saffron."
	done
