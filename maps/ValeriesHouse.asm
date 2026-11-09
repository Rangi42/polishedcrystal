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
	object_event  2,  3, SPRITE_VALERIE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ValeriesHouseValerieText, EVENT_VALERIE_ECRUTEAK_CITY
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ValeriesHouseFairyBookScript, -1

	object_const_def
	const VALERIESHOUSE_VALERIE
	const VALERIESHOUSE_FAIRY_BOOK

SetupValerieAfterMorningWalkScript:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalsefwd .Disappear
	checkevent EVENT_BEAT_VALERIE
	iffalsefwd .Disappear
	checkflag ENGINE_VALERIE_MORNING_WALK
	iftruefwd .Appear
	checktime 1 << MORN
	iffalsefwd .Appear
.Disappear:
	disappear VALERIESHOUSE_VALERIE
	sjumpfwd SetupFairyBookScript

.Appear
	appear VALERIESHOUSE_VALERIE
	; fallthrough

SetupFairyBookScript:
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .Sunday
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequalfwd THURSDAY, .Thursday
	ifequalfwd FRIDAY, .Friday
	ifequalfwd SATURDAY, .Saturday
.Sunday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_PINK
	endcallback
.Monday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_BROWN
	endcallback
.Tuesday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_RED
	endcallback
.Wednesday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_BLUE
	endcallback
.Thursday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_GREEN
	endcallback
.Friday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_ENV_YELLOW
	endcallback
.Saturday
	setmapobjectpal VALERIESHOUSE_FAIRY_BOOK, PAL_NPC_PURPLE
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

ValeriesHouseFairyBookScript:
	opentext
	writetext ValeriesHouseFairyBookText
	waitbutton
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .Sunday
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequalfwd THURSDAY, .Thursday
	ifequalfwd FRIDAY, .Friday
	ifequalfwd SATURDAY, .Saturday
.Sunday
	jumpthisopenedtext

	text "A man is being"
	line "led by a turtle"
	cont "under the sea…"
	done

.Monday
	jumpthisopenedtext

	text "A peasant's house"
	line "has become a fine"
	cont "palace overnight…"
	done

.Tuesday
	jumpthisopenedtext

	text "A girl with very"
	line "long hair is lock-"
	cont "ed in a tower…"
	done

.Wednesday
	jumpthisopenedtext

	text "A beautiful girl"
	line "is talking to a"
	cont "horse's head…"
	done

.Thursday
	jumpthisopenedtext

	text "A talking fish"
	line "claims that it can"
	cont "grant wishes…"
	done

.Friday
	jumpthisopenedtext

	text "A golden apple"
	line "tree stands atop"
	cont "a glass mountain…"
	done

.Saturday
	jumpthisopenedtext

	text "A dog digs in the"
	line "garden and finds"
	cont "golden treasure…"
	done

ValeriesHouseFairyBookText:
	text "It's a book of"
	line "fairy tales."
	done
