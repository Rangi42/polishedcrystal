Route35_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13, 33, ROUTE_35_GOLDENROD_GATE, 1
	warp_event 14, 33, ROUTE_35_GOLDENROD_GATE, 2
	warp_event  7,  5, ROUTE_35_NATIONAL_PARK_GATE, 3
	warp_event 14, 16, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  5,  7, BGEVENT_JUMPTEXT, Route35SignText
	bg_event 15, 31, BGEVENT_JUMPTEXT, Route35SignText
	bg_event 14, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35
	bg_event 15, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35

	def_object_events
	object_event  8, 19, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperIvan, -1
	object_event 12, 20, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleGailandeli1, -1
	object_event 11, 20, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleGailandeli2, -1
	object_event 14, 26, SPRITE_PICNICKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerPicnickerKim, -1
	object_event 18, 29, SPRITE_BREEDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBreederTheresa, -1
	object_event  6, 10, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherWalt, -1
	object_event 20,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerBug_catcherArnie1, -1
	object_event  9, 10, SPRITE_JUGGLER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerJugglerIrwin, -1
	object_event  9,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerOfficerDirk, -1
	cuttree_event 21,  6, EVENT_ROUTE_35_CUT_TREE
	fruittree_event  6, 25, FRUITTREE_ROUTE_35, LEPPA_BERRY, PAL_NPC_RED
	tmhmball_event 17, 16, TM_HONE_CLAWS, EVENT_ROUTE_35_TM_HONE_CLAWS

GenericTrainerBreederTheresa:
	generictrainer BREEDER, THERESA, EVENT_BEAT_BREEDER_THERESA, BreederTheresaSeenText, BreederTheresaBeatenText

	text "I take my #mon"
	line "to get haircuts"

	para "in Goldenrod City,"
	line "and blessings in"
	cont "Ecruteak City."

	para "They're so happy!"
	done

TrainerJugglerIrwin:
	trainer JUGGLER, IRWIN1, EVENT_BEAT_JUGGLER_IRWIN, JugglerIrwin1SeenText, JugglerIrwin1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_JUGGLER_IRWIN
	opentext
	checkcellnum PHONE_JUGGLER_IRWIN
	iftrue Route35NumberAcceptedM
	checkevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext JugglerIrwinAfterBattleText
	promptbutton
	setevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_JUGGLER_IRWIN
	ifequal $1, Route35PhoneFullM
	ifequal $2, Route35NumberDeclinedM
	gettrainername JUGGLER, IRWIN1, $0
	scall Route35RegisteredNumberM
	sjump Route35NumberAcceptedM

Route35AskNumber1M:
	jumpstd asknumber1m

Route35AskNumber2M:
	jumpstd asknumber2m

Route35RegisteredNumberM:
	jumpstd registerednumberm

Route35NumberAcceptedM:
	jumpstd numberacceptedm

Route35NumberDeclinedM:
	jumpstd numberdeclinedm

Route35PhoneFullM:
	jumpstd phonefullm

Route35RematchM:
	jumpstd rematchm

GenericTrainerCamperIvan:
	generictrainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, CamperIvanSeenText, CamperIvanBeatenText

	text "Music on the radio"
	line "changes the moods"
	cont "of wild #mon."
	done

GenericTrainerCoupleGailandeli1:
	generictrainer COUPLE, GAILANDELI1, EVENT_BEAT_COUPLE_GAIL_AND_ELI, CoupleGailandeli1SeenText, CoupleGailandeli1BeatenText

	text "Eli: I was humili-"
	line "ated in front of"
	cont "my girlfriend…"
	done

GenericTrainerCoupleGailandeli2:
	generictrainer COUPLE, GAILANDELI2, EVENT_BEAT_COUPLE_GAIL_AND_ELI, CoupleGailandeli2SeenText, CoupleGailandeli2BeatenText

	text "Gail: I can count"
	line "on my #mon more"
	cont "than my boyfriend."
	done

GenericTrainerPicnickerKim:
	generictrainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, PicnickerKimSeenText, PicnickerKimBeatenText

	text "The Gym Badges are"
	line "pretty. I collect"
	cont "them."
	done

TrainerBug_catcherArnie1:
	trainer BUG_CATCHER, ARNIE1, EVENT_BEAT_BUG_CATCHER_ARNIE, Bug_catcherArnie1SeenText, Bug_catcherArnie1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BUG_CATCHER_ARNIE
	endifjustbattled
	opentext
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkflag ENGINE_YANMA_SWARM
	iftrue .YanmaSwarming
	checkcellnum PHONE_BUG_CATCHER_ARNIE
	iftrue Route35NumberAcceptedM
	checkevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BugCatcherArnieAfterBattleText
	promptbutton
	setevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	sjump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BUG_CATCHER_ARNIE
	ifequal $1, Route35PhoneFullM
	ifequal $2, Route35NumberDeclinedM
	gettrainername BUG_CATCHER, ARNIE1, $0
	scall Route35RegisteredNumberM
	sjump Route35NumberAcceptedM

.WantsBattle:
	scall Route35RematchM
	winlosstext Bug_catcherArnie1BeatenText, 0
	readmem wArnieFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
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
	loadmem wArnieFightCount, 1
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, ARNIE2
	startbattle
	reloadmapafterbattle
	loadmem wArnieFightCount, 2
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, ARNIE3
	startbattle
	reloadmapafterbattle
	loadmem wArnieFightCount, 3
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, ARNIE4
	startbattle
	reloadmapafterbattle
	loadmem wArnieFightCount, 4
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, ARNIE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE_READY_FOR_REMATCH
	end

.YanmaSwarming:
	jumpopenedtext BugCatcherArnieYanmaText

GenericTrainerFirebreatherWalt:
	generictrainer FIREBREATHER, WALT, EVENT_BEAT_FIREBREATHER_WALT, FirebreatherWaltSeenText, FirebreatherWaltBeatenText

	text "The #mon March"
	line "on the radio lures"
	cont "wild #mon."
	done

TrainerOfficerDirk:
	faceplayer
	opentext
	checktime 1 << NITE
	iffalse .NotNight
	checkevent EVENT_BEAT_OFFICERM_DIRK
	iftrue .AfterBattle
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficerDirkSeenText
	waitbutton
	closetext
	winlosstext OfficerDirkBeatenText, 0
	loadtrainer OFFICERM, DIRK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERM_DIRK
	endtext

.AfterBattle:
	jumpopenedtext OfficerDirkAfterBattleText

.NotNight:
	jumpopenedtext OfficerDirkPrettyToughText

CamperIvanSeenText:
	text "I've been getting"
	line "#mon data off"

	para "my radio. I think"
	line "I'm good."
	done

CamperIvanBeatenText:
	text "I give!"
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

CoupleGailandeli2SeenText:
	text "Gail: My boy-"
	line "friend's weak, so I"
	cont "can't rely on him."
	done

CoupleGailandeli2BeatenText:
	text "Gail: Oh, my!"
	line "You're so strong!"
	done

PicnickerKimSeenText:
	text "Are you going to"
	line "the Gym? Me too!"
	done

PicnickerKimBeatenText:
	text "Oh. I couldn't"
	line "win…"
	done

BreederTheresaSeenText:
	text "How do you care"
	line "for your #mon?"
	done

BreederTheresaBeatenText:
	text "Ah! You take good"
	line "care of them!"
	done

JugglerIrwin1SeenText:
	text "Behold my graceful"
	line "Ball dexterity!"
	done

JugglerIrwin1BeatenText:
	text "Whew! That was a"
	line "jolt!"
	done

JugglerIrwinAfterBattleText:
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

BugCatcherArnieAfterBattleText:
	text "My Venonat won me"
	line "the Bug-Catching"

	para "Contest at the"
	line "National Park."
	done

BugCatcherArnieYanmaText:
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

OfficerDirkSeenText:
	text "Danger lurks in"
	line "the night!"
	done

OfficerDirkBeatenText:
	text "Whoops!"
	done

OfficerDirkAfterBattleText:
	text "You know, night-"
	line "time is fun in its"
	cont "own ways."

	para "But don't overdo"
	line "it, OK?"
	done

OfficerDirkPrettyToughText:
	text "Your #mon look"
	line "pretty tough."

	para "You could go any-"
	line "where safely."
	done

Route35SignText:
	text "Route 35"
	done
