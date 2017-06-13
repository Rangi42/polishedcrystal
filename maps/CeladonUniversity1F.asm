const_value set 2
	const CELADONUNIVERSITY1F_SUPER_NERD
	const CELADONUNIVERSITY1F_LASS
	const CELADONUNIVERSITY1F_COOLTRAINER_M
	const CELADONUNIVERSITY1F_YOUNGSTER
	const CELADONUNIVERSITY1F_CHILD
	const CELADONUNIVERSITY1F_POKEFAN_M
	const CELADONUNIVERSITY1F_RECEPTIONIST
	const CELADONUNIVERSITY1F_COOLTRAINER_F

CeladonUniversity1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversity1FSuperNerdScript:
	jumptextfaceplayer .Text

.Text:
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

CeladonUniversity1FLassScript:
	jumptextfaceplayer .Text

.Text:
	text "This place offers"
	line "courses of study"

	para "in everything from"
	line "flower arranging"

	para "to #mon"
	line "psychology!"
	done

CeladonUniversity1FCooltrainermScript:
	jumptextfaceplayer .Text

.Text:
	text "Everyone at this"
	line "university is a"
	cont "#mon trainer."

	para "To get offered a"
	line "place here, you"

	para "have to pass a"
	line "series of #mon"
	cont "battling tests."
	done

CeladonUniversity1FYoungsterScript:
	jumptextfaceplayer .Text

.Text:
	text "Magikarp is the"
	line "university's mascot"
	cont "#mon."

	para "It's a symbol that"
	line "anybody can aspire"
	cont "to greatness!"
	done

CeladonUniversity1FChildScript:
	jumptextfaceplayer .Text

.Text:
	text "Ugh! I can't find"
	line "my next class…"

	para "I'm gonna be late!"
	done

CeladonUniversity1FPokefanmScript:
	jumptextfaceplayer .Text

.Text:
	text "I'm the janitor!"

	para "Be careful, the"
	line "floor is wet!"
	done

CeladonUniversity1FReceptionistScript:
	jumptextfaceplayer .Text

.Text:
	text "Welcome to Celadon"
	line "University!"

	para "Classrooms and the"
	line "dean's office are"
	cont "straight ahead."

	para "The library is to"
	line "your right, the"

	para "student lounge to"
	line "your left."

	para "The cafeteria,"
	line "pool, and faculty"

	para "offices are up-"
	line "stairs."
	done

CeladonUniversity1FCooltrainerfScript:
	jumptextfaceplayer .Text

.Text:
	text "I'm studying to be"
	line "a #mon nurse."

	para "With so many spe-"
	line "cies out there,"

	para "it's a steep"
	line "learning curve!"
	done

CeladonUniversity1FDeansOfficeSign:
	jumptext .Text

.Text:
	text "Dean's Office"
	done

CeladonUniversity1FClassroom1Sign:
	jumptext .Text

.Text:
	text "W2 Art"
	done

CeladonUniversity1FClassroom2Sign:
	jumptext .Text

.Text:
	text "W1 History"
	done

CeladonUniversity1FClassroom3Sign:
	jumptext .Text

.Text:
	text "E1 Science"
	done

CeladonUniversity1FClassroom4Sign:
	jumptext .Text

.Text:
	text "E2 Battling"
	done

CeladonUniversity1FStudentLoungeSign:
	jumptext .Text

.Text:
	text "Student Lounge"
	done

CeladonUniversity1FLibrarySign:
	jumptext .Text

.Text:
	text "Library"
	done

CeladonUniversity1FTrophyCaseSign:
	jumptext .Text

.Text:
	text "The case is full"
	line "of trophies and"
	cont "medals."
	done

CeladonUniversity1FBookshelf:
	jumptext .Text

.Text:
	text "There are tons of"
	line "yearbooks here."

	para "Students have"
	line "scribbled all over"
	cont "them."
	done

CeladonUniversity1F_MapEventHeader:
.Warps:
	db 10
	warp_def $13, $e, 13, CELADON_CITY
	warp_def $13, $f, 13, CELADON_CITY
	warp_def $c, $19, 1, CELADON_UNIVERSITY_2F
	warp_def $c, $15, 1, CELADON_UNIVERSITY_LIBRARY_1F
	warp_def $0, $f, 1, CELADON_UNIVERSITY_DEANS_OFFICE
	warp_def $4, $3, 1, CELADON_UNIVERSITY_CLASSROOM_1
	warp_def $4, $9, 1, CELADON_UNIVERSITY_CLASSROOM_2
	warp_def $4, $15, 1, CELADON_UNIVERSITY_CLASSROOM_3
	warp_def $4, $1b, 1, CELADON_UNIVERSITY_CLASSROOM_4
	warp_def $c, $3, 1, CELADON_UNIVERSITY_LOUNGE

.XYTriggers:
	db 0

.Signposts:
	db 13
	signpost 0, 14, SIGNPOST_READ, CeladonUniversity1FDeansOfficeSign
	signpost 4, 2, SIGNPOST_READ, CeladonUniversity1FClassroom1Sign
	signpost 4, 8, SIGNPOST_READ, CeladonUniversity1FClassroom2Sign
	signpost 4, 20, SIGNPOST_READ, CeladonUniversity1FClassroom3Sign
	signpost 4, 26, SIGNPOST_READ, CeladonUniversity1FClassroom4Sign
	signpost 12, 2, SIGNPOST_READ, CeladonUniversity1FStudentLoungeSign
	signpost 12, 20, SIGNPOST_READ, CeladonUniversity1FLibrarySign
	signpost 5, 22, SIGNPOST_READ, CeladonUniversity1FTrophyCaseSign
	signpost 5, 23, SIGNPOST_READ, CeladonUniversity1FTrophyCaseSign
	signpost 13, 6, SIGNPOST_READ, CeladonUniversity1FTrophyCaseSign
	signpost 13, 7, SIGNPOST_READ, CeladonUniversity1FTrophyCaseSign
	signpost 13, 26, SIGNPOST_READ, CeladonUniversity1FBookshelf
	signpost 13, 27, SIGNPOST_READ, CeladonUniversity1FBookshelf

.PersonEvents:
	db 8
	person_event SPRITE_SUPER_NERD, 5, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FSuperNerdScript, -1
	person_event SPRITE_LASS, 4, 16, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FLassScript, -1
	person_event SPRITE_COOLTRAINER_M, 5, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FCooltrainermScript, -1
	person_event SPRITE_YOUNGSTER, 9, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FYoungsterScript, -1
	person_event SPRITE_CHILD, 15, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FChildScript, -1
	person_event SPRITE_POKEFAN_M, 15, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, -1, (1 << NITE), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FPokefanmScript, -1
	person_event SPRITE_RECEPTIONIST, 14, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FReceptionistScript, -1
	person_event SPRITE_COOLTRAINER_F, 13, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversity1FCooltrainerfScript, -1
