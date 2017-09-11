CeladonUniversity1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversity1F_MapEventHeader:

.Warps: db 10
	warp_def 19, 14, 13, CELADON_CITY
	warp_def 19, 15, 13, CELADON_CITY
	warp_def 12, 25, 1, CELADON_UNIVERSITY_2F
	warp_def 12, 21, 1, CELADON_UNIVERSITY_LIBRARY_1F
	warp_def 0, 15, 1, CELADON_UNIVERSITY_PRINCIPALS_OFFICE
	warp_def 4, 3, 1, CELADON_UNIVERSITY_CLASSROOM_1
	warp_def 4, 9, 1, CELADON_UNIVERSITY_CLASSROOM_2
	warp_def 4, 21, 1, CELADON_UNIVERSITY_CLASSROOM_3
	warp_def 4, 27, 1, CELADON_UNIVERSITY_CLASSROOM_4
	warp_def 12, 3, 1, CELADON_UNIVERSITY_LOUNGE

.XYTriggers: db 0

.Signposts: db 13
	signpost 0, 14, SIGNPOST_JUMPTEXT, CeladonUniversity1FPrincipalsOfficeSignText
	signpost 4, 2, SIGNPOST_JUMPTEXT, CeladonUniversity1FClassroom1SignText
	signpost 4, 8, SIGNPOST_JUMPTEXT, CeladonUniversity1FClassroom2SignText
	signpost 4, 20, SIGNPOST_JUMPTEXT, CeladonUniversity1FClassroom3SignText
	signpost 4, 26, SIGNPOST_JUMPTEXT, CeladonUniversity1FClassroom4SignText
	signpost 12, 2, SIGNPOST_JUMPTEXT, CeladonUniversity1FStudentLoungeSignText
	signpost 12, 20, SIGNPOST_JUMPTEXT, CeladonUniversity1FLibrarySignText
	signpost 5, 22, SIGNPOST_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	signpost 5, 23, SIGNPOST_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	signpost 13, 6, SIGNPOST_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	signpost 13, 7, SIGNPOST_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	signpost 13, 26, SIGNPOST_JUMPTEXT, CeladonUniversity1FBookshelfText
	signpost 13, 27, SIGNPOST_JUMPTEXT, CeladonUniversity1FBookshelfText

.PersonEvents: db 8
	person_event SPRITE_SUPER_NERD, 5, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FSuperNerdText, -1
	person_event SPRITE_LASS, 4, 16, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FLassText, -1
	person_event SPRITE_COOLTRAINER_M, 5, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainermText, -1
	person_event SPRITE_YOUNGSTER, 9, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FYoungsterText, -1
	person_event SPRITE_CHILD, 15, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FChildText, -1
	person_event SPRITE_POKEFAN_M, 15, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, -1, (1 << NITE), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FPokefanmText, -1
	person_event SPRITE_RECEPTIONIST, 14, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FReceptionistText, -1
	person_event SPRITE_COOLTRAINER_F, 13, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainerfText, -1

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
