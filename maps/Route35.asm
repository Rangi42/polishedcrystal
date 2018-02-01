Route35_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, Route35RebattleBreeder

	db 4 ; warp events
	warp_event 13, 33, 1, ROUTE_35_GOLDENROD_GATE
	warp_event 14, 33, 2, ROUTE_35_GOLDENROD_GATE
	warp_event 7, 5, 3, ROUTE_35_NATIONAL_PARK_GATE
	warp_event 14, 16, 1, HIDDEN_TREE_GROTTO

	db 0 ; coord events

	db 4 ; bg events
	bg_event 5, 7, SIGNPOST_JUMPTEXT, Route35SignText
	bg_event 15, 31, SIGNPOST_JUMPTEXT, Route35SignText
	bg_event 14, 15, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35
	bg_event 15, 15, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35

	db 12 ; object events
	object_event 8, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperIvan, -1
	object_event 12, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleGailandeli1, -1
	object_event 11, 20, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleGailandeli2, -1
	object_event 14, 26, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerPicnickerKim, -1
	object_event 18, 29, SPRITE_BREEDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerBreederTheresa, -1
	object_event 6, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherWalt, -1
	object_event 20, 7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBug_catcherArnie1, -1
	object_event 9, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerJugglerIrwin, -1
	object_event 9, 6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficermScript_0x19ca49, -1
	cuttree_event 21, 6, EVENT_ROUTE_35_CUT_TREE
	fruittree_event 6, 25, FRUITTREE_ROUTE_35, LEPPA_BERRY
	tmhmball_event 17, 16, TM_HONE_CLAWS, EVENT_ROUTE_35_TM_HONE_CLAWS

Route35RebattleBreeder:
	clearevent EVENT_BEAT_BREEDER_THERESA
	return

TrainerBreederTheresa:
	trainer BREEDER, THERESA, EVENT_BEAT_BREEDER_THERESA, BreederTheresaSeenText, BreederTheresaBeatenText, 0, BreederTheresaScript

BreederTheresaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19cc87

TrainerJugglerIrwin:
	trainer JUGGLER, IRWIN1, EVENT_BEAT_JUGGLER_IRWIN, JugglerIrwin1SeenText, JugglerIrwin1BeatenText, 0, JugglerIrwin1Script

JugglerIrwin1Script:
	writecode VAR_CALLERID, PHONE_JUGGLER_IRWIN
	opentext
	checkcellnum PHONE_JUGGLER_IRWIN
	iftrue UnknownScript_0x19c90f
	checkevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19c8ec
	writetext UnknownText_0x19cd5a
	buttonsound
	setevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19c903
	jump UnknownScript_0x19c8ef

UnknownScript_0x19c8ec:
	scall UnknownScript_0x19c907
UnknownScript_0x19c8ef:
	askforphonenumber PHONE_JUGGLER_IRWIN
	if_equal $1, UnknownScript_0x19c917
	if_equal $2, UnknownScript_0x19c913
	trainertotext JUGGLER, IRWIN1, $0
	scall UnknownScript_0x19c90b
	jump UnknownScript_0x19c90f

UnknownScript_0x19c903:
	jumpstd asknumber1m
	end

UnknownScript_0x19c907:
	jumpstd asknumber2m
	end

UnknownScript_0x19c90b:
	jumpstd registerednumberm
	end

UnknownScript_0x19c90f:
	jumpstd numberacceptedm
	end

UnknownScript_0x19c913:
	jumpstd numberdeclinedm
	end

UnknownScript_0x19c917:
	jumpstd phonefullm
	end

UnknownScript_0x19c91b:
	jumpstd rematchm
	end

TrainerCamperIvan:
	trainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, CamperIvanSeenText, CamperIvanBeatenText, 0, CamperIvanScript

CamperIvanScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19cac4

TrainerCoupleGailandeli1:
	trainer COUPLE, GAILANDELI1, EVENT_BEAT_COUPLE_GAIL_AND_ELI, CoupleGailandeli1SeenText, CoupleGailandeli1BeatenText, 0, CoupleGailandeli1Script

CoupleGailandeli1Script:
	end_if_just_battled
	jumptextfaceplayer CoupleGailandeli1AfterText

TrainerCoupleGailandeli2:
	trainer COUPLE, GAILANDELI2, EVENT_BEAT_COUPLE_GAIL_AND_ELI, CoupleGailandeli2SeenText, CoupleGailandeli2BeatenText, 0, CoupleGailandeli2Script

CoupleGailandeli2Script:
	end_if_just_battled
	jumptextfaceplayer CoupleGailandeli2AfterText

TrainerPicnickerKim:
	trainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, PicnickerKimSeenText, PicnickerKimBeatenText, 0, PicnickerKimScript

PicnickerKimScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19cc21

TrainerBug_catcherArnie1:
	trainer BUG_CATCHER, ARNIE1, EVENT_BEAT_BUG_CATCHER_ARNIE, Bug_catcherArnie1SeenText, Bug_catcherArnie1BeatenText, 0, Bug_catcherArnie1Script

Bug_catcherArnie1Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_ARNIE
	end_if_just_battled
	opentext
	checkflag ENGINE_ARNIE
	iftrue UnknownScript_0x19c9bb
	checkflag ENGINE_YANMA_SWARM
	iftrue UnknownScript_0x19ca2f
	checkcellnum PHONE_BUG_CATCHER_ARNIE
	iftrue UnknownScript_0x19c90f
	checkevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19c9a4
	writetext UnknownText_0x19cdf6
	buttonsound
	setevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x19c903
	jump UnknownScript_0x19c9a7

UnknownScript_0x19c9a4:
	scall UnknownScript_0x19c907
UnknownScript_0x19c9a7:
	askforphonenumber PHONE_BUG_CATCHER_ARNIE
	if_equal $1, UnknownScript_0x19c917
	if_equal $2, UnknownScript_0x19c913
	trainertotext BUG_CATCHER, ARNIE1, $0
	scall UnknownScript_0x19c90b
	jump UnknownScript_0x19c90f

UnknownScript_0x19c9bb:
	scall UnknownScript_0x19c91b
	winlosstext Bug_catcherArnie1BeatenText, 0
	copybytetovar wArnieFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, ARNIE1
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 1
	clearflag ENGINE_ARNIE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, ARNIE2
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 2
	clearflag ENGINE_ARNIE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, ARNIE3
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 3
	clearflag ENGINE_ARNIE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, ARNIE4
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 4
	clearflag ENGINE_ARNIE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, ARNIE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

UnknownScript_0x19ca2f:
	jumpopenedtext UnknownText_0x19ce38

TrainerFirebreatherWalt:
	trainer FIREBREATHER, WALT, EVENT_BEAT_FIREBREATHER_WALT, FirebreatherWaltSeenText, FirebreatherWaltBeatenText, 0, FirebreatherWaltScript

FirebreatherWaltScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19cebc

OfficermScript_0x19ca49:
	faceplayer
	opentext
	checknite
	iffalse UnknownScript_0x19ca73
	checkevent EVENT_BEAT_OFFICERM_DIRK
	iftrue UnknownScript_0x19ca6d
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext UnknownText_0x19ceea
	waitbutton
	closetext
	winlosstext UnknownText_0x19cf06, 0
	loadtrainer OFFICERM, DIRK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERM_DIRK
	endtext

UnknownScript_0x19ca6d:
	jumpopenedtext UnknownText_0x19cf0f

UnknownScript_0x19ca73:
	jumpopenedtext UnknownText_0x19cf56

CamperIvanSeenText:
	text "I've been getting"
	line "#mon data off"

	para "my radio. I think"
	line "I'm good."
	done

CamperIvanBeatenText:
	text "I give!"
	done

UnknownText_0x19cac4:
	text "Music on the radio"
	line "changes the moods"
	cont "of wild #mon."
	done

CoupleGailandeli1SeenText:
	text "Eli: I'm gonna"
	line "show my girlfriend"
	cont "I'm hot stuff!"
	done

CoupleGailandeli1BeatenText:
	text "Eli: I wish you'd"
	line "have lost for me…"
	done

CoupleGailandeli1AfterText:
	text "Eli: I was humili-"
	line "ated in front of"
	cont "my girlfriend…"
	done

CoupleGailandeli2SeenText:
	text "Gail: My boy-"
	line "friend's weak, so I"
	cont "can't rely on him."
	done

CoupleGailandeli2BeatenText:
	text "Gail: Oh, my!"
	line "You're so strong!"
	done

CoupleGailandeli2AfterText:
	text "Gail: I can count"
	line "on my #mon more"
	cont "than my boyfriend."
	done

PicnickerKimSeenText:
	text "Are you going to"
	line "the Gym? Me too!"
	done

PicnickerKimBeatenText:
	text "Oh. I couldn't"
	line "win…"
	done

UnknownText_0x19cc21:
	text "The Gym Badges are"
	line "pretty. I collect"
	cont "them."
	done

BreederTheresaSeenText:
	text "How do you care"
	line "for your #mon?"
	done

BreederTheresaBeatenText:
	text "Ah! You take good"
	line "care of them!"
	done

UnknownText_0x19cc87:
	text "I take my #mon"
	line "to get haircuts"

	para "in Goldenrod City,"
	line "and blessings in"
	cont "Ecruteak City."

	para "They're so happy!"
	done

JugglerIrwin1SeenText:
	text "Behold my graceful"
	line "Ball dexterity!"
	done

JugglerIrwin1BeatenText:
	text "Whew! That was a"
	line "jolt!"
	done

UnknownText_0x19cd5a:
	text "I was going to"
	line "dazzle you with my"
	cont "prize #mon."

	para "But your prowess"
	line "electrified me!"
	done

Bug_catcherArnie1SeenText:
	text "I'll go anywhere"
	line "if bug #mon"
	cont "appear there."
	done

Bug_catcherArnie1BeatenText:
	text "Huh? I shouldn't"
	line "have lost that…"
	done

UnknownText_0x19cdf6:
	text "My Venonat won me"
	line "the Bug-Catching"

	para "Contest at the"
	line "National Park."
	done

UnknownText_0x19ce38:
	text "Wow… Look at all"
	line "those Yanma!"

	para "I'm so blown away,"
	line "I can't move."
	done

FirebreatherWaltSeenText:
	text "I'm practicing my"
	line "fire breathing."
	done

FirebreatherWaltBeatenText:
	text "Ow! I scorched the"
	line "tip of my nose!"
	done

UnknownText_0x19cebc:
	text "The #mon March"
	line "on the radio lures"
	cont "wild #mon."
	done

UnknownText_0x19ceea:
	text "Danger lurks in"
	line "the night!"
	done

UnknownText_0x19cf06:
	text "Whoops!"
	done

UnknownText_0x19cf0f:
	text "You know, night-"
	line "time is fun in its"
	cont "own ways."

	para "But don't overdo"
	line "it, OK?"
	done

UnknownText_0x19cf56:
	text "Your #mon look"
	line "pretty tough."

	para "You could go any-"
	line "where safely."
	done

Route35SignText:
	text "Route 35"
	done
