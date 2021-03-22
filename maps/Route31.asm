Route31_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route31CheckMomCall

	def_warp_events
	warp_event  4,  6, ROUTE_31_VIOLET_GATE, 3
	warp_event  4,  7, ROUTE_31_VIOLET_GATE, 4
	warp_event 34,  5, DARK_CAVE_VIOLET_ENTRANCE, 1

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, Route31SignText
	bg_event 31,  5, BGEVENT_JUMPTEXT, DarkCaveSignText

	def_object_events
	object_event 28,  7, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermFinch, -1
	object_event 17,  7, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31MailRecipientScript, -1
	object_event  9,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route31YoungsterText, -1
	object_event 21, 13, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 5, TrainerBug_catcherWade1, -1
	cuttree_event 13,  5, EVENT_ROUTE_31_CUT_TREE_1
	cuttree_event 25, 10, EVENT_ROUTE_31_CUT_TREE_2
	fruittree_event 16,  7, FRUITTREE_ROUTE_31, PERSIM_BERRY, PAL_NPC_RED
	itemball_event 29,  5, POTION, 1, EVENT_ROUTE_31_POTION
	itemball_event 19, 15, POKE_BALL, 1, EVENT_ROUTE_31_POKE_BALL

	object_const_def
	const ROUTE31_COOLTRAINER_M

Route31CheckMomCall:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalse .DoMomCall
	endcallback

.DoMomCall:
	specialphonecall SPECIALCALL_WORRIED
	endcallback

TrainerCooltrainermFinch:
	trainer 0, 0, EVENT_INTRODUCED_ROUTE_LEADERS, .IntroText, 0, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_GOT_AIR_BALLOON_FROM_ROUTE_31_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_FINCH
	iftrue .Beaten
	checkevent EVENT_BEAT_YOUNGSTER_JOEY
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_YOUNGSTER_MIKEY
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BUG_CATCHER_DON
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BUG_CATCHER_WADE
	iffalse_jumpopenedtext .IntroText
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE31_COOLTRAINER_M
	loadtrainer COOLTRAINERM, FINCH
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_FINCH
	opentext
.Beaten:
	writetext .AfterText1
	promptbutton
	verbosegiveitem AIR_BALLOON
	iffalse_endtext
	setevent EVENT_GOT_AIR_BALLOON_FROM_ROUTE_31_LEADER
	jumpthisopenedtext

.AfterText2:
	text "You saw the effect"
	line "of an Air Balloon"
	cont "in our battle."

	para "You may find other"
	line "trainers like me"
	cont "wandering Johto."

	para "Searching for"
	line "strength."

	para "You would do well"
	line "to challenge them!"
	done

.IntroText:
	text "I am a trainer who"
	line "uses Air Balloons"
	cont "in battle."

	para "I want to be"
	line "swayed by your"
	cont "strength…"

	para "If you can defeat"
	line "every trainer on"
	cont "Route 30 and 31,"
	cont "then come face me."
	done

.QuestionText:
	text "So you've defeated"
	line "all of the train-"
	cont "ers here!"

	para "Then you're fit to"
	line "challenge me!"

	para "Shall we battle?"
	done

.RefusedText:
	text "You don't want to"
	line "test your strength"
	cont "with mine?"

	para "I'll give you my"
	line "signature item if"
	cont "you win…"
	done

.SeenText:
	text "Well met! I will"
	line "stand before you"

	para "as an Air Balloon"
	line "user!"
	done

.BeatenText:
	text "You've brought me"
	line "to the ground…"
	done

.AfterText1:
	text "A fine battle!"
	line "You are a rising"

	para "star among train-"
	line "ers!"

	para "Here is proof of"
	line "our battle."
	cont "An Air Balloon!"

	para "Take it, my"
	line "strong friend!"
	done

TrainerBug_catcherWade1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, Bug_catcherWade1SeenText, Bug_catcherWade1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	opentext
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftrue .WadeRematch
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue .WadeItem
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftrue .AcceptedNumberSTD
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext Bug_catcherWade1AfterText
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	sjump .Continue

.AskAgain:
	callstd asknumber2m
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequal $1, .PhoneFullSTD
	ifequal $2, .DeclinedNumberSTD
	gettrainername BUG_CATCHER, WADE1, $0
	callstd registerednumberm
	jumpstd numberacceptedm

.WadeRematch:
	callstd rematchm
	winlosstext Bug_catcherWade1BeatenText, 0
	readmem wWadeFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, WADE1
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 1
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 2
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 3
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, WADE4
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 4
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, WADE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.WadeItem:
	callstd giftm
	checkevent EVENT_WADE_HAS_ORAN_BERRY
	iftrue .OranBerry
	checkevent EVENT_WADE_HAS_PECHA_BERRY
	iftrue .PechaBerry
	checkevent EVENT_WADE_HAS_CHERI_BERRY
	iftrue .CheriBerry
	checkevent EVENT_WADE_HAS_PERSIM_BERRY
	iftrue .PersimBerry
.OranBerry:
	verbosegiveitem ORAN_BERRY
	iffalse .PackFull
	sjump .Done
.PechaBerry:
	verbosegiveitem PECHA_BERRY
	iffalse .PackFull
	sjump .Done
.CheriBerry:
	verbosegiveitem CHERI_BERRY
	iffalse .PackFull
	sjump .Done
.PersimBerry:
	verbosegiveitem PERSIM_BERRY
	iffalse .PackFull
.Done:
	clearflag ENGINE_WADE_HAS_ITEM
	jumpstd numberacceptedm
.PackFull:
	jumpstd packfullm

.AcceptedNumberSTD:
	jumpstd numberacceptedm

.DeclinedNumberSTD:
	jumpstd numberdeclinedm

.PhoneFullSTD:
	jumpstd phonefullm

Route31MailRecipientScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KENYA
	iftrue .TutorSleepTalk
	checkevent EVENT_GOT_KENYA
	iftrue .TryGiveKenya
	jumpopenedtext Text_Route31SleepyMan

.TryGiveKenya:
	writetext Text_Route31SleepyManGotMail
	promptbutton
	checkpokemail ReceivedFarfetch_dMailText
	ifequal $0, .WrongMail
	ifequal $2, .Refused
	ifequal $3, .NoMail
	ifequal $4, .LastMon
	writetext Text_Route31HandOverMailMon
	promptbutton
	writetext Text_Route31ReadingMail
	promptbutton
	setevent EVENT_GAVE_KENYA
.TutorSleepTalk
	writetext Text_Route31TutorSleepTalk
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Route31TutorQuestion
	yesorno
	iffalse .TutorRefused
	setval SLEEP_TALK
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_Route31TutorRefused

.NoSilverLeaf
	jumpopenedtext Text_Route31TutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Route31TutorTaught

.WrongMail:
	jumpopenedtext Text_Route31WrongMail

.NoMail:
	jumpopenedtext Text_Route31MissingMail

.Refused:
	jumpopenedtext Text_Route31DeclinedToHandOverMail

.LastMon:
	jumpopenedtext Text_Route31CantTakeLastMon

ReceivedFarfetch_dMailText:
	db   "Dark Cave leads"
	next "to another road@"

Bug_catcherWade1SeenText:
	text "I caught a bunch"
	line "of #mon. Let me"
	cont "battle with you!"
	done

Bug_catcherWade1BeatenText:
	text "Awwwww…"
	done

Bug_catcherWade1AfterText:
	text "You can catch"
	line "#mon even if"

	para "you have six with"
	line "you."

	para "If you catch one,"
	line "it'll go to your"
	cont "Box automatically."
	done

Text_Route31SleepyMan:
	text "…Hnuurg… Huh?"

	para "I walked too far"
	line "today looking for"
	cont "#mon."

	para "My feet hurt and"
	line "I'm sleepy…"

	para "If I were a wild"
	line "#mon, I'd be"
	cont "easy to catch…"

	para "…Zzzz…"
	done

Text_Route31SleepyManGotMail:
	text "…Zzzz… Huh?"

	para "What's that? You"
	line "have Mail for me?"
	done

Text_Route31HandOverMailMon:
	text "<PLAYER> handed"
	line "over the #mon"
	cont "holding the Mail."
	done

Text_Route31ReadingMail:
	text "Let's see…"

	para "…Dark Cave leads"
	line "to another road…"

	para "That's good to"
	line "know."

	para "Thanks for bring-"
	line "ing this to me."

	para "My friend's a good"
	line "guy, and you're"
	cont "swell too!"

	para "I'd like to do"
	line "something good in"
	cont "return!"
	done

Text_Route31TutorSleepTalk:
	text "For just one"
	line "Silver Leaf,"

	para "I can teach your"
	line "#mon to talk"
	cont "in their sleep!"
	done

Text_Route31TutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf,"
	cont "though…"
	done

Text_Route31TutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Sleep Talk?"
	done

Text_Route31TutorRefused:
	text "OK then…"
	done

Text_Route31TutorTaught:
	text "There! Now your"
	line "#mon knows"
	cont "Sleep Talk!"
	done

Text_Route31WrongMail:
	text "This Mail isn't"
	line "for me."
	done

Text_Route31MissingMail:
	text "Why is this #-"
	line "mon so special?"

	para "It doesn't have"
	line "any Mail."
	done

Text_Route31DeclinedToHandOverMail:
	text "What? You don't"
	line "want anything?"
	done

Text_Route31CantTakeLastMon:
	text "If I take that"
	line "#mon from you,"

	para "what are you going"
	line "to use in battle?"
	done

Route31YoungsterText:
	text "I found a good"
	line "#mon in Dark"
	cont "Cave."

	para "I'm going to raise"
	line "it to take on"
	cont "Falkner."

	para "He's the leader of"
	line "Violet City's Gym."
	done

Route31SignText:
	text "Route 31"

	para "Violet City -"
	line "Cherrygrove City"
	done

DarkCaveSignText:
	text "Dark Cave"
	done
