ShamoutiTouristCenter_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SHAMOUTI_ISLAND, 4
	warp_event  3,  7, SHAMOUTI_ISLAND, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_LARRY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LarryScript, -1

	object_const_def
	const SHAMOUTITOURISTCENTER_LARRY

LarryScript:
	faceplayer
	checkevent EVENT_BEAT_LARRY
	iftruefwd .After
	opentext
	checkevent EVENT_INTRODUCED_LARRY
	iftruefwd .Introduced
	writetext .IntroText
	sjumpfwd .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	setevent EVENT_INTRODUCED_LARRY
	winlosstext .BeatenText, 0
	setlasttalked SHAMOUTITOURISTCENTER_LARRY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Rematch
	loadtrainer LARRY, 1
	sjumpfwd .StartBattle
.Rematch
	loadtrainer LARRY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LARRY
.After
	opentext
	checkevent EVENT_GOT_SWEET_HONEY_FROM_LARRY
	iftruefwd .Done
	writetext .RewardText
	promptbutton
	verbosegiveitem SWEET_HONEY
	iffalse_endtext
	setevent EVENT_GOT_SWEET_HONEY_FROM_LARRY
.Done
	jumpthisopenedtext

	text "Now, I'd better"
	line "get back to work."

	para "If you'll excuse"
	line "me."
	done

.RewardText:
	text "For me, the best"
	line "part of traveling"

	para "is trying out the"
	line "local dishes."

	para "The restaurant"
	line "nearby makes a"

	para "decadent dessert"
if DEF(FAITHFUL)
	line "with Honey."
else
	line "with Sweet Honey."
endc

	para "Let me share some"
	line "with you."
	done

.IntroText:
	text "Hello."
	line "I'm Larry."

	para "My boss sent me"
	line "out here on"

	para "business, but I"
	line "may as well enjoy"

	para "myself while I'm"
	line "at it."

	para "I just ate at the"
	line "Oasis Restaurant"
	cont "in the hotel."

	para "It whet my appe-"
	line "tite for an even"
	cont "stronger battle."

	para "Care to join me?"
	done

.RematchText:
	text "Hello again,"
	line "<PLAYER>."

	para "You already faced"
	line "me, so I doubt"

	para "this will leave"
	line "much of an impres-"
	cont "sion on you."

	para "In any case, shall"
	line "we get started?"
	done

.SeenText:
	text "I, Larry, will be"
	line "at your service."
	done

.BeatenText:
	text "Well, I've had"
	line "my fill…"
	done

.RefusedText:
	text "Maybe another time"
	line "when our schedules"
	cont "align."
	done
