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
	text "Okay class!"
	line "Today we're gonna"
	cont "talk about one"
	cont "of #mon's big-"
	cont "gest mysteries!"

	para "Regional Variants!"
	done

OlsteetonUniClassroomBiologyLassText:
	text "Some #mon have"
	line "different forms"
	cont "even in the"
	cont "same region!"

	para "My mamaw has"
	line "a Castorch to"
	cont "help in her"
	cont "kitchen."

	para "But I hear that"
	line "Rusty's is much"
	cont "different!"
	done

OlsteetonUniClassroomBiologySuperNerdText:
	text "Do you know any-"
	line "thing about"
	cont "Meowth?"

	para "It's evolved to"
	line "have several"
	cont "regional variants!"

	para "We even have our"
	line "own!"
	done

OlsteetonUniClassroomBiologyBlackboardText:
	text "'Variation'"
	line "is written on the"
	cont "blackboard."

	para "'... many things"
	line "can lead to reg-"
	cont "ional variation."

	para "Certain #mon may"
	line "adapt to new env-"
	cont "ironments by"
	cont "evolving in new"
	cont "& unusual ways!'"
	done

OlsteetonUniClassroomBiologyBookshelf1Text:
	text "There's a book!"

	para "It's called"
	line ""The Proper Evolut-"
	cont "ionary Biologist's"
	cont "Compendium of Term-"
	cont "inology & Historic"
	cont "Data-Driven"
	cont "Insights""

	text "..."

	para "Okay, that one is"
	line "a little over your"
	cont "head..."
	done

OlsteetonUniClassroomBiologyBookshelf2Text:
	text "It's a paper writ-"
	line "ten by Prof."
	cont "Pawpaw."

	para ""Biomes &"
	line "Bouffalants:"
	
	para "A Study of BU's"
	line "Head Honcho...""
	done
