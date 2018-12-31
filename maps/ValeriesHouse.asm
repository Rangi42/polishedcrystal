ValeriesHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, SetupValerieAfterMorningWalkScript

ValeriesHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 12, ECRUTEAK_CITY
	warp_def 7, 4, 12, ECRUTEAK_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 2, SIGNPOST_JUMPSTD, radio2

.PersonEvents: db 8
	person_event SPRITE_VALERIE, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, ValeriesHouseValerieText, EVENT_VALERIE_ECRUTEAK_CITY
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptext, ValeriesHouseRedFairyBookText, EVENT_RED_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptext, ValeriesHouseBlueFairyBookText, EVENT_BLUE_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseGreenFairyBookText, EVENT_GREEN_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseBrownFairyBookText, EVENT_BROWN_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptext, ValeriesHouseVioletFairyBookText, EVENT_VIOLET_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptext, ValeriesHousePinkFairyBookText, EVENT_PINK_FAIRY_BOOK
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptext, ValeriesHouseYellowFairyBookText, EVENT_YELLOW_FAIRY_BOOK

const_value set 1
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
	checkmorn
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
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday
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
