OlsteetonUniClassroomBiology_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 3
	warp_event  6,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 3

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBiologyBlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBiologyBlackboardText
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBiologyBlackboardText
	bg_event  0,  1, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBiologyBookshelf1Text
	bg_event  1,  1, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBiologyBookshelf2Text

	def_object_events
	object_event  3,  2, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBiologyTeacherText, -1
	object_event  3,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBiologyLassText, -1
	object_event  8,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBiologySuperNerdText, -1


OlsteetonUniClassroomBiologyTeacherText:
	text "...So you see"
	line "some #mon"

	para "have changed"
	line "as a result of"
	cont "living in diff-"
	cont "erent habitats."
	done

OlsteetonUniClassroomBiologyLassText:
	text "My instructor said"
	line "that Magneton is a"

	para "union of three"
	line "Magnemite, but"

	para "Magneton is 10"
	line "times heavier than"
	cont "Magnemite."

	para "How does that"
	line "work?!"
	done

OlsteetonUniClassroomBiologySuperNerdText:
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

OlsteetonUniClassroomBiologyBlackboardText:
	text "'Phylogenetics'"
	line "is on the board."

	para "“…#mon can be"
	line "divided into 14"
	cont "“Egg groups”,"
	cont "plus Ditto."

	para "Baby #mon can-"
	line "not breed."

	para "Legendary #mon"
	line "have not been"
	cont "studied.”"
	done

OlsteetonUniClassroomBiologyBookshelf1Text:
	text "It's a book of"
	line "prototype designs"

	para "for technological"
	line "devices."

	para "Hey! An early"
	line "#gear diagram"
	cont "is in here!"
	done

OlsteetonUniClassroomBiologyBookshelf2Text:
	text "It's a paper writ-"
	line "ten by Prof."
	cont "Silktree."

	para "“Ruins of Alph"
	line "Investigation"
	cont "Report”…"
	done
