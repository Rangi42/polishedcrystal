OlsteetonUniOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0, 14, OLSTEETON_UNI, 5
	warp_event  0, 15, OLSTEETON_UNI, 6
	warp_event 21, 14, OLSTEETON_UNI, 7
	warp_event 21, 15, OLSTEETON_UNI, 8
	warp_event 10, 17, OLSTEETON_UNI, 9
	warp_event 11, 17, OLSTEETON_UNI, 9
	warp_event 11,  0, OLSTEETON_UNI_DEANS_OFFICE, 1
	; warp_event 17, 15, OLSTEETON_UNI_BREAK_ROOM, 1
	; warp_event  3,  4, OLSTEETON_UNI_PROF_1, 1
	; warp_event 15,  4, OLSTEETON_UNI_PROF_2, 1
	; warp_event 21,  4, OLSTEETON_UNI_PROF_3, 1
	; warp_event 17, 12, OLSTEETON_UNI_PROF_4, 1

	def_coord_events

	def_bg_events
	bg_event 10,  0, BGEVENT_JUMPTEXT, OlsteetonUniOfficeDeansOfficeSignText
	bg_event  2,  4, BGEVENT_JUMPTEXT, OlsteetonUniOfficeProf1SignText
	bg_event 14,  4, BGEVENT_JUMPTEXT, OlsteetonUniOfficeProf2SignText
	bg_event 20,  4, BGEVENT_JUMPTEXT, OlsteetonUniOfficeProf3SignText
	bg_event 16, 12, BGEVENT_JUMPTEXT, OlsteetonUniOfficeProf4SignText
	bg_event  4, 12, BGEVENT_JUMPTEXT, OlsteetonUniOfficeStudentLoungeSignText
	bg_event 17, 15, BGEVENT_JUMPTEXT, OlsteetonUniOfficeLibrarySignText
	bg_event  6,  5, BGEVENT_JUMPTEXT, OlsteetonUniOfficeTrophyCaseSignText
	bg_event 20, 13, BGEVENT_JUMPTEXT, OlsteetonUniOfficeBookshelfText
	bg_event 21, 13, BGEVENT_JUMPTEXT, OlsteetonUniOfficeBookshelfText

	def_object_events
	object_event  0,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeSuperNerdText, -1
	object_event 12,  3, SPRITE_PICNICKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeLassText, -1
	object_event  9,  1, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeCooltrainermText, -1
	object_event 10,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeYoungsterText, -1
	object_event  6, 14, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeChildText, -1
	object_event 16, 15, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficePokefanmText, -1
	object_event 10, 12, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeReceptionistText, -1
	object_event 19, 13, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniOfficeCooltrainerfText, -1

OlsteetonUniOfficeSuperNerdText:
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

OlsteetonUniOfficeLassText:
	text "This place offers"
	line "courses of study"

	para "in everything from"
	line "flower arranging"

	para "to #mon"
	line "psychology!"
	done

OlsteetonUniOfficeCooltrainermText:
	text "Everyone at this"
	line "university is a"
	cont "#mon trainer."

	para "To get offered a"
	line "place here, you"

	para "have to pass a"
	line "series of #mon"
	cont "battling tests."
	done

OlsteetonUniOfficeYoungsterText:
	text "Magikarp is the"
	line "university's mascot"
	cont "#mon."

	para "It's a symbol that"
	line "anybody can aspire"
	cont "to greatness!"
	done

OlsteetonUniOfficeChildText:
	text "Ugh! I can't find"
	line "my next class…"

	para "I'm gonna be late!"
	done

OlsteetonUniOfficePokefanmText:
	text "I'm the janitor!"

	para "Be careful, the"
	line "floor is wet!"
	done

OlsteetonUniOfficeReceptionistText:
	text "Welcome to Celadon"
	line "University!"

	para "Profs and the"
	line "principal's office"
	cont "are down the hall."

	para "The library is to"
	line "your right, the"

	para "student lounge to"
	line "your left."

	para "The cafeteria,"
	line "pool, and nurse's"

	para "office are up-"
	line "stairs."
	done

OlsteetonUniOfficeCooltrainerfText:
	text "I'm studying to be"
	line "a #mon nurse."

	para "With so many spe-"
	line "cies out there,"

	para "it's a steep"
	line "learning curve!"
	done

OlsteetonUniOfficeDeansOfficeSignText:
	text "Dean's Office"
	done

OlsteetonUniOfficeProf1SignText:
	text "W2 Art"
	done

OlsteetonUniOfficeProf2SignText:
	text "W1 History"
	done

OlsteetonUniOfficeProf3SignText:
	text "E1 Science"
	done

OlsteetonUniOfficeProf4SignText:
	text "E2 Battling"
	done

OlsteetonUniOfficeStudentLoungeSignText:
	text "Student Lounge"
	done

OlsteetonUniOfficeLibrarySignText:
	text "Library"
	done

OlsteetonUniOfficeTrophyCaseSignText:
	text "The case is full"
	line "of trophies and"
	cont "medals."
	done

OlsteetonUniOfficeBookshelfText:
	text "There are tons of"
	line "yearbooks here."

	para "Students have"
	line "scribbled all over"
	cont "them."
	done
