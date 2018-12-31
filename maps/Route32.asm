Route32_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 3
	dbw MAPCALLBACK_NEWMAP, Route32FlyPoint
	dbw MAPCALLBACK_OBJECTS, Route32Frieda
	dbw MAPCALLBACK_SPRITES, Route32SwimmerGuySprite

Route32_MapEventHeader:

.Warps: db 5
	warp_def 73, 11, 1, ROUTE_32_POKECENTER_1F
	warp_def 2, 4, 3, ROUTE_32_RUINS_OF_ALPH_GATE
	warp_def 3, 4, 4, ROUTE_32_RUINS_OF_ALPH_GATE
	warp_def 79, 6, 4, UNION_CAVE_1F
	warp_def 24, 4, 1, HIDDEN_TREE_GROTTO

.XYTriggers: db 6
	xy_trigger 0, 8, 18, Route32CooltrainerMStopsYou
	xy_trigger 1, 24, 10, Route32LyraIntroducesHiddenGrottoes1
	xy_trigger 1, 24, 11, Route32LyraIntroducesHiddenGrottoes2
	xy_trigger 1, 24, 12, Route32LyraIntroducesHiddenGrottoes3
	xy_trigger 1, 24, 13, Route32LyraIntroducesHiddenGrottoes4
	xy_trigger 2, 71, 7, Route32WannaBuyASlowpokeTailScript

.Signposts: db 7
	signpost  5, 13, SIGNPOST_JUMPTEXT, Route32SignText
	signpost  1,  9, SIGNPOST_JUMPTEXT, Route32RuinsSignText
	signpost 84, 10, SIGNPOST_JUMPTEXT, Route32UnionCaveSignText
	signpost 67, 12, SIGNPOST_ITEM + GREAT_BALL, EVENT_ROUTE_32_HIDDEN_GREAT_BALL
	signpost 40, 11, SIGNPOST_ITEM + SUPER_POTION, EVENT_ROUTE_32_HIDDEN_SUPER_POTION
	signpost 23, 4, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32
	signpost 23, 5, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32

.PersonEvents: db 17
	person_event SPRITE_COOLTRAINER_M, 8, 19, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route32CooltrainermPetrieScript, -1
	person_event SPRITE_FISHER, 70, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SlowpokeTailSalesmanScript, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_NEW_BARK_LYRA, 67, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FriedaScript, EVENT_ROUTE_32_FRIEDA_OF_FRIDAY
	person_event SPRITE_NEW_BARK_LYRA, 33, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerPicnickerLiz1, -1
	person_event SPRITE_FISHER, 49, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherJustin, -1
	person_event SPRITE_FISHER, 56, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherRalph1, -1
	person_event SPRITE_FISHER, 48, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherHenry, -1
	person_event SPRITE_YOUNGSTER, 18, 16, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterAlbert, -1
	person_event SPRITE_YOUNGSTER, 63, 4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterGordon, -1
	person_event SPRITE_YOUNGSTER, 45, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperRoland, -1
	person_event SPRITE_YOUNGSTER, 82, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperPeter, -1
	itemball_event 53, 6, GREAT_BALL, 1, EVENT_ROUTE_32_GREAT_BALL
	person_event SPRITE_FISHER, 13, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route32RoarTMGuyScript, -1
	itemball_event 32, 6, REPEL, 1, EVENT_ROUTE_32_REPEL
	cuttree_event 19, 10, EVENT_ROUTE_32_CUT_TREE
	cuttree_event 29, -1, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	cuttree_event 32, 23, EVENT_CHERRYGROVE_BAY_CUT_TREE

const_value set 1
	const ROUTE32_COOLTRAINER_M
	const ROUTE32_FISHER4
	const ROUTE32_FRIEDA
	const ROUTE32_LASS

Route32FlyPoint:
	setflag ENGINE_FLYPOINT_UNION_CAVE
	return

Route32Frieda:
	checkcode VAR_WEEKDAY
	if_equal FRIDAY, .FriedaAppears
	disappear ROUTE32_FRIEDA
	return

.FriedaAppears:
	appear ROUTE32_FRIEDA
	return

Route32SwimmerGuySprite:
	variablesprite SPRITE_GUIDE_GENT, SPRITE_SWIMMER_GUY
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
	spriteface ROUTE32_COOLTRAINER_M, LEFT
	spriteface PLAYER, RIGHT
	showtext Route32CooltrainerMText_WhatsTheHurry
	follow PLAYER, ROUTE32_COOLTRAINER_M
	applymovement PLAYER, Movement_Route32CooltrainerMPushesYouBackToViolet
	stopfollow
	spriteface PLAYER, DOWN
	scall Route32CooltrainerMTrigger
	applymovement ROUTE32_COOLTRAINER_M, Movement_Route32CooltrainerMReset
	spriteface ROUTE32_COOLTRAINER_M, LEFT
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
	moveperson ROUTE32_FRIEDA, 13, 29
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
	spriteface ROUTE32_FRIEDA, UP
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
	spriteface ROUTE32_FRIEDA, UP
	showemote EMOTE_SHOCK, ROUTE32_FRIEDA, 15
	pause 7
	follow ROUTE32_FRIEDA, PLAYER
	applyonemovement ROUTE32_FRIEDA, slow_step_up
	stopfollow
	spriteface PLAYER, UP
	pause 15
	spriteface ROUTE32_FRIEDA, DOWN
	showtext .GrottoText
	applymovement ROUTE32_FRIEDA, .LeaveMovement1
	spriteface PLAYER, DOWN
	applymovement ROUTE32_FRIEDA, .LeaveMovement2
	disappear ROUTE32_FRIEDA
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	moveperson ROUTE32_FRIEDA, 12, 67
	checkcode VAR_WEEKDAY
	if_not_equal FRIDAY, .Done
	appear ROUTE32_FRIEDA
.Done
	appear ROUTE32_LASS
	dotrigger $2
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
	spriteface ROUTE32_FISHER4, DOWN
	spriteface PLAYER, UP
	jump _OfferToSellSlowpokeTail

SlowpokeTailSalesmanScript:
	faceplayer
_OfferToSellSlowpokeTail:
	dotrigger $3
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

TrainerCamperRoland:
	trainer EVENT_BEAT_CAMPER_ROLAND, CAMPER, ROLAND, CamperRolandSeenText, CamperRolandBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer CamperRolandAfterText

TrainerFisherJustin:
	trainer EVENT_BEAT_FISHER_JUSTIN, FISHER, JUSTIN, FisherJustinSeenText, FisherJustinBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer FisherJustinAfterText

TrainerFisherRalph1:
	trainer EVENT_BEAT_FISHER_RALPH, FISHER, RALPH1, FisherRalph1SeenText, FisherRalph1BeatenText, 0, .Script

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
	scall .AskNumber1
	jump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_FISHER_RALPH
	if_equal $1, .PhoneFull
	if_equal $2, .NumberDeclined
	trainertotext FISHER, RALPH1, $0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext FisherRalph1BeatenText, 0
	copybytetovar wRalphFightCount
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

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.RematchStd:
	jumpstd rematchm
	end

TrainerFisherHenry:
	trainer EVENT_BEAT_FISHER_HENRY, FISHER, HENRY, FisherHenrySeenText, FisherHenryBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer FisherHenryAfterText

TrainerPicnickerLiz1:
	trainer EVENT_BEAT_PICNICKER_LIZ, PICNICKER, LIZ1, PicnickerLiz1SeenText, PicnickerLiz1BeatenText, 0, .Script

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
	scall .AskNumber1
	jump .AskForNumber

.AskAgain:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_LIZ
	if_equal $1, .PhoneFull
	if_equal $2, .NumberDeclined
	trainertotext PICNICKER, LIZ1, $0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerLiz1BeatenText, 0
	copybytetovar wLizFightCount
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

.AskNumber1:
	jumpstd asknumber1f
	end

.AskNumber2:
	jumpstd asknumber2f
	end

.RegisteredNumber:
	jumpstd registerednumberf
	end

.NumberAccepted:
	jumpstd numberacceptedf
	end

.NumberDeclined:
	jumpstd numberdeclinedf
	end

.PhoneFull:
	jumpstd phonefullf
	end

.RematchStd:
	jumpstd rematchf
	end

TrainerYoungsterAlbert:
	trainer EVENT_BEAT_YOUNGSTER_ALBERT, YOUNGSTER, ALBERT, YoungsterAlbertSeenText, YoungsterAlbertBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer YoungsterAlbertAfterText

TrainerYoungsterGordon:
	trainer EVENT_BEAT_YOUNGSTER_GORDON, YOUNGSTER, GORDON, YoungsterGordonSeenText, YoungsterGordonBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer YoungsterGordonAfterText

TrainerBird_keeperPeter:
	trainer EVENT_BEAT_BIRD_KEEPER_PETER, BIRD_KEEPER, PETER, Bird_keeperPeterSeenText, Bird_keeperPeterBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer Bird_keeperPeterAfterText

FriedaScript:
	checkevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	iftrue_jumptextfaceplayer FriedaFridayText
	checkcode VAR_WEEKDAY
	if_not_equal FRIDAY, .NotFriday
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

FisherJustinAfterText:
	text "Calm, collected…"
	line "The essence of"

	para "fishing and #-"
	line "mon is the same."
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

FisherHenryAfterText:
	text "Freshly caught"
	line "#mon are no"

	para "match for properly"
	line "raised ones."
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

YoungsterAlbertAfterText:
	text "I'm going to try"
	line "to be the best"
	cont "with my favorites."

	para "I'm not using the"
	line "same tough #mon"
	cont "as everyone else."
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

YoungsterGordonAfterText:
	text "The grass is full"
	line "of clingy things."
	done

CamperRolandSeenText:
	text "That glance…"
	line "It's intriguing."
	done

CamperRolandBeatenText:
	text "Hmmm. This is"
	line "disappointing."
	done

CamperRolandAfterText:
	text "If you don't want"
	line "to battle, just"
	cont "avoid eye contact."
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

Bird_keeperPeterAfterText:
	text "I should train"
	line "again at the Gym"
	cont "in Violet City."
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
