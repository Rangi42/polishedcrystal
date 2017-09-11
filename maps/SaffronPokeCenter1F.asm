SaffronPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SaffronPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 4, SAFFRON_CITY
	warp_def 7, 6, 4, SAFFRON_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalSabrinaScript

.PersonEvents: db 4
	pc_nurse_event 1, 5
	person_event SPRITE_FISHER, 5, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SaffronPokeCenter1FFisherScript, -1
	person_event SPRITE_TEACHER, 4, 2, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FTeacherText, -1
	person_event SPRITE_YOUNGSTER, 4, 8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FYoungsterText, -1

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
