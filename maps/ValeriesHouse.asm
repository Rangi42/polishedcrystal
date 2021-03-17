ValeriesHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, SetupValerieAfterMorningWalkScript

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 12
	warp_event  4,  7, ECRUTEAK_CITY, 12

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  2,  3, SPRITE_VALERIE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ValeriesHouseValerieText, EVENT_VALERIE_ECRUTEAK_CITY
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseRedFairyBookText, EVENT_RED_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseBlueFairyBookText, EVENT_BLUE_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseGreenFairyBookText, EVENT_GREEN_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseBrownFairyBookText, EVENT_BROWN_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseVioletFairyBookText, EVENT_VIOLET_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, ValeriesHousePinkFairyBookText, EVENT_PINK_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptext, ValeriesHouseYellowFairyBookText, EVENT_YELLOW_FAIRY_BOOK

	object_const_def
	const VALERIESHOUSE_VALERIE
	const VALERIESHOUSE_RED_FAIRY_BOOK
	const VALERIESHOUSE_BLUE_FAIRY_BOOK
	const VALERIESHOUSE_GREEN_FAIRY_BOOK
	const VALERIESHOUSE_BROWN_FAIRY_BOOK
	const VALERIESHOUSE_VIOLET_FAIRY_BOOK
	const VALERIESHOUSE_PINK_FAIRY_BOOK
	const VALERIESHOUSE_YELLOW_FAIRY_BOOK

SetupValerieAfterMorningWalkScript:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse .Disappear
	checkevent EVENT_BEAT_VALERIE
	iffalse .Disappear
	checkflag ENGINE_VALERIE_MORNING_WALK
	iftrue .Appear
	checktime 1 << MORN
	iffalse .Appear
.Disappear:
	disappear VALERIESHOUSE_VALERIE
	sjump SetupFairyBookScript

.Appear
	appear VALERIESHOUSE_VALERIE
	sjump SetupFairyBookScript

SetupFairyBookScript:
	disappear VALERIESHOUSE_RED_FAIRY_BOOK
	disappear VALERIESHOUSE_BLUE_FAIRY_BOOK
	disappear VALERIESHOUSE_GREEN_FAIRY_BOOK
	disappear VALERIESHOUSE_BROWN_FAIRY_BOOK
	disappear VALERIESHOUSE_VIOLET_FAIRY_BOOK
	disappear VALERIESHOUSE_PINK_FAIRY_BOOK
	disappear VALERIESHOUSE_YELLOW_FAIRY_BOOK
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday
.Sunday
	appear VALERIESHOUSE_PINK_FAIRY_BOOK
	endcallback
.Monday
	appear VALERIESHOUSE_BROWN_FAIRY_BOOK
	endcallback
.Tuesday
	appear VALERIESHOUSE_RED_FAIRY_BOOK
	endcallback
.Wednesday
	appear VALERIESHOUSE_BLUE_FAIRY_BOOK
	endcallback
.Thursday
	appear VALERIESHOUSE_GREEN_FAIRY_BOOK
	endcallback
.Friday
	appear VALERIESHOUSE_YELLOW_FAIRY_BOOK
	endcallback
.Saturday
	appear VALERIESHOUSE_VIOLET_FAIRY_BOOK
	endcallback

ValeriesHouseValerieText:
	text "Valerie: My"
	line "fashion designs"

	para "are said to be"
	line "rather mystifying."
	cont "Do you agree with"
	cont "that?"

	para "I've always wanted"
	line "to be a #mon,"
	cont "you see."

	para "That desire is my"
	line "inspiration and"

	para "what I try to"
	line "achieve by"
	cont "designing."

	para "And yet… the only"
	line "time I feel truly"

	para "one with #mon"
	line "is when we are"

	para "embroiled in"
	line "desperate battle."

	para "I wonder why that"
	line "is…"
	done

ValeriesHouseRedFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A girl with very"
	line "long hair is lock-"
	cont "ed in a tower…"
	done

ValeriesHouseBlueFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A beautiful girl"
	line "is talking to a"
	cont "horse's head…"
	done

ValeriesHouseGreenFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A talking fish"
	line "claims that it can"
	cont "grant wishes…"
	done

ValeriesHouseBrownFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A peasant's house"
	line "has become a fine"
	cont "palace overnight…"
	done

ValeriesHouseVioletFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A dog digs in the"
	line "garden and finds"
	cont "golden treasure…"
	done

ValeriesHousePinkFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A man is being"
	line "led by a turtle"
	cont "under the sea…"
	done

ValeriesHouseYellowFairyBookText:
	text "It's a book of"
	line "fairy tales."

	para "A golden apple"
	line "tree stands atop"
	cont "a glass mountain…"
	done
