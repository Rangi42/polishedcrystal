ValeriesHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, SetupValerieAfterMorningWalkScript

	db 2 ; warp events
	warp_event  3,  7, ECRUTEAK_CITY, 12
	warp_event  4,  7, ECRUTEAK_CITY, 12

	db 0 ; coord events

	db 1 ; bg events
	bg_event  2,  1, SIGNPOST_JUMPSTD, radio2

	db 8 ; object events
	object_event  2,  3, SPRITE_VALERIE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, ValeriesHouseValerieText, EVENT_VALERIE_ECRUTEAK_CITY
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptext, ValeriesHouseRedFairyBookText, EVENT_RED_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptext, ValeriesHouseBlueFairyBookText, EVENT_BLUE_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseGreenFairyBookText, EVENT_GREEN_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseBrownFairyBookText, EVENT_BROWN_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptext, ValeriesHouseVioletFairyBookText, EVENT_VIOLET_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptext, ValeriesHousePinkFairyBookText, EVENT_PINK_FAIRY_BOOK
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseYellowFairyBookText, EVENT_YELLOW_FAIRY_BOOK

	const_def 1 ; object constants
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
	jump SetupFairyBookScript

.Appear
	appear VALERIESHOUSE_VALERIE
	jump SetupFairyBookScript

SetupFairyBookScript:
	disappear VALERIESHOUSE_RED_FAIRY_BOOK
	disappear VALERIESHOUSE_BLUE_FAIRY_BOOK
	disappear VALERIESHOUSE_GREEN_FAIRY_BOOK
	disappear VALERIESHOUSE_BROWN_FAIRY_BOOK
	disappear VALERIESHOUSE_VIOLET_FAIRY_BOOK
	disappear VALERIESHOUSE_PINK_FAIRY_BOOK
	disappear VALERIESHOUSE_YELLOW_FAIRY_BOOK
	checkcode VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday
.Sunday
	appear VALERIESHOUSE_PINK_FAIRY_BOOK
	return
.Monday
	appear VALERIESHOUSE_BROWN_FAIRY_BOOK
	return
.Tuesday
	appear VALERIESHOUSE_RED_FAIRY_BOOK
	return
.Wednesday
	appear VALERIESHOUSE_BLUE_FAIRY_BOOK
	return
.Thursday
	appear VALERIESHOUSE_GREEN_FAIRY_BOOK
	return
.Friday
	appear VALERIESHOUSE_YELLOW_FAIRY_BOOK
	return
.Saturday
	appear VALERIESHOUSE_VIOLET_FAIRY_BOOK
	return

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
