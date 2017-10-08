Route34_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, Route34RebattleBreederAndEggCheckCallback

Route34_MapEventHeader:

.Warps: db 5
	warp_def 37, 13, 1, ROUTE_34_ILEX_FOREST_GATE
	warp_def 37, 14, 2, ROUTE_34_ILEX_FOREST_GATE
	warp_def 14, 11, 1, DAYCARE
	warp_def 15, 11, 2, DAYCARE
	warp_def 15, 13, 3, DAYCARE

.XYTriggers: db 3
	xy_trigger 1, 17, 8, Route34LyraTrigger1
	xy_trigger 1, 17, 9, Route34LyraTrigger2
	xy_trigger 1, 17, 10, Route34LyraTrigger3

.Signposts: db 5
	signpost 6, 12, SIGNPOST_JUMPTEXT, Route34SignText
	signpost 33, 13, SIGNPOST_JUMPTEXT, Route34TrainerTipsText
	signpost 13, 10, SIGNPOST_JUMPTEXT, DayCareSignText
	signpost 32, 8, SIGNPOST_ITEM + RARE_CANDY, EVENT_ROUTE_34_HIDDEN_RARE_CANDY
	signpost 19, 17, SIGNPOST_ITEM + SUPER_POTION, EVENT_ROUTE_34_HIDDEN_SUPER_POTION

.PersonEvents: db 14
	person_event SPRITE_RICH_BOY, 20, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route34RichBoyIrvingScript, -1
	person_event SPRITE_GRAMPS, 15, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DayCareManScript_Outside, EVENT_DAYCARE_MAN_ON_ROUTE_34
	person_event SPRITE_GOLDENROD_LYRA, 12, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_ROUTE_34
	person_event SPRITE_YOUNGSTER, 7, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerCamperTodd1, -1
	person_event SPRITE_BREEDER, 32, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerBreederJulie, -1
	person_event SPRITE_LASS, 26, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerPicnickerGina1, -1
	person_event SPRITE_OFFICER_F, 10, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerfMaraScript, -1
	person_event SPRITE_POKEFAN_M, 28, 18, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerPokefanmBrandon, -1
	person_event SPRITE_DAYCARE_MON_1, 18, 14, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DaycareMon1Script, EVENT_DAYCARE_MON_1
	person_event SPRITE_DAYCARE_MON_2, 19, 17, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DaycareMon2Script, EVENT_DAYCARE_MON_2
	person_event SPRITE_COOLTRAINER_F, 48, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerCooltrainerfIrene, -1
	person_event SPRITE_COOLTRAINER_F, 48, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainerfJenn, -1
	person_event SPRITE_COOLTRAINER_F, 51, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainerfKate, -1
	itemball_event 30, 7, NUGGET, 1, EVENT_ROUTE_34_NUGGET

const_value set 1
	const ROUTE34_RICH_BOY
	const ROUTE34_GRAMPS
	const ROUTE34_LYRA

Route34RebattleBreederAndEggCheckCallback:
	clearevent EVENT_BEAT_BREEDER_JULIE
	checkflag ENGINE_DAYCARE_MAN_HAS_EGG
	iftrue .PutDaycareManOutside
	checktriggers
	iftrue .PutDaycareManOutside
	clearevent EVENT_DAYCARE_MAN_IN_DAYCARE
	setevent EVENT_DAYCARE_MAN_ON_ROUTE_34
	jump .CheckMon1

.PutDaycareManOutside:
	setevent EVENT_DAYCARE_MAN_IN_DAYCARE
	clearevent EVENT_DAYCARE_MAN_ON_ROUTE_34
	jump .CheckMon1

.CheckMon1:
	checkflag ENGINE_DAYCARE_MAN_HAS_MON
	iffalse .HideMon1
	clearevent EVENT_DAYCARE_MON_1
	jump .CheckMon2

.HideMon1:
	setevent EVENT_DAYCARE_MON_1
	jump .CheckMon2

.CheckMon2:
	checkflag ENGINE_DAYCARE_LADY_HAS_MON
	iffalse .HideMon2
	clearevent EVENT_DAYCARE_MON_2
	return

.HideMon2:
	setevent EVENT_DAYCARE_MON_2
	return

Route34LyraTrigger1:
	applyonemovement PLAYER, step_right
	jump Route34LyraTrigger2

Route34LyraTrigger3:
	applyonemovement PLAYER, step_left
Route34LyraTrigger2:
	spriteface PLAYER, UP
	special Special_FadeOutMusic
	showtext Route34LyraText_Grandpa
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	appear ROUTE34_LYRA
	spriteface ROUTE34_GRAMPS, UP
	pause 10
	applymovement ROUTE34_LYRA, Route34MovementData_LyraComesDown
	spriteface ROUTE34_GRAMPS, LEFT
	showtext Route34LyraGoodWorkText
	showemote EMOTE_SHOCK, ROUTE34_LYRA, 15
	pause 15
	spriteface ROUTE34_LYRA, DOWN
	showtext Route34LyraGreetingText
	applyonemovement PLAYER, step_up
	pause 10
	spriteface ROUTE34_LYRA, RIGHT
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .IntroduceFemale
	writetext Route34LyraIntroductionText1
	jump .Continue
.IntroduceFemale:
	writetext Route34LyraIntroductionText2
.Continue:
	waitbutton
	closetext
	spriteface ROUTE34_LYRA, DOWN
	pause 10
	showtext Route34LyraChallengeText
	setevent EVENT_LYRA_ROUTE_34
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext Route34LyraWinText, Route34LyraLossText
	setlasttalked ROUTE34_LYRA
	loadtrainer LYRA1, LYRA1_4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	jump .AfterBattle

.Totodile:
	winlosstext Route34LyraWinText, Route34LyraLossText
	setlasttalked ROUTE34_LYRA
	loadtrainer LYRA1, LYRA1_5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	jump .AfterBattle

.Chikorita:
	winlosstext Route34LyraWinText, Route34LyraLossText
	setlasttalked ROUTE34_LYRA
	loadtrainer LYRA1, LYRA1_6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
.AfterBattle
	showtext Route34LyraFollowMeText
	applyonemovement ROUTE34_GRAMPS, slow_step_right
	playsound SFX_EXIT_BUILDING
	disappear ROUTE34_GRAMPS
	follow ROUTE34_LYRA, PLAYER
	applymovement ROUTE34_LYRA, Route34MovementData_LyraEntersDayCare
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear ROUTE34_LYRA
	applyonemovement PLAYER, step_right
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	dotrigger $0
	special FadeOutPalettes
	pause 15
	variablesprite SPRITE_GOLDENROD_LYRA, SPRITE_SWIMMER_GIRL
	warpfacing RIGHT, DAYCARE, 0, 4
	end

DayCareManScript_Outside:
	faceplayer
	opentext
	special Special_DayCareManOutside
	waitbutton
	closetext
	if_equal $1, .end_fail
	clearflag ENGINE_DAYCARE_MAN_HAS_EGG
	checkcode VAR_FACING
	if_equal LEFT, .walk_around_player
	applyonemovement ROUTE34_GRAMPS, slow_step_right
	playsound SFX_ENTER_DOOR
	disappear ROUTE34_GRAMPS
.end_fail
	end

.walk_around_player
	applymovement ROUTE34_GRAMPS, Route34MovementData_DayCareManWalksBackInside_WalkAroundPlayer
	playsound SFX_ENTER_DOOR
	disappear ROUTE34_GRAMPS
	end

DaycareMon1Script:
	opentext
	special Special_DayCareMon1
	endtext

DaycareMon2Script:
	opentext
	special Special_DayCareMon2
	endtext

TrainerCamperTodd1:
	trainer EVENT_BEAT_CAMPER_TODD, CAMPER, TODD1, CamperTodd1SeenText, CamperTodd1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_CAMPER_TODD
	opentext
	checkflag ENGINE_TODD
	iftrue .Rematch
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleIsOn
	checkcellnum PHONE_CAMPER_TODD
	iftrue .NumberAccepted
	checkevent EVENT_TODD_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext CamperTodd1AfterText
	buttonsound
	setevent EVENT_TODD_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	jump .FinishAsk

.AskAgain:
	scall .AskNumber2
.FinishAsk:
	askforphonenumber PHONE_CAMPER_TODD
	if_equal $1, .PhoneFull
	if_equal $2, .NumberDeclined
	trainertotext CAMPER, TODD1, $0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext CamperTodd1BeatenText, 0
	copybytetovar wToddFightCount
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
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer CAMPER, TODD1
	startbattle
	reloadmapafterbattle
	loadvar wToddFightCount, 1
	clearflag ENGINE_TODD
	end

.LoadFight1:
	loadtrainer CAMPER, TODD2
	startbattle
	reloadmapafterbattle
	loadvar wToddFightCount, 2
	clearflag ENGINE_TODD
	end

.LoadFight2:
	loadtrainer CAMPER, TODD3
	startbattle
	reloadmapafterbattle
	loadvar wToddFightCount, 3
	clearflag ENGINE_TODD
	end

.LoadFight3:
	loadtrainer CAMPER, TODD4
	startbattle
	reloadmapafterbattle
	loadvar wToddFightCount, 4
	clearflag ENGINE_TODD
	end

.LoadFight4:
	loadtrainer CAMPER, TODD5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD
	end

.SaleIsOn:
	jumpopenedtext CamperToddSaleText

.AskNumber:
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

TrainerPicnickerGina1:
	trainer EVENT_BEAT_PICNICKER_GINA, PICNICKER, GINA1, PicnickerGina1SeenText, PicnickerGina1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_PICNICKER_GINA
	end_if_just_battled
	opentext
	checkflag ENGINE_GINA
	iftrue .Rematch
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue .LeafStone
	checkcellnum PHONE_PICNICKER_GINA
	iftrue .NumberAccepted
	checkevent EVENT_GINA_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerGina1AfterText
	buttonsound
	setevent EVENT_GINA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	jump .FinishAsk

.AskAgain:
	scall .AskNumber2
.FinishAsk:
	askforphonenumber PHONE_PICNICKER_GINA
	if_equal $1, .PhoneFull
	if_equal $2, .NumberDeclined
	trainertotext PICNICKER, GINA1, $0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerGina1BeatenText, 0
	copybytetovar wGinaFightCount
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
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer PICNICKER, GINA1
	startbattle
	reloadmapafterbattle
	loadvar wGinaFightCount, 1
	clearflag ENGINE_GINA
	end

.LoadFight1:
	loadtrainer PICNICKER, GINA2
	startbattle
	reloadmapafterbattle
	loadvar wGinaFightCount, 2
	clearflag ENGINE_GINA
	end

.LoadFight2:
	loadtrainer PICNICKER, GINA3
	startbattle
	reloadmapafterbattle
	loadvar wGinaFightCount, 3
	clearflag ENGINE_GINA
	end

.LoadFight3:
	loadtrainer PICNICKER, GINA4
	startbattle
	reloadmapafterbattle
	loadvar wGinaFightCount, 4
	clearflag ENGINE_GINA
	end

.LoadFight4:
	loadtrainer PICNICKER, GINA5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA
	end

.LeafStone:
	scall .Gift
	verbosegiveitem LEAF_STONE
	iffalse .BagFull
	clearflag ENGINE_GINA_HAS_LEAF_STONE
	setevent EVENT_GINA_GAVE_LEAF_STONE
	jump .NumberAccepted

.BagFull:
	jump .PackFull

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

.Gift:
	jumpstd giftf
	end

.PackFull:
	jumpstd packfullf
	end

OfficerfMaraScript:
	faceplayer
	opentext
	checknite
	iffalse .NoFight
	checkevent EVENT_BEAT_OFFICERF_MARA
	iftrue .AfterScript
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficerfMaraSeenText
	waitbutton
	closetext
	winlosstext OfficerfMaraWinText, 0
	loadtrainer OFFICERF, MARA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERF_MARA
	endtext

.AfterScript:
	jumpopenedtext OfficerfMaraAfterText

.NoFight:
	jumpopenedtext OfficerfMaraDaytimeText

TrainerBreederJulie:
	trainer EVENT_BEAT_BREEDER_JULIE, BREEDER, JULIE, BreederJulieSeenText, BreederJulieBeatenText, 0, .Script

.Script:
	setevent EVENT_BEAT_BREEDER_JULIE_ONCE
	end_if_just_battled
	jumptextfaceplayer BreederJulieAfterText

Route34RichBoyIrvingScript:
	checkevent EVENT_GOT_BIG_NUGGET_FROM_ROUTE_34_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_RICH_BOY_IRVING
	iftrue .Beaten
	checkevent EVENT_BEAT_CAMPER_TODD
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PICNICKER_GINA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_OFFICERF_MARA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANM_BRANDON
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BREEDER_JULIE_ONCE
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE34_RICH_BOY
	loadtrainer RICH_BOY, IRVING
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_RICH_BOY_IRVING
.Beaten:
	opentext
	writetext .AfterText1
	buttonsound
	verbosegiveitem BIG_NUGGET
	iffalse_endtext
	setevent EVENT_GOT_BIG_NUGGET_FROM_ROUTE_34_LEADER
	thisopenedtext

.AfterText2:
	text "There are some"
	line "things that money"
	cont "can't buy."
	done

.IntroText:
	text "I don't need to"
	line "gamble for Coins."

	para "I'm rich, so I"
	line "bought my #-"
	cont "mon with cash!"

	para "They're strong"
	line "enough that we"
	cont "beat Azalea's Gym!"

	para "You want to battle"
	line "them? Fine--just"

	para "beat everyone else"
	line "here first!"
	done

.QuestionText:
	text "You really did it!"
	line "Well then,"
	cont "noblesse oblige."

	para "Are you ready to"
	line "fight my top-shelf"
	cont "team?"
	done

.RefusedText:
	text "Not so desperate"
	line "for prize money"
	cont "after all?"
	done

.SeenText:
	text "I'm a cut above"
	line "the commoners"
	cont "you beat here!"
	done

.BeatenText:
	text "No! My money"
	line "wasn't enough…"
	done

.AfterText1:
	text "You've clearly"
	line "earned this item."

	para "Sell it and go on"
	line "a shopping spree,"

	para "or keep it as a"
	line "memento of our"
	cont "battle."
	done

TrainerPokefanmBrandon:
	trainer EVENT_BEAT_POKEFANM_BRANDON, POKEFANM, BRANDON, PokefanmBrandonSeenText, PokefanmBrandonBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer PokefanmBrandonAfterText

TrainerCooltrainerfIrene:
	trainer EVENT_BEAT_COOLTRAINERF_IRENE, COOLTRAINERF, IRENE, CooltrainerfIreneSeenText, CooltrainerfIreneBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	checkevent EVENT_GOT_POWER_HERB_FROM_KATE
	iftrue .GotPowerHerb
	jumpopenedtext CooltrainerfIreneAfterText1

.GotPowerHerb:
	jumpopenedtext CooltrainerfIreneAfterText2

TrainerCooltrainerfJenn:
	trainer EVENT_BEAT_COOLTRAINERF_JENN, COOLTRAINERF, JENN, CooltrainerfJennSeenText, CooltrainerfJennBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	checkevent EVENT_GOT_POWER_HERB_FROM_KATE
	iftrue .GotPowerHerb
	jumpopenedtext CooltrainerfJennAfterText1

.GotPowerHerb:
	jumpopenedtext CooltrainerfJennAfterText2

TrainerCooltrainerfKate:
	trainer EVENT_BEAT_COOLTRAINERF_KATE, COOLTRAINERF, KATE, CooltrainerfKateSeenText, CooltrainerfKateBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	checkevent EVENT_GOT_POWER_HERB_FROM_KATE
	iftrue .GotPowerHerb
	writetext CooltrainerfKateOfferPowerHerbText
	buttonsound
	verbosegiveitem POWER_HERB
	iffalse .BagFull
	setevent EVENT_GOT_POWER_HERB_FROM_KATE
.GotPowerHerb:
	writetext CooltrainerfKateAfterText
	waitbutton
.BagFull:
	endtext

Route34MovementData_DayCareManWalksBackInside_WalkAroundPlayer:
	slow_step_up
	slow_step_right
	step_end

Route34MovementData_LyraComesDown:
	step_down
	step_down
	step_down
	step_right
	step_end

Route34MovementData_LyraEntersDayCare:
	step_right
	step_right
	step_end

Route34LyraText_Grandpa:
	text "Lyra: Grandpa!"
	done

Route34LyraGoodWorkText:
	text "Lyra: Good work,"
	line "Grandpa!"

	para "The #mon you"
	line "raised for me is"
	cont "healthy as can be!"

	para "You look fit,"
	line "too!"
	done

Route34LyraGreetingText:
	text "Lyra: Hi, <PLAYER>!"
	done

Route34LyraIntroductionText1:
	text "This is <PLAYER>."
	line "He's a trainer."

	para "He's quite good at"
	line "raising #mon."

	para "Well, not as good"
	line "as you, of course!"
	done

Route34LyraIntroductionText2:
	text "This is <PLAYER>."
	line "She's a trainer."

	para "She's quite good at"
	line "raising #mon."

	para "Well, not as good"
	line "as you, of course!"
	done

Route34LyraChallengeText:
	text "<PLAYER>, why don't"
	line "we show Grandpa"
	cont "how good you are?"
	done

Route34LyraWinText:
	text "You're even better"
	line "than I thought!"
	done

Route34LyraLossText:
	text "Well, you're still"
	line "getting better…"
	done

Route34LyraFollowMeText:
	text "Lyra: Let me"
	line "introduce you to"
	cont "Grandma, too!"
	done

BreederJulieSeenText:
	text "This is where I"
	line "train my baby"
	cont "#mon!"
	done

BreederJulieBeatenText:
	text "Beaten by a"
	line "passing stranger!"
	done

BreederJulieAfterText:
	text "One of my #mon"
	line "has an Adamant"

	para "nature. Another"
	line "has a Lax nature."

	para "It seems to make"
	line "a difference in"
	cont "battle."
	done

CamperTodd1SeenText:
	text "I'm confident in"
	line "my ability to"
	cont "raise #mon."

	para "Want to see?"
	done

CamperTodd1BeatenText:
	text "Did I screw up my"
	line "training?"
	done

CamperTodd1AfterText:
	text "Maybe I should"
	line "take one to a Day-"

	para "Care. Or maybe use"
	line "some items…"
	done

CamperToddSaleText:
	text "Shopping under the"
	line "sky!"

	para "It feels so nice"
	line "up on a rooftop."
	done

PicnickerGina1SeenText:
	text "Are you a trainer?"

	para "Let's have a"
	line "practice battle."
	done

PicnickerGina1BeatenText:
	text "Oh, no! I just"
	line "can't win…"
	done

PicnickerGina1AfterText:
	text "You're too strong"
	line "to be a practice"
	cont "partner."
	done

OfficerfMaraSeenText:
	text "Who goes there?"
	line "What are you up"
	cont "to?"
	done

OfficerfMaraWinText:
	text "You're a tough"
	line "little kid."
	done

OfficerfMaraAfterText:
	text "Yes, I see nothing"
	line "wrong today. You"

	para "be good and stay"
	line "out of trouble."
	done

OfficerfMaraDaytimeText:
	text "I'm on patrol for"
	line "suspicious indi-"
	cont "viduals."
	done

PokefanmBrandonSeenText:
	text "I just got my"
	line "#mon back from"
	cont "Day-Care."

	para "Let's see how much"
	line "stronger it got!"
	done

PokefanmBrandonBeatenText:
	text "Why does it end"
	line "this way?"
	done

PokefanmBrandonAfterText:
	text "My #mon knew"
	line "moves I didn't"
	cont "know it had."

	para "That confounded me"
	line "to no end!"
	done

CooltrainerfIreneSeenText:
	text "Irene: Kyaaah!"
	line "Someone found us!"
	done

CooltrainerfIreneBeatenText:
	text "Irene: Ohhh!"
	line "Too strong!"
	done

CooltrainerfIreneAfterText1:
	text "Irene: My sister"
	line "Kate will get you"
	cont "for this!"
	done

CooltrainerfIreneAfterText2:
	text "Irene: Isn't this"
	line "beach great?"

	para "It's our secret"
	line "little getaway!"
	done

CooltrainerfJennSeenText:
	text "Jenn: You can't"
	line "beat Kate and go"
	cont "unpunished!"
	done

CooltrainerfJennBeatenText:
	text "Jenn: So sorry,"
	line "Kate! Sis!"
	done

CooltrainerfJennAfterText1:
	text "Jenn: Don't get"
	line "cocky! My sister"
	cont "Kate is tough!"
	done

CooltrainerfJennAfterText2:
	text "Jenn: Sunlight"
	line "makes your body"
	cont "stronger."
	done

CooltrainerfKateSeenText:
	text "Kate: You sure"
	line "were mean to my"
	cont "little sisters!"
	done

CooltrainerfKateBeatenText:
	text "Kate: No! I can't"
	line "believe I lost."
	done

CooltrainerfKateOfferPowerHerbText:
	text "Kate: You're too"
	line "strong. I didn't"
	cont "stand a chance."

	para "Here. You deserve"
	line "this."
	done

CooltrainerfKateAfterText:
	text "Kate: I'm sorry we"
	line "jumped you."

	para "We never expected"
	line "anyone to find us"

	para "here. You sure"
	line "startled us."
	done

Route34SignText:
	text "Route 34"

	para "Goldenrod City -"
	line "Azalea Town"

	para "Ilex Forest"
	line "Somewhere Between"
	done

Route34TrainerTipsText:
	text "Trainer Tips"

	para "Berry trees grow"
	line "new Berries"
	cont "every day."

	para "Make a note of"
	line "which trees bear"
	cont "which Berries."
	done

DayCareSignText:
	text "Day-Care"

	para "Let Us Raise Your"
	line "#mon For You!"
	done
