OlsteetonUniDeansOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, OLSTEETON_UNI_OFFICE, 7
	warp_event  5,  7, OLSTEETON_UNI_OFFICE, 7

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniDeansOfficeSignpost1Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, OlsteetonUniDeansOfficeSignpost2Text
	bg_event  6,  2, BGEVENT_RIGHT, OlsteetonUniDeansOfficeComputer
	bg_event  1,  1, BGEVENT_JUMPTEXT, OlsteetonUniDeansOfficeBookshelfText

	def_object_events
	object_event  4,  2, SPRITE_MATSUMOTO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonUniDeansOfficeMatsumotoScript, -1
	object_event  0,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, DeansOfficeReceptionistText, -1


OlsteetonUniDeansOfficeMatsumotoScript:
	checkevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse_endtext
	setevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	jumpthisopenedtext

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

	para "I am Dean"
	line "Matsumoto."

	para "I'm the principal"
	line "of Bouffalant"
	cont "Academy."

	para "But you can call"
	line "me your pal!"

	para "Here, have some"
	line "candy from my"
	cont "desk stash."
	done

OlsteetonUniDeansOfficeSignpost1Text:
	text "It's Prof.Matsu-"
	line "moto's degree in"
	cont "Education."
	done

OlsteetonUniDeansOfficeSignpost2Text:
	text "It's a picture of"
	line "Prof.Matsumoto in"

	para "front of a grad-"
	line "uating class."
	done

OlsteetonUniDeansOfficeComputer:
	jumpthistext

	text "There's a draft"
	line "email asking"

	para "alumni for"
	line "donations."
	done

OlsteetonUniDeansOfficeBookshelfText:
	text "It's a complete set"
	line "of books of the"

	para "Encyclopedia"
	line "#monica."
	done

DeansOfficeReceptionistText:
	text "Do you have"
	line "an appoint-"
	cont "ment?"
	done