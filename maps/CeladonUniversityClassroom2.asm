CeladonUniversityClassroom2_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityClassroom2_MapEventHeader:

.Warps: db 2
	warp_def 11, 2, 7, CELADON_UNIVERSITY_1F
	warp_def 11, 3, 7, CELADON_UNIVERSITY_1F

.XYTriggers: db 0

.Signposts: db 5
	signpost 0, 2, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom2BlackboardText
	signpost 0, 3, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom2BlackboardText
	signpost 0, 4, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom2BlackboardText
	signpost 1, 6, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom2Bookshelf1Text
	signpost 1, 7, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom2Bookshelf2Text

.PersonEvents: db 5
	person_event SPRITE_BLANCHE, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom2BlancheText, EVENT_CELADON_UNIVERSITY_BLANCHE
	person_event SPRITE_TEACHER, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom2TeacherText, EVENT_SHAMOUTI_COAST_BLANCHE
	person_event SPRITE_YOUNGSTER, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom2YoungsterText, -1
	person_event SPRITE_CHILD, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom2ChildText, -1
	person_event SPRITE_LADY, 7, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom2LadyText, -1
	person_event SPRITE_COOLTRAINER_M, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom2CooltrainermScript, -1

CeladonUniversityClassroom2BlancheText:
	text "I am Blanche."
	line "I teach History"
	cont "here."

	para "We must learn from"
	line "history, or we"

	para "will be doomed to"
	line "repeat it."
	done

CeladonUniversityClassroom2TeacherText:
	text "I'm afraid Blanche"
	line "isn't available."

	para "I'm the substitute"
	line "until they return"

	para "from an errand on"
	line "Shamouti Island."
	done

CeladonUniversityClassroom2YoungsterText:
	text "Flipping through"
	line "my notes at the"
	cont "speed of--YOW!"
	cont "Paper cut…"
	done

CeladonUniversityClassroom2ChildText:
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

CeladonUniversityClassroom2LadyText:
	text "You're from Johto?"
	line "That region has"

	para "such fascinating"
	line "history!"
	done

CeladonUniversityClassroom2CooltrainermScript:
	showtext .Text1
	showtextfaceplayer .Text2
	spriteface LAST_TALKED, UP
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

CeladonUniversityClassroom2BlackboardText:
	text "There's a timeline"
	line "of recent history."

	para "400 years ago:"
	line "Toxic move invent-"
	cont "ed."

	para "71 years ago:"
	line "modern # Ball"
	cont "developed."

	para "27 years ago:"
	line "first Moon land-"
	cont "ing."

	para "Three years ago:"
	line "first virtual"
	cont "#mon created."

	para "“Hypothesis: tech-"
	line "nology grows expo-"
	cont "nentially.”"
	done

CeladonUniversityClassroom2Bookshelf1Text:
	text "It's a book about"
if DEF(FAITHFUL)
	line "how the Brass"
	cont "Tower in Ecruteak"

	para "City burned down"
	line "150 years ago."
else
	line "how the Gong Tower"
	cont "in Ecruteak City"

	para "burned down 150"
	line "years ago."
endc
	done

CeladonUniversityClassroom2Bookshelf2Text:
	text "It's a book of"
	line "slang terms from"
	cont "the 1980s."
	cont "Heavy!"
	done
