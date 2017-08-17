CeladonUniversityDeansOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityDeansOffice_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 5, CELADON_UNIVERSITY_1F
	warp_def 7, 3, 5, CELADON_UNIVERSITY_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 0, 2, SIGNPOST_JUMPTEXT, CeladonUniversityDeansOfficeSignpost1Text
	signpost 0, 3, SIGNPOST_JUMPTEXT, CeladonUniversityDeansOfficeSignpost2Text
	signpost 4, 5, SIGNPOST_RIGHT, CeladonUniversityDeansOfficeComputer
	signpost 1, 1, SIGNPOST_JUMPTEXT, CeladonUniversityDeansOfficeBookshelfText

.PersonEvents: db 1
	person_event SPRITE_DEAN, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityDeansOfficeDeanText, -1

CeladonUniversityDeansOfficeDeanText:
	text "How-dean there,"
	line "young trainer!"

	para "I'm the Dean of"
	line "Celadon Univers-"
	cont "ity."

	para "I keep this place"
	line "running smoothly."

	para "I'm a lean, mean,"
	line "deaning machine!"
	done

CeladonUniversityDeansOfficeSignpost1Text:
	text "It's the Dean's"
	line "graduate degree"
	cont "in Education."
	done

CeladonUniversityDeansOfficeSignpost2Text:
	text "It's a picture of"
	line "the Dean in what"

	para "must be a Hallo-"
	line "ween costume."
	done

CeladonUniversityDeansOfficeComputer:
	thistext

	text "There's a draft"
	line "email asking"

	para "alumni for"
	line "donations."
	done

CeladonUniversityDeansOfficeBookshelfText:
	text "It's a complete set"
	line "of books of the"

	para "Encyclopedia"
	line "#monica."
	done
