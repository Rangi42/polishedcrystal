Route31_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, Route31CheckMomCall

Route31_MapEventHeader:

.Warps: db 3
	warp_def 6, 4, 3, ROUTE_31_VIOLET_GATE
	warp_def 7, 4, 4, ROUTE_31_VIOLET_GATE
	warp_def 5, 34, 1, DARK_CAVE_VIOLET_ENTRANCE

.XYTriggers: db 0

.Signposts: db 2
	signpost 5, 7, SIGNPOST_JUMPTEXT, Route31SignText
	signpost 5, 31, SIGNPOST_JUMPTEXT, DarkCaveSignText

.PersonEvents: db 9
	person_event SPRITE_COOLTRAINER_M, 7, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainermFinch, -1
	person_event SPRITE_FISHER, 7, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route31MailRecipientScript, -1
	person_event SPRITE_YOUNGSTER, 5, 9, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route31YoungsterText, -1
	person_event SPRITE_CHERRYGROVE_RIVAL, 13, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerBug_catcherWade1, -1
	cuttree_event 5, 13, EVENT_ROUTE_31_CUT_TREE_1
	cuttree_event 10, 25, EVENT_ROUTE_31_CUT_TREE_2
	fruittree_event 7, 16, FRUITTREE_ROUTE_31, PERSIM_BERRY
	itemball_event 5, 29, POTION, 1, EVENT_ROUTE_31_POTION
	itemball_event 15, 19, POKE_BALL, 1, EVENT_ROUTE_31_POKE_BALL

const_value set 1
	const ROUTE31_COOLTRAINER_M

Route31CheckMomCall:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalse .DoMomCall
	return

.DoMomCall:
	specialphonecall SPECIALCALL_WORRIED
	return

TrainerCooltrainermFinch:
	trainer EVENT_INTRODUCED_ROUTE_LEADERS, 0, 0, .IntroText, 0, 0, .Script

.Script:
	end_if_just_battled
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
	buttonsound
	verbosegiveitem AIR_BALLOON
	iffalse_endtext
	setevent EVENT_GOT_AIR_BALLOON_FROM_ROUTE_31_LEADER
	thisopenedtext

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
	trainer EVENT_BEAT_BUG_CATCHER_WADE, BUG_CATCHER, WADE1, Bug_catcherWade1SeenText, Bug_catcherWade1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	opentext
	checkflag ENGINE_WADE
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
	scall .AskPhoneNumberSTD
	jump .Continue

.AskAgain:
	scall .AskAgainSTD
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	if_equal $1, .PhoneFullSTD
	if_equal $2, .DeclinedNumberSTD
	trainertotext BUG_CATCHER, WADE1, $0
	scall .RegisterNumberSTD
	jump .AcceptedNumberSTD

.WadeRematch:
	scall .RematchSTD
	winlosstext Bug_catcherWade1BeatenText, 0
	copybytetovar wWadeFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
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
	loadvar wWadeFightCount, 1
	clearflag ENGINE_WADE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 2
	clearflag ENGINE_WADE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 3
	clearflag ENGINE_WADE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, WADE4
	startbattle
	reloadmapafterbattle
	loadvar wWadeFightCount, 4
	clearflag ENGINE_WADE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, WADE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WADE
	end

.WadeItem:
	scall .ItemSTD
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
	jump .Done
.PechaBerry:
	verbosegiveitem PECHA_BERRY
	iffalse .PackFull
	jump .Done
.CheriBerry:
	verbosegiveitem CHERI_BERRY
	iffalse .PackFull
	jump .Done
.PersimBerry:
	verbosegiveitem PERSIM_BERRY
	iffalse .PackFull
.Done:
	clearflag ENGINE_WADE_HAS_ITEM
	jump .AcceptedNumberSTD
.PackFull:
	jump .PackFullSTD

.AskPhoneNumberSTD:
	jumpstd asknumber1m
	end

.AskAgainSTD:
	jumpstd asknumber2m
	end

.RegisterNumberSTD:
	jumpstd registerednumberm
	end

.AcceptedNumberSTD:
	jumpstd numberacceptedm
	end

.DeclinedNumberSTD:
	jumpstd numberdeclinedm
	end

.PhoneFullSTD:
	jumpstd phonefullm
	end

.RematchSTD:
	jumpstd rematchm
	end

.ItemSTD:
	jumpstd giftm
	end

.PackFullSTD:
	jumpstd packfullm
	end

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
	buttonsound
	checkpokeitem ReceivedFarfetch_dMailText
	if_equal $0, .WrongMail
	if_equal $2, .Refused
	if_equal $3, .NoMail
	if_equal $4, .LastMon
	writetext Text_Route31HandOverMailMon
	buttonsound
	writetext Text_Route31ReadingMail
	buttonsound
	setevent EVENT_GAVE_KENYA
.TutorSleepTalk
	writetext Text_Route31TutorSleepTalk
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Route31TutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte SLEEP_TALK
	writetext Text_Route31TutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
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

Text_Route31TutorClear:
	text ""
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
