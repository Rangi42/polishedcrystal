Route32_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route32FlyPoint
	callback MAPCALLBACK_OBJECTS, Route32Frieda

	db 5 ; warp events
	warp_event 11, 73, ROUTE_32_POKECENTER_1F, 1
	warp_event  4,  2, ROUTE_32_RUINS_OF_ALPH_GATE, 3
	warp_event  4,  3, ROUTE_32_RUINS_OF_ALPH_GATE, 4
	warp_event  6, 79, UNION_CAVE_1F, 4
	warp_event  4, 24, HIDDEN_TREE_GROTTO, 1

	db 6 ; coord events
	coord_event 18,  8, 0, Route32CooltrainerMStopsYou
	coord_event 10, 24, 1, Route32LyraIntroducesHiddenGrottoes1
	coord_event 11, 24, 1, Route32LyraIntroducesHiddenGrottoes2
	coord_event 12, 24, 1, Route32LyraIntroducesHiddenGrottoes3
	coord_event 13, 24, 1, Route32LyraIntroducesHiddenGrottoes4
	coord_event  7, 71, 2, Route32WannaBuyASlowpokeTailScript

	db 7 ; bg events
	bg_event 13,  5, SIGNPOST_JUMPTEXT, Route32SignText
	bg_event  9,  1, SIGNPOST_JUMPTEXT, Route32RuinsSignText
	bg_event 10, 84, SIGNPOST_JUMPTEXT, Route32UnionCaveSignText
	bg_event 12, 67, SIGNPOST_ITEM + GREAT_BALL, EVENT_ROUTE_32_HIDDEN_GREAT_BALL
	bg_event 11, 40, SIGNPOST_ITEM + SUPER_POTION, EVENT_ROUTE_32_HIDDEN_SUPER_POTION
	bg_event  4, 23, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32
	bg_event  5, 23, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32

	db 17 ; object events
	object_event 19,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, Route32CooltrainermPetrieScript, -1
	object_event  7, 70, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SlowpokeTailSalesmanScript, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event 12, 67, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FriedaScript, EVENT_ROUTE_32_FRIEDA_OF_FRIDAY
	object_event 12, 33, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_TRAINER, 1, TrainerPicnickerLiz1, -1
	object_event  8, 49, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerFisherJustin, -1
	object_event 12, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherRalph1, -1
	object_event  6, 48, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerFisherHenry, -1
	object_event 16, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterAlbert, -1
	object_event  4, 63, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterGordon, -1
	object_event  3, 45, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerCamperRoland, -1
	object_event 11, 82, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperPeter, -1
	itemball_event  6, 53, GREAT_BALL, 1, EVENT_ROUTE_32_GREAT_BALL
	object_event 15, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route32RoarTMGuyScript, -1
	itemball_event  6, 32, REPEL, 1, EVENT_ROUTE_32_REPEL
	cuttree_event 10, 19, EVENT_ROUTE_32_CUT_TREE
	cuttree_event -1, 29, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	cuttree_event 23, 32, EVENT_CHERRYGROVE_BAY_CUT_TREE

	const_def 1 ; object constants
	const ROUTE32_COOLTRAINER_M
	const ROUTE32_FISHER4
	const ROUTE32_FRIEDA
	const ROUTE32_LASS

Route32FlyPoint:
	setflag ENGINE_FLYPOINT_UNION_CAVE
	return

Route32Frieda:
	checkcode VAR_WEEKDAY
	ifequal FRIDAY, .FriedaAppears
	disappear ROUTE32_FRIEDA
	return

.FriedaAppears:
	appear ROUTE32_FRIEDA
	return

Route32CooltrainermPetrieScript:
	faceplayer
Route32CooltrainerMTrigger:
	checkflag ENGINE_ZEPHYRBADGE
	iffalse_jumptext Route32CooltrainerMText_VioletGym
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse_jumptext Route32CooltrainerMText_AideIsWaiting
	checkevent EVENT_GOT_MIRACLE_SEED_FROM_ROUTE_32_LEADER
	iftrue_jumptext .AfterText2
	checkevent EVENT_BEAT_COOLTRAINERM_PETRIE
	iftrue .Beaten
	checkevent EVENT_BEAT_CAMPER_ROLAND
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_JUSTIN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_RALPH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_HENRY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PICNICKER_LIZ
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_YOUNGSTER_ALBERT
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_YOUNGSTER_GORDON
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BIRD_KEEPER_PETER
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE32_COOLTRAINER_M
	loadtrainer COOLTRAINERM, PETRIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_PETRIE
.Beaten:
	opentext
	writetext .AfterText1
	buttonsound
	verbosegiveitem MIRACLE_SEED
	iffalse_endtext
	setevent EVENT_GOT_MIRACLE_SEED_FROM_ROUTE_32_LEADER
.GotMiracleSeed:
	thisopenedtext

.AfterText2:
	text "Your experiences"
	line "in Violet City"

	para "should be useful"
	line "for your journey."
	done

.IntroText:
	text "You have some good"
	line "#mon there."

	para "It must be from"
	line "the training you"

	para "gave them around"
	line "Violet City."

	para "You should have no"
	line "trouble beating"

	para "all the trainers"
	line "on this route."

	para "If you can do"
	line "that, I'll face you"
	cont "myself."
	done

.QuestionText:
	text "It looks like you"
	line "beat everyone else"
	cont "here."

	para "Your training at"
	line "the Gym must have"

	para "been especially"
	line "helpful."

	para "I, too, have a"
	line "Zephyr Badge."

	para "Will you battle"
	line "with me?"
	done

.RefusedText:
	text "So you would ra-"
	line "ther journey on…"
	done

.SeenText:
	text "My training in"
	line "Sprout Tower over-"
	cont "came even Falkner."

	para "Let's see how you"
	line "compare!"
	done

.BeatenText:
	text "My team was up-"
	line "rooted!"
	done

.AfterText1:
	text "Your training was"
	line "superior to mine."

	para "As a souvenir of"
	line "our battle, take"
	cont "this."

	para "It increases the"
	line "power of Grass-"
	cont "type moves."
	done

Route32CooltrainerMStopsYou:
	turnobject ROUTE32_COOLTRAINER_M, LEFT
	turnobject PLAYER, RIGHT
	showtext Route32CooltrainerMText_WhatsTheHurry
	follow PLAYER, ROUTE32_COOLTRAINER_M
	applymovement PLAYER, Movement_Route32CooltrainerMPushesYouBackToViolet
	stopfollow
	turnobject PLAYER, DOWN
	scall Route32CooltrainerMTrigger
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMReset
	turnobject ROUTE32_COOLTRAINER_M, LEFT
	end

Route32LyraIntroducesHiddenGrottoes1:
	scall Route32LyraIntroducesHiddenGrottoesIntroScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left3
	scall Route32LyraIntroducesHiddenGrottoesMainScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left5
	jump Route32LyraIntroducesHiddenGrottoesOutroScript

Route32LyraIntroducesHiddenGrottoes2:
	scall Route32LyraIntroducesHiddenGrottoesIntroScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left2
	scall Route32LyraIntroducesHiddenGrottoesMainScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left6
	jump Route32LyraIntroducesHiddenGrottoesOutroScript

Route32LyraIntroducesHiddenGrottoes3:
	scall Route32LyraIntroducesHiddenGrottoesIntroScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left1
	scall Route32LyraIntroducesHiddenGrottoesMainScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left7
	jump Route32LyraIntroducesHiddenGrottoesOutroScript

Route32LyraIntroducesHiddenGrottoes4:
	scall Route32LyraIntroducesHiddenGrottoesIntroScript
	scall Route32LyraIntroducesHiddenGrottoesMainScript
	applymovement ROUTE32_FRIEDA, Route32LyraIntroducesHiddenGrottoes_Left8
	jump Route32LyraIntroducesHiddenGrottoesOutroScript

Route32LyraIntroducesHiddenGrottoes_Left8:
	step_left
Route32LyraIntroducesHiddenGrottoes_Left7:
	step_left
Route32LyraIntroducesHiddenGrottoes_Left6:
	step_left
Route32LyraIntroducesHiddenGrottoes_Left5:
	step_left
	step_left
Route32LyraIntroducesHiddenGrottoes_Left3:
	step_left
Route32LyraIntroducesHiddenGrottoes_Left2:
	step_left
Route32LyraIntroducesHiddenGrottoes_Left1:
	step_left
	step_end

Route32LyraIntroducesHiddenGrottoesIntroScript:
	disappear ROUTE32_FRIEDA
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	moveobject ROUTE32_FRIEDA, 13, 29
	appear ROUTE32_FRIEDA
	applymovement ROUTE32_FRIEDA, .StepUpMovement
	showemote EMOTE_SHOCK, ROUTE32_FRIEDA, 15
	special Special_FadeOutMusic
	pause 15
	applymovement ROUTE32_FRIEDA, .StepUpMovement
	end

.StepUpMovement:
	step_up
	step_up
	step_end

Route32LyraIntroducesHiddenGrottoesMainScript:
	turnobject ROUTE32_FRIEDA, UP
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	opentext
	writetext .GreetingText
	buttonsound
	checkpoke EGG
	iftrue .HaveEgg
	writetext .NoEggText
	jump .Continue
.HaveEgg
	writetext .HaveEggText
.Continue
	waitbutton
	closetext
	playsound SFX_SANDSTORM
	waitsfx
	showemote EMOTE_SHOCK, ROUTE32_FRIEDA, 15
	applymovement ROUTE32_FRIEDA, .LookAroundMovement
	showtext .QuestionText
	disappear ROUTE32_LASS
	follow ROUTE32_FRIEDA, PLAYER
	end

.GreetingText:
	text "<PLAYER>!"
	line "Hi there!"
	done

.NoEggText:
	text "Prof.Elm said his"
	line "aide was deliver-"
	cont "ing an Egg to you."

	para "Be sure to carry"
	line "it. I'm curious"

	para "what #mon it"
	line "could be!"
	done

.HaveEggText:
	text "Oh good! You're"
	line "carrying that Egg"

	para "just like Prof."
	line "Elm asked."

	para "I'm so curious"
	line "what #mon it"
	cont "could be!"
	done

.QuestionText:
	text "<PLAYER>, did you"
	line "hear that?"

	para "It came from some-"
	line "where nearby…"
	done

.LookAroundMovement:
	turn_head_right
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_up
	step_end

Route32LyraIntroducesHiddenGrottoesOutroScript:
	stopfollow
	turnobject ROUTE32_FRIEDA, UP
	showemote EMOTE_SHOCK, ROUTE32_FRIEDA, 15
	pause 7
	follow ROUTE32_FRIEDA, PLAYER
	applyonemovement ROUTE32_FRIEDA, slow_step_up
	stopfollow
	turnobject PLAYER, UP
	pause 15
	turnobject ROUTE32_FRIEDA, DOWN
	showtext .GrottoText
	applymovement ROUTE32_FRIEDA, .LeaveMovement1
	turnobject PLAYER, DOWN
	applymovement ROUTE32_FRIEDA, .LeaveMovement2
	disappear ROUTE32_FRIEDA
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	moveobject ROUTE32_FRIEDA, 12, 67
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, .Done
	appear ROUTE32_FRIEDA
.Done
	appear ROUTE32_LASS
	setscene $2
	playmusic MUSIC_ROUTE_30
	end

.GrottoText:
	text "Here it is!"
	line "There's a gap in"
	cont "the trees!"

	para "I've heard of these"
	line "places before."

	para "It's a Hidden"
	line "Grotto!"

	para "Hidden Grottoes"
	line "are found among"
	cont "trees and cliff-"
	cont "sides."

	para "Some amazing #-"
	line "mon might be"
	cont "hiding in there!"

	para "I wish I had time"
	line "to look around,"

	para "but I have things"
	line "to do."

	para "<PLAYER>, keep an"
	line "eye out for more"
	cont "Hidden Grottoes!"
	done

.LeaveMovement1:
	step_left
	step_down
	step_end

.LeaveMovement2:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

Route32WannaBuyASlowpokeTailScript:
	turnobject ROUTE32_FISHER4, DOWN
	turnobject PLAYER, UP
	jump _OfferToSellSlowpokeTail

SlowpokeTailSalesmanScript:
	faceplayer
_OfferToSellSlowpokeTail:
	setscene $3
	opentext
	writetext Text_MillionDollarSlowpokeTail
	yesorno
	iffalse .refused
	jumpopenedtext Text_ThoughtKidsWereLoaded

.refused
	jumpopenedtext Text_RefusedToBuySlowpokeTail

Route32RoarTMGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM05_ROAR
	iftrue .AlreadyHaveRoar
	writetext Text_RoarIntro
	buttonsound
	verbosegivetmhm TM_ROAR
	setevent EVENT_GOT_TM05_ROAR
.AlreadyHaveRoar:
	jumpopenedtext Text_RoarOutro

GenericTrainerCamperRoland:
	generictrainer CAMPER, ROLAND, EVENT_BEAT_CAMPER_ROLAND, CamperRolandSeenText, CamperRolandBeatenText

	text "If you don't want"
	line "to battle, just"
	cont "avoid eye contact."
	done

GenericTrainerFisherJustin:
	generictrainer FISHER, JUSTIN, EVENT_BEAT_FISHER_JUSTIN, FisherJustinSeenText, FisherJustinBeatenText

	text "Calm, collected…"
	line "The essence of"

	para "fishing and #-"
	line "mon is the same."
	done

TrainerFisherRalph1:
	trainer FISHER, RALPH1, EVENT_BEAT_FISHER_RALPH, FisherRalph1SeenText, FisherRalph1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_FISHER_RALPH
	opentext
	checkflag ENGINE_RALPH
	iftrue .Rematch
	checkflag ENGINE_SPECIAL_WILDDATA
	iftrue .Swarm
	checkcellnum PHONE_FISHER_RALPH
	iftrue .NumberAccepted
	checkevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext FisherRalphAfterText
	buttonsound
	setevent EVENT_RALPH_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	jump .AskForNumber

.AskAgain:
	callstd asknumber2m
.AskForNumber:
	askforphonenumber PHONE_FISHER_RALPH
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	trainertotext FISHER, RALPH1, $0
	callstd registerednumberm
	jumpstd numberacceptedm

.Rematch:
	callstd rematchm
	winlosstext FisherRalph1BeatenText, 0
	copybytetovar wRalphFightCount
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
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer FISHER, RALPH1
	startbattle
	reloadmapafterbattle
	loadvar wRalphFightCount, 1
	clearflag ENGINE_RALPH
	end

.LoadFight1:
	loadtrainer FISHER, RALPH2
	startbattle
	reloadmapafterbattle
	loadvar wRalphFightCount, 2
	clearflag ENGINE_RALPH
	end

.LoadFight2:
	loadtrainer FISHER, RALPH3
	startbattle
	reloadmapafterbattle
	loadvar wRalphFightCount, 3
	clearflag ENGINE_RALPH
	end

.LoadFight3:
	loadtrainer FISHER, RALPH4
	startbattle
	reloadmapafterbattle
	loadvar wRalphFightCount, 4
	clearflag ENGINE_RALPH
	end

.LoadFight4:
	loadtrainer FISHER, RALPH5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_RALPH
	end

.Swarm:
	jumpopenedtext FisherRalphSwarmText

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

GenericTrainerFisherHenry:
	generictrainer FISHER, HENRY, EVENT_BEAT_FISHER_HENRY, FisherHenrySeenText, FisherHenryBeatenText

	text "Freshly caught"
	line "#mon are no"

	para "match for properly"
	line "raised ones."
	done

TrainerPicnickerLiz1:
	trainer PICNICKER, LIZ1, EVENT_BEAT_PICNICKER_LIZ, PicnickerLiz1SeenText, PicnickerLiz1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_PICNICKER_LIZ
	opentext
	checkflag ENGINE_LIZ
	iftrue .Rematch
	checkcellnum PHONE_PICNICKER_LIZ
	iftrue .NumberAccepted
	checkevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerLiz1AfterText
	buttonsound
	setevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1f
	jump .AskForNumber

.AskAgain:
	callstd asknumber2f
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_LIZ
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	trainertotext PICNICKER, LIZ1, $0
	callstd registerednumberf
	jumpstd numberacceptedf

.Rematch:
	callstd rematchf
	winlosstext PicnickerLiz1BeatenText, 0
	copybytetovar wLizFightCount
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
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer PICNICKER, LIZ1
	startbattle
	reloadmapafterbattle
	loadvar wLizFightCount, 1
	clearflag ENGINE_LIZ
	end

.LoadFight1:
	loadtrainer PICNICKER, LIZ2
	startbattle
	reloadmapafterbattle
	loadvar wLizFightCount, 2
	clearflag ENGINE_LIZ
	end

.LoadFight2:
	loadtrainer PICNICKER, LIZ3
	startbattle
	reloadmapafterbattle
	loadvar wLizFightCount, 3
	clearflag ENGINE_LIZ
	end

.LoadFight3:
	loadtrainer PICNICKER, LIZ4
	startbattle
	reloadmapafterbattle
	loadvar wLizFightCount, 4
	clearflag ENGINE_LIZ
	end

.LoadFight4:
	loadtrainer PICNICKER, LIZ5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ
	end

.NumberAccepted:
	jumpstd numberacceptedf

.NumberDeclined:
	jumpstd numberdeclinedf

.PhoneFull:
	jumpstd phonefullf

GenericTrainerYoungsterAlbert:
	generictrainer YOUNGSTER, ALBERT, EVENT_BEAT_YOUNGSTER_ALBERT, YoungsterAlbertSeenText, YoungsterAlbertBeatenText

	text "I'm going to try"
	line "to be the best"
	cont "with my favorites."

	para "I'm not using the"
	line "same tough #mon"
	cont "as everyone else."
	done

GenericTrainerYoungsterGordon:
	generictrainer YOUNGSTER, GORDON, EVENT_BEAT_YOUNGSTER_GORDON, YoungsterGordonSeenText, YoungsterGordonBeatenText

	text "The grass is full"
	line "of clingy things."
	done

GenericTrainerBird_keeperPeter:
	generictrainer BIRD_KEEPER, PETER, EVENT_BEAT_BIRD_KEEPER_PETER, Bird_keeperPeterSeenText, Bird_keeperPeterBeatenText

	text "I should train"
	line "again at the Gym"
	cont "in Violet City."
	done

FriedaScript:
	checkevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	iftrue_jumptextfaceplayer FriedaFridayText
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	faceplayer
	opentext
	checkevent EVENT_MET_FRIEDA_OF_FRIDAY
	iftrue .MetFrieda
	writetext MeetFriedaText
	buttonsound
	setevent EVENT_MET_FRIEDA_OF_FRIDAY
.MetFrieda:
	writetext FriedaGivesGiftText
	buttonsound
	verbosegiveitem POISON_BARB
	iffalse_endtext
	setevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	jumpopenedtext FriedaGaveGiftText

.NotFriday:
	jumptextfaceplayer FriedaNotFridayText

Movement_Route32CooltrainerMPushesYouBackToViolet:
	step_up
	step_up
	step_end

Movement_Route32CooltrainerMReset:
	step_down
	step_right
	step_end

Route32CooltrainerMText_WhatsTheHurry:
	text "Wait up!"
	line "What's the hurry?"
	done

Route32CooltrainerMText_AideIsWaiting:
	text "<PLAYER>, right?"
	line "Some guy wearing"

	para "glasses was look-"
	line "ing for you."

	para "See for yourself."
	line "He's waiting for"

	para "you at the #mon"
	line "Center."
	done

Route32CooltrainerMText_VioletGym:
	text "Have you gone to"
	line "the #mon Gym?"

	para "You can test your"
	line "#mon and your-"
	cont "self there."

	para "It's a rite of"
	line "passage for all"
	cont "trainers!"
	done

Text_MillionDollarSlowpokeTail:
	text "How would you like"
	line "to have this"

	para "tasty, nutritious"
	line "SlowpokeTail?"

	para "For you right now,"
	line "just ¥10,000,000!"

	para "You'll want this!"
	done

Text_ThoughtKidsWereLoaded:
	text "Tch! I thought"
	line "kids these days"
	cont "were loaded…"
	done

Text_RefusedToBuySlowpokeTail:
	text "You don't want it?"
	line "Then scram. Shoo!"
	done

FisherJustinSeenText:
	text "Whoa!"

	para "You made me lose"
	line "that fish!"
	done

FisherJustinBeatenText:
	text "Sploosh!"
	done

FisherRalph1SeenText:
	text "I'm really good at"
	line "both fishing and"
	cont "#mon."

	para "I'm not about to"
	line "lose to any kid!"
	done

FisherRalph1BeatenText:
	text "Tch! I tried to"
	line "rush things…"
	done

FisherRalphAfterText:
	text "Fishing is a life-"
	line "long passion."

	para "#mon are life-"
	line "long friends!"
	done

FisherRalphSwarmText:
	text "One, two, three…"
	line "Muahahaha, what a"

	para "great haul!"
	line "I'm done! Go ahead"

	para "and catch as many"
	line "as you can, kid!"
	done

FisherHenrySeenText:
	text "My #mon?"
	line "Freshly caught!"
	done

FisherHenryBeatenText:
	text "Splash?"
	done

YoungsterAlbertSeenText:
	text "I haven't seen you"
	line "around before."

	para "So you think you"
	line "are pretty tough?"
	done

YoungsterAlbertBeatenText:
	text "You're strong!"
	done

YoungsterGordonSeenText:
	text "I found some good"
	line "#mon in the"
	cont "grass!"

	para "I think they'll do"
	line "it for me!"
	done

YoungsterGordonBeatenText:
	text "Darn. I thought I"
	line "could win."
	done

CamperRolandSeenText:
	text "That glance…"
	line "It's intriguing."
	done

CamperRolandBeatenText:
	text "Hmmm. This is"
	line "disappointing."
	done

PicnickerLiz1SeenText:
	text "Uh-huh. Yeah, and"
	line "you know…"

	para "Pardon? Battle?"
	line "I'm on the phone."

	para "Oh, all right. But"
	line "make it fast."
	done

PicnickerLiz1BeatenText:
	text "Oh! I've got to"
	line "relieve my anger!"
	done

PicnickerLiz1AfterText:
	text "I was having a"
	line "nice chat too."
	done

Bird_keeperPeterSeenText:
	text "That Badge! It's"
	line "from Violet City!"

	para "You beat Falkner?"
	done

Bird_keeperPeterBeatenText:
	text "I know what my"
	line "weaknesses are."
	done

Text_RoarIntro:
	text "WROOOOAR!"
	line "PEOPLE RUN WHEN I"

	para "ROAR! BUT YOU"
	line "CAME LOOKING!"

	para "THAT PLEASES ME!"
	line "NOW TAKE THIS!"
	done

Text_RoarOutro:
	text "WROOOAR!"
	line "IT'S ROAR!"

	para "EVEN POKéMON RUN"
	line "FROM A GOOD ROAR!"
	done

MeetFriedaText:
	text "Frieda: Yahoo!"
	line "It's Friday!"

	para "I'm Frieda of"
	line "Friday!"

	para "Nice to meet you!"
	done

FriedaGivesGiftText:
	text "Here's a Poison"
	line "Barb for you!"
	done

FriedaGaveGiftText:
	text "Frieda: Give it to"
	line "a #mon that has"
	cont "Poison-type moves."

	para "Oh!"

	para "It's wicked!"

	para "You'll be shocked"
	line "how good it makes"
	cont "Poison moves!"
	done

FriedaFridayText:
	text "Frieda: Hiya! What"
	line "day do you like?"

	para "I love Friday. No"
	line "doubt about it!"

	para "Don't you think"
	line "it's great too?"
	done

FriedaNotFridayText:
	text "Frieda: Isn't it"
	line "Friday today?"

	para "It's so boring"
	line "when it's not!"
	done

Route32SignText:
	text "Route 32"

	para "Violet City -"
	line "Azalea Town"
	done

Route32RuinsSignText:
	text "Ruins of Alph"
	line "East Entrance"
	done

Route32UnionCaveSignText:
	text "Union Cave"
	line "Ahead"
	done
