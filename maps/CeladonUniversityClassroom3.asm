const_value set 2
	const CELADONUNIVERSITYCLASSROOM3_TEACHER
	const CELADONUNIVERSITYCLASSROOM3_CHILD
	const CELADONUNIVERSITYCLASSROOM3_LASS
	const CELADONUNIVERSITYCLASSROOM3_SUPER_NERD

CeladonUniversityClassroom3_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityClassroom3TeacherScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom3ChildScript:
	jumptextfaceplayer .Text

.Text:
	text "#mon inside"
	line "# Balls are"

	para "converted to light"
	line "energy, then"

	para "changed back to"
	line "matter when they're"
	cont "sent out."

	para "Don't worry, it"
	line "doesn't hurt them"
	cont "one bit!"
	done

CeladonUniversityClassroom3LassScript:
	jumptextfaceplayer .Text

.Text:
	text "My professor said"
	line "that Magneton is a"

	para "union of three"
	line "Magnemite, but"

	para "Magneton is 10"
	line "times heavier than"
	cont "Magnemite."

	para "How does that"
	line "work?!"
	done

CeladonUniversityClassroom3Super_nerdScript:
	jumptextfaceplayer .Text

.Text:
	text "Have you heard of"
	line "the Electric-type"
	cont "#mon Mareep?"

	para "Its name derives"
	line "from the unit of"

	para "electric current,"
	line "the “ampere.”"

	para "Rearrange the"
	line "letters, and"
	cont "you'll see!"
	done

CeladonUniversityClassroom3Blackboard:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom3Bookshelf:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom3_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 8, CELADON_UNIVERSITY_1F
	warp_def $b, $3, 8, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 0, 2, SIGNPOST_READ, CeladonUniversityClassroom3Blackboard
	signpost 0, 3, SIGNPOST_READ, CeladonUniversityClassroom3Blackboard
	signpost 0, 4, SIGNPOST_READ, CeladonUniversityClassroom3Blackboard
	signpost 1, 6, SIGNPOST_READ, CeladonUniversityClassroom3Bookshelf
	signpost 1, 7, SIGNPOST_READ, CeladonUniversityClassroom3Bookshelf

.PersonEvents:
	db 4
	person_event SPRITE_TEACHER, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom3TeacherScript, -1
	person_event SPRITE_CHILD, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom3ChildScript, -1
	person_event SPRITE_LASS, 7, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom3LassScript, -1
	person_event SPRITE_SUPER_NERD, 7, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom3Super_nerdScript, -1
