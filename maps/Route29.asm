Route29_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route29Tuscany

	def_warp_events
	warp_event 27,  1, ROUTE_29_46_GATE, 3

	def_coord_events
	coord_event 53,  8, 1, Route29Tutorial1
	coord_event 53,  9, 1, Route29Tutorial2

	def_bg_events
	bg_event 51,  7, BGEVENT_JUMPTEXT, Route29Sign1Text
	bg_event  3,  5, BGEVENT_JUMPTEXT, Route29Sign2Text
	bg_event 23,  4, BGEVENT_JUMPTEXT, Route29AdvancedTipsSignText

	def_object_events
	object_event 50, 12, SPRITE_LYRA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_ROUTE_29
	object_event 29, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, TuscanyScript, EVENT_ROUTE_29_TUSCANY_OF_TUESDAY
	object_event 27, 16, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29YoungsterText, -1
	object_event 15, 11, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29TeacherText, -1
	cuttree_event 30,  9, EVENT_ROUTE_29_CUT_TREE_1
	cuttree_event 21, 11, EVENT_ROUTE_29_CUT_TREE_2
	fruittree_event 12,  2, FRUITTREE_ROUTE_29, ORAN_BERRY, PAL_NPC_BLUE
	object_event 25,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29FisherText, -1
	object_event 13,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route29CooltrainerMScript, -1
	itemball_event 48,  2, POTION, 1, EVENT_ROUTE_29_POTION

	object_const_def
	const ROUTE29_LYRA
	const ROUTE29_TUSCANY

Route29Tuscany:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .DoesTuscanyAppear

.TuscanyDisappears:
	disappear ROUTE29_TUSCANY
	return

.DoesTuscanyAppear:
	checkcode VAR_WEEKDAY
	ifnotequal TUESDAY, .TuscanyDisappears
	appear ROUTE29_TUSCANY
	return

Route29Tutorial1:
	turnobject ROUTE29_LYRA, UP
	showemote EMOTE_SHOCK, ROUTE29_LYRA, 15
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	pause 15
	applymovement ROUTE29_LYRA, LyraMovementData1a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalse Route29RefusedTutorial
	closetext
	follow ROUTE29_LYRA, PLAYER
	applymovement ROUTE29_LYRA, LyraMovementData1b
	jump Route29TutorialScript

Route29Tutorial2:
	turnobject ROUTE29_LYRA, UP
	showemote EMOTE_SHOCK, ROUTE29_LYRA, 15
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	pause 15
	applymovement ROUTE29_LYRA, LyraMovementData2a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalse Route29RefusedTutorial
	closetext
	follow ROUTE29_LYRA, PLAYER
	applymovement ROUTE29_LYRA, LyraMovementData2b
Route29TutorialScript:
	stopfollow
	loadwildmon PIDGEY, 5
	catchtutorial BATTLETYPE_TUTORIAL
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	turnobject ROUTE29_LYRA, UP
	opentext
	writetext CatchingTutorialDebriefText
Route29FinishTutorial:
	buttonsound
	itemtotext POKE_BALL, $1
	callstd receiveitem
	giveitem POKE_BALL, 5
	itemnotify
	writetext CatchingTutorialGoodbyeText
	waitbutton
	closetext
	applymovement ROUTE29_LYRA, LyraMovementData3
	disappear ROUTE29_LYRA
	setscene $0
	setevent EVENT_LEARNED_TO_CATCH_POKEMON
	playmusic MUSIC_ROUTE_29
	end

Route29RefusedTutorial:
	setevent EVENT_NEVER_LEARNED_TO_CATCH_POKEMON
	writetext CatchingTutorialRefusedText
	jump Route29FinishTutorial

Route29CooltrainerMScript:
	checktime (1 << EVE) | (1 << NITE)
	iftrue_jumptextfaceplayer Text_WaitingForMorning
	jumptextfaceplayer Text_WaitingForNight

TuscanyScript:
	checkevent EVENT_GOT_SILK_SCARF_FROM_TUSCANY
	iftrue_jumptextfaceplayer TuscanyTuesdayText
	faceplayer
	opentext
	checkcode VAR_WEEKDAY
	ifnotequal TUESDAY, TuscanyNotTuesdayScript
	checkevent EVENT_MET_TUSCANY_OF_TUESDAY
	iftrue .MetTuscany
	writetext MeetTuscanyText
	buttonsound
	setevent EVENT_MET_TUSCANY_OF_TUESDAY
.MetTuscany:
	writetext TuscanyGivesGiftText
	buttonsound
	verbosegiveitem SILK_SCARF
	iffalse_endtext
	setevent EVENT_GOT_SILK_SCARF_FROM_TUSCANY
	jumpopenedtext TuscanyGaveGiftText

TuscanyNotTuesdayScript:
	jumpopenedtext TuscanyNotTuesdayText

LyraMovementData1a:
	step_up
LyraMovementData2a:
	step_up
	step_up
	step_up
	step_right
	step_right
	step_end

LyraMovementData1b:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	step_end

LyraMovementData2b:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_end

LyraMovementData3:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

CatchingTutorialIntroText:
	text "Lyra: <PLAYER>!"

	para "You can catch wild"
	line "#mon with #"

	para "Balls. Follow me"
	line "and I'll show you!"
	done

CatchingTutorialDebriefText:
	text "Lyra: See? Just"
	line "like that!"

	para "If you weaken them"
	line "first, #mon are"
	cont "easier to catch."

	para "I'll give you"
	line "these. Good luck!"
	done

CatchingTutorialRefusedText:
	text "Aww… I wanted to"
	line "show off my cap-"
	cont "turing skills a"
	cont "little…"

	para "Anyway, I'll give"
	line "you these."
	cont "Good luck!"
	done

CatchingTutorialGoodbyeText:
	text "Lyra: See you!"
	done

Route29YoungsterText:
	text "Yo. How are your"
	line "#mon?"

	para "If they're weak"
	line "and not ready for"

	para "battle, keep out"
	line "of the grass."
	done

Route29TeacherText:
	text "See those ledges?"
	line "It's scary to jump"
	cont "off them."

	para "But you can go to"
	line "New Bark without"

	para "walking through"
	line "the grass."
	done

Route29FisherText:
	text "I wanted to take a"
	line "break, so I saved"

	para "to record my"
	line "progress."
	done

Text_WaitingForNight:
	text "I'm waiting for"
	line "#mon that"

	para "appear only in"
	line "the evening or"
	cont "at night."
	done

Text_WaitingForMorning:
	text "I'm waiting for"
	line "#mon that"

	para "appear only in the"
	line "morning."
	done

MeetTuscanyText:
	text "Tuscany: I do be-"
	line "lieve that this is"

	para "the first time"
	line "we've met?"

	para "Please allow me to"
	line "introduce myself."

	para "I am Tuscany of"
	line "Tuesday."
	done

TuscanyGivesGiftText:
	text "By way of intro-"
	line "duction, please"

	para "accept this gift,"
	line "a Silk Scarf."
	done

TuscanyGaveGiftText:
	text "Tuscany: Wouldn't"
	line "you agree that it"
	cont "is most elegant?"

	para "It strengthens"
	line "Normal-type moves."

	para "I am certain it"
	line "will be of use."
	done

TuscanyTuesdayText:
	text "Tuscany: Have you"
	line "met Monica, my"
	cont "older sister?"

	para "Or my younger"
	line "brother, Wesley?"

	para "I am the second of"
	line "seven children."
	done

TuscanyNotTuesdayText:
	text "Tuscany: Today is"
	line "not Tuesday. That"
	cont "is unfortunate…"
	done

Route29Sign1Text:
	text "Route 29"

	para "New Bark Town -"
	line "Cherrygrove City"
	done

Route29Sign2Text:
	text "Route 29"

	para "Cherrygrove City -"
	line "New Bark Town"
	done

Route29AdvancedTipsSignText:
	text "Advanced Tips!"

	para "Press Start in"
	line "the Bag to sort"
	cont "an item pocket!"
	done
