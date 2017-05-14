const_value set 2
	const CELADONUNIVERSITYCLASSROOM2_TEACHER
	const CELADONUNIVERSITYCLASSROOM2_YOUNGSTER
	const CELADONUNIVERSITYCLASSROOM2_CHILD
	const CELADONUNIVERSITYCLASSROOM2_FISHER
	const CELADONUNIVERSITYCLASSROOM2_COOLTRAINER_M

CeladonUniversityClassroom2_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityClassroom2TeacherScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom2YoungsterScript:
	jumptextfaceplayer .Text

.Text:
	text "Flipping through"
	line "my notes at the"
	cont "speed of--YOW!"
	cont "Paper cut…"
	done

CeladonUniversityClassroom2ChildScript:
	jumptextfaceplayer .Text

.Text:
	text "We just had a"
	line "lecture on Prof."

	para "Westwood's contri-"
	line "butions to the"
	cont "#dex."

	para "I heard that"
	line "towards the end"

	para "he got lazy and"
	line "just made some of"
	cont "it up!"
	done

CeladonUniversityClassroom2FisherScript:
	jumptextfaceplayer .Text

.Text:
	text "Back in the day,"
	line "even Prof.Oak used"
	cont "to teach here."
	done

CeladonUniversityClassroom2CooltrainermScript:
	opentext
	writetext .Text1
	waitbutton
	closetext
	faceplayer
	opentext
	writetext .Text2
	waitbutton
	closetext
	spriteface CELADONUNIVERSITYCLASSROOM2_COOLTRAINER_M, UP
	end

.Text1:
	text "…Zzz…"
	line "Aah!"
	done

.Text2:
	text "Ahem."

	para "Sorry about that--"
	line "you startled me."

	para "I stayed up late"
	line "to finish an"

	para "assignment, so now"
	line "I'm exhausted."
	done

CeladonUniversityClassroom2Blackboard:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom2Bookshelf:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityClassroom2_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 7, CELADON_UNIVERSITY_1F
	warp_def $b, $3, 7, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 0, 2, SIGNPOST_READ, CeladonUniversityClassroom2Blackboard
	signpost 0, 3, SIGNPOST_READ, CeladonUniversityClassroom2Blackboard
	signpost 0, 4, SIGNPOST_READ, CeladonUniversityClassroom2Blackboard
	signpost 1, 6, SIGNPOST_READ, CeladonUniversityClassroom2Bookshelf
	signpost 1, 7, SIGNPOST_READ, CeladonUniversityClassroom2Bookshelf

.PersonEvents:
	db 5
	person_event SPRITE_TEACHER, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2TeacherScript, -1
	person_event SPRITE_YOUNGSTER, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2YoungsterScript, -1
	person_event SPRITE_CHILD, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2ChildScript, -1
	person_event SPRITE_FISHER, 7, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2FisherScript, -1
	person_event SPRITE_COOLTRAINER_M, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2CooltrainermScript, -1
