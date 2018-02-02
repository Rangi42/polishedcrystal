CeladonUniversityPrincipalsOffice_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CELADON_UNIVERSITY_1F, 5
	warp_event  3,  7, CELADON_UNIVERSITY_1F, 5

	db 0 ; coord events

	db 4 ; bg events
	bg_event  2,  0, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost1Text
	bg_event  3,  0, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost2Text
	bg_event  5,  4, SIGNPOST_RIGHT, CeladonUniversityPrincipalsOfficeComputer
	bg_event  1,  1, SIGNPOST_JUMPTEXT, CeladonUniversityPrincipalsOfficeBookshelfText

	db 1 ; object events
	object_event  2,  2, SPRITE_MATSUMOTO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityPrincipalsOfficeMatsumotoScript, -1

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
