CeladonUniversityPrincipalsOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityPrincipalsOffice_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 5, CELADON_UNIVERSITY_1F
	warp_def 7, 3, 5, CELADON_UNIVERSITY_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 0, 2, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost1Text
	signpost 0, 3, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost2Text
	signpost 4, 5, SIGNPOST_RIGHT, CeladonUniversityPrincipalsOfficeComputer
	signpost 1, 1, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeBookshelfText

.PersonEvents: db 1
	person_event SPRITE_MATSUMOTO, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityPrincipalsOfficeMatsumotoScript, -1

CeladonUniversityPrincipalsOfficeMatsumotoScript:
	checkevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem RARE_CANDY
	iffalse_endtext
	setevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	thisopenedtext

.Text2:
	text "I work hard to"
	line "keep this place"
	cont "running smoothly,"

	para "so I unwind with"
	line "candy every now"
	cont "and then."
	done

.Text1:
	text "Hello there,"
	line "young trainer!"

	para "I am Professor"
	line "Matsumoto."

	para "I'm the principal"
	line "of Celadon Uni-"
	cont "versity."

	para "But you can call"
	line "me your pal!"

	para "Here, have some"
	line "candy from my"
	cont "desk stash."
	done

CeladonUniversityPrincipalsOfficeSignpost1Text:
	text "It's Prof.Matsu-"
	line "moto's degree in"
	cont "Education."
	done

CeladonUniversityPrincipalsOfficeSignpost2Text:
	text "It's a picture of"
	line "Prof.Matsumoto in"

	para "front of a grad-"
	line "uating class."
	done

CeladonUniversityPrincipalsOfficeComputer:
	thistext

	text "There's a draft"
	line "email asking"

	para "alumni for"
	line "donations."
	done

CeladonUniversityPrincipalsOfficeBookshelfText:
	text "It's a complete set"
	line "of books of the"

	para "Encyclopedia"
	line "#monica."
	done
