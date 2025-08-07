OlsteetonUniScienceCenter_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, OLSTEETON_UNI, 4
	warp_event  6,  9, OLSTEETON_UNI, 4
	warp_event  1,  0, OLSTEETON_UNI_NURSE_DEPT, 1
	warp_event 11,  0, OLSTEETON_UNI_WATER_LAB, 1



	def_coord_events

	def_bg_events
	bg_event  0,  0, BGEVENT_READ, OlsteetonUniScienceCenterNurseText
	bg_event  8,  1, BGEVENT_JUMPTEXT, OlsteetonUniScienceCenterBookshelf1Text
	bg_event  9,  1, BGEVENT_JUMPTEXT, OlsteetonUniScienceCenterBookshelf2Text
	bg_event 10,  0, BGEVENT_RIGHT, OlsteetonUniScienceCenterLabText
	bg_event  8,  4, BGEVENT_RIGHT, OlsteetonUniScienceCenterComputer

	def_object_events
	object_event 11,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniScienceCenterScientistText, -1
	object_event  5,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniScienceCenterTwin1Text, -1
	object_event  5,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniScienceCenterTwin2Text, -1

OlsteetonUniScienceCenterScientistText:
	text "The Hyper Test is"
	line "a rite of passage"

	para "for all Celadon"
	line "University grad-"
	cont "uates."

	para "It tests all of"
	line "their faculties to"
	cont "the utmost!"
	done

OlsteetonUniScienceCenterTwin1Text:
	text "I'll pass the Hyper"
	line "Test before you!"
	done

OlsteetonUniScienceCenterTwin2Text:
	text "No, I'll pass the"
	line "Hyper Test before"
	cont "you!"
	done

OlsteetonUniScienceCenterNurseText:
	text "#mon Nursing"
	line "Department"
	done

OlsteetonUniScienceCenterBookshelf1Text:
	text "This book has a"
	line "bookmark in it."

	para "Someone's not done"
	line "with it yet!"
	done

OlsteetonUniScienceCenterBookshelf2Text:
	text "It's a copy of"
	line "Nintendo Power!"

	para "A Pikachu picture"
	line "fills the front"
	cont "cover."
	done

OlsteetonUniScienceCenterComputer:
	jumpthistext

	text "There's a file on"
	line "the desktop named"
	cont "questions.txt."

	para "Better not cheat!"
	done

OlsteetonUniScienceCenterLabText:
	text "Aquatic Lab"
	done