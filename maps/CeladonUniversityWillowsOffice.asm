CeladonUniversityWillowsOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_UNIVERSITY_2F, 3
	warp_event  4,  5, CELADON_UNIVERSITY_2F, 3

	def_coord_events

	def_bg_events
	bg_event  0,  0, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	bg_event  1,  0, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	bg_event  2,  1, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf1Text
	bg_event  3,  1, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf2Text
	bg_event  5,  2, BGEVENT_RIGHT, CeladonUniversityWillowsOfficeComputer

	def_object_events
	object_event  0,  2, SPRITE_WILLOW, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeWillowText, -1
	object_event  4,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeScientistText, -1

CeladonUniversityWillowsOfficeWillowText:
	text "Hello there!"
	line "I am Prof.Willow."

	para "I supervise"
	line "Candela, Blanche,"
	cont "and Spark in their"

	para "teaching and re-"
	line "search."

	para "You may run into"
	line "them in classes."

	para "I also study #-"
	line "mon habitats and"
	cont "distribution."

	para "I'm very busy, but"
	line "my excellent"

	para "assistants help"
	line "get work done."
	done

CeladonUniversityWillowsOfficeScientistText:
	text "I get to work as"
	line "Prof.Willow's"
	cont "aide!"

	para "I'm cataloguing"
	line "my observations"
	cont "of Route 7."

	para "Today I saw 42"
	line "Raticate and"
	cont "37 Pidgeotto…"
	cont "and one Vulpix!"
	done

CeladonUniversityWillowsOfficeBlackboardText:
	text "Someone wrote “DO"
	line "NOT ERASE” with"

	para "an arrow toward"
	line "an illegible"
	cont "scrawl…"
	done

CeladonUniversityWillowsOfficeBookshelf1Text:
	text "It's a book about"
	line "ecological niches"

	para "and how #mon"
	line "fit within their"
	cont "environments."
	done

CeladonUniversityWillowsOfficeBookshelf2Text:
	text "It's a promotional"
	line "flyer for the"
	cont "Safari Zone."

	para "Lots of exotic-"
	line "looking #mon"
	cont "adorn it."
	done

CeladonUniversityWillowsOfficeComputer:
	jumpthistext

	text "“#mon Transfer"
	line "System” is on the"
	cont "screen."
	done
