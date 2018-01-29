CeladonUniversityWillowsOffice_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeladonUniversityWillowsOffice_MapEventHeader:
	db 2 ; warps
	warp_def 5, 3, 3, CELADON_UNIVERSITY_2F
	warp_def 5, 4, 3, CELADON_UNIVERSITY_2F

	db 0 ; xy triggers

	db 5 ; signposts
	signpost 0, 0, SIGNPOST_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	signpost 0, 1, SIGNPOST_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	signpost 1, 2, SIGNPOST_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf1Text
	signpost 1, 3, SIGNPOST_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf2Text
	signpost 2, 5, SIGNPOST_RIGHT, CeladonUniversityWillowsOfficeComputer

	db 2 ; person events
	person_event SPRITE_WILLOW, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeWillowText, -1
	person_event SPRITE_SCIENTIST, 3, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeScientistText, -1

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
	thistext

	text "“Pokemon Transfer"
	line "System” is on the"
	cont "screen."
	done
