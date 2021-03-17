CeladonUniversity1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 14, 19, CELADON_CITY, 13
	warp_event 15, 19, CELADON_CITY, 13
	warp_event 25, 12, CELADON_UNIVERSITY_2F, 1
	warp_event 21, 12, CELADON_UNIVERSITY_LIBRARY_1F, 1
	warp_event 15,  0, CELADON_UNIVERSITY_PRINCIPALS_OFFICE, 1
	warp_event  3,  4, CELADON_UNIVERSITY_CLASSROOM_1, 1
	warp_event  9,  4, CELADON_UNIVERSITY_CLASSROOM_2, 1
	warp_event 21,  4, CELADON_UNIVERSITY_CLASSROOM_3, 1
	warp_event 27,  4, CELADON_UNIVERSITY_CLASSROOM_4, 1
	warp_event  3, 12, CELADON_UNIVERSITY_LOUNGE, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, CeladonUniversity1FPrincipalsOfficeSignText
	bg_event  2,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom1SignText
	bg_event  8,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom2SignText
	bg_event 20,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom3SignText
	bg_event 26,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom4SignText
	bg_event  2, 12, BGEVENT_JUMPTEXT, CeladonUniversity1FStudentLoungeSignText
	bg_event 20, 12, BGEVENT_JUMPTEXT, CeladonUniversity1FLibrarySignText
	bg_event 22,  5, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event 23,  5, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event  6, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event  7, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event 26, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FBookshelfText
	bg_event 27, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FBookshelfText

	def_object_events
	object_event  6,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FSuperNerdText, -1
	object_event 16,  4, SPRITE_PICNICKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FLassText, -1
	object_event 25,  5, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainermText, -1
	object_event 13,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FYoungsterText, -1
	object_event  4, 15, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FChildText, -1
	object_event  6, 15, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, -1, (1 << EVE) | (1 << NITE), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FPokefanmText, -1
	object_event 14, 14, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FReceptionistText, -1
	object_event 23, 13, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainerfText, -1

CeladonUniversity1FSuperNerdText:
	text "Some academics be-"
	line "lieve there are"

	para "other universes"
	line "parallel to this"
	cont "one."

	para "Does that mean"
	line "there's a universe"

	para "without any"
	line "#mon?"

	para "That would be"
	line "tragic!"
	done

CeladonUniversity1FLassText:
	text "This place offers"
	line "courses of study"

	para "in everything from"
	line "flower arranging"

	para "to #mon"
	line "psychology!"
	done

CeladonUniversity1FCooltrainermText:
	text "Everyone at this"
	line "university is a"
	cont "#mon trainer."

	para "To get offered a"
	line "place here, you"

	para "have to pass a"
	line "series of #mon"
	cont "battling tests."
	done

CeladonUniversity1FYoungsterText:
	text "Magikarp is the"
	line "university's mascot"
	cont "#mon."

	para "It's a symbol that"
	line "anybody can aspire"
	cont "to greatness!"
	done

CeladonUniversity1FChildText:
	text "Ugh! I can't find"
	line "my next class…"

	para "I'm gonna be late!"
	done

CeladonUniversity1FPokefanmText:
	text "I'm the janitor!"

	para "Be careful, the"
	line "floor is wet!"
	done

CeladonUniversity1FReceptionistText:
	text "Welcome to Celadon"
	line "University!"

	para "Classrooms and the"
	line "principal's office"
	cont "are down the hall."

	para "The library is to"
	line "your right, the"

	para "student lounge to"
	line "your left."

	para "The cafeteria,"
	line "pool, and faculty"

	para "offices are up-"
	line "stairs."
	done

CeladonUniversity1FCooltrainerfText:
	text "I'm studying to be"
	line "a #mon nurse."

	para "With so many spe-"
	line "cies out there,"

	para "it's a steep"
	line "learning curve!"
	done

CeladonUniversity1FPrincipalsOfficeSignText:
	text "Principal's Office"
	done

CeladonUniversity1FClassroom1SignText:
	text "W2 Art"
	done

CeladonUniversity1FClassroom2SignText:
	text "W1 History"
	done

CeladonUniversity1FClassroom3SignText:
	text "E1 Science"
	done

CeladonUniversity1FClassroom4SignText:
	text "E2 Battling"
	done

CeladonUniversity1FStudentLoungeSignText:
	text "Student Lounge"
	done

CeladonUniversity1FLibrarySignText:
	text "Library"
	done

CeladonUniversity1FTrophyCaseSignText:
	text "The case is full"
	line "of trophies and"
	cont "medals."
	done

CeladonUniversity1FBookshelfText:
	text "There are tons of"
	line "yearbooks here."

	para "Students have"
	line "scribbled all over"
	cont "them."
	done
