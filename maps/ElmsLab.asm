ElmsLab_MapScriptHeader:
	def_scene_scripts
	scene_script ElmsLabTrigger0
	scene_script ElmsLabTrigger1
	scene_script ElmsLabTrigger2
	scene_script ElmsLabTrigger3
	scene_script ElmsLabTrigger4
	scene_script ElmsLabTrigger5
	scene_script ElmsLabTrigger6
	scene_script ElmsLabTrigger7

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ElmsLabCallback_MoveElm

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, 1, LabTryToLeaveScript
	coord_event  5,  6, 1, LabTryToLeaveScript
	coord_event  4,  5, 3, MeetCopScript
	coord_event  5,  5, 3, MeetCopScript2
	coord_event  4,  8, 5, AideScript_WalkPotions1
	coord_event  5,  8, 5, AideScript_WalkPotions2
	coord_event  4,  6, 6, LyraBattleScript

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  6,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  0,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip1Text
	bg_event  1,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip2Text
	bg_event  2,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip3Text
	bg_event  3,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip4Text
	bg_event  6,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  3, BGEVENT_JUMPTEXT, ElmsLabTrashcanText
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  6,  3, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
	object_event  5, 11, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsLabLyraScript, EVENT_LYRA_IN_ELMS_LAB

	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER
	const ELMSLAB_LYRA

ElmsLabTrigger0:
	sdefer ElmsLab_AutowalkUpToElm
ElmsLabTrigger1:
ElmsLabTrigger2:
ElmsLabTrigger3:
ElmsLabTrigger4:
ElmsLabTrigger5:
ElmsLabTrigger6:
	end

ElmsLabTrigger7:
	sdefer ElmsLab_AutoAideSpeech
	end

ElmsLabCallback_MoveElm:
	checkscene
	iftrue .Skip
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback

ElmsLab_AutowalkUpToElm:
	follow PLAYER, ELMSLAB_LYRA
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	stopfollow
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	opentext
	writetext ElmText_Intro
ElmsLab_RefuseLoop:
	yesorno
	iftrue ElmsLab_ElmGetsEmail
	writetext ElmText_Refused
	sjump ElmsLab_RefuseLoop

ElmsLab_ElmGetsEmail:
if !DEF(DEBUG)
	writetext ElmText_Accepted
	promptbutton
	writetext ElmText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	showtext ElmText_GotAnEmail
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext ElmText_MissionFromMrPokemon
	waitbutton
endc
	closetext
	applyonemovement ELMSLAB_ELM, step_up
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement
	turnobject PLAYER, RIGHT
	showtext ElmText_ChooseAPokemon
	setscene $1
	end

ElmsLab_AutoAideSpeech:
	turnobject ELMSLAB_ELMS_AIDE, DOWN
	showemote EMOTE_SHOCK, ELMSLAB_ELMS_AIDE, 15
	applymovement ELMSLAB_ELMS_AIDE, AideWalksDownMovement
	showtext AideText_ThiefReturnedMon
	applymovement ELMSLAB_ELMS_AIDE, AideWalksBackMovement
	turnobject ELMSLAB_ELMS_AIDE, DOWN
	setscene $2
	end

ProfElmScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue ElmCheckMasterBall
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue ElmGiveTicketScript
ElmCheckMasterBall:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue ElmCheckEverstone
	checkflag ENGINE_RISINGBADGE
	iftrue ElmGiveMasterBallScript
ElmCheckEverstone:
	checkevent EVENT_GOT_EVERSTONE_FROM_ELM
	iftrue_jumpopenedtext ElmText_CallYou
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue ElmGiveEverstoneScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse ElmCheckTogepiEgg
	setval TOGEPI
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGEKISS
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	jumpopenedtext ElmThoughtEggHatchedText

ElmEggHatchedScript:
	setval TOGEPI
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGEKISS
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	sjump ElmCheckGotEggAgain

ElmCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse ElmCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue ElmEggHatchedScript
ElmCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue_jumpopenedtext ElmWaitingEggHatchText
	checkflag ENGINE_ZEPHYRBADGE
	iftrue_jumpopenedtext ElmAideHasEggText
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumpopenedtext ElmStudyingEggText
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumpopenedtext ElmDescribesMrPokemonText
	jumpopenedtext ElmText_LetYourMonBattleIt

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	showtext LabWhereGoingText
	applyonemovement PLAYER, step_up
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke CYNDAQUIL, NO_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksChikoritaMovement
	pause 15
	disappear ELMSLAB_POKE_BALL3
	opentext
	getmonname CHIKORITA, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedChikoritaText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterChikoritaMovement
	readvar VAR_FACING
	ifequal RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke TOTODILE, NO_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksCyndaquilMovement
	pause 15
	disappear ELMSLAB_POKE_BALL1
	opentext
	getmonname CYNDAQUIL, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedCyndaquilText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterCyndaquilMovement
	applymovement PLAYER, AfterTotodileMovement
	sjump ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	refreshscreen
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke CHIKORITA, NO_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksTotodileMovement
	pause 15
	disappear ELMSLAB_POKE_BALL2
	opentext
	getmonname TOTODILE, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedTotodileText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterTotodileMovement
	applymovement PLAYER, AfterChikoritaMovement
	sjump ElmDirectionsScript

ElmDirectionsScript:
	turnobject PLAYER, UP
if !DEF(DEBUG)
	showtext ElmDirectionsText1
endc
	addcellnum PHONE_ELM
	opentext
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	showtext ElmDirectionsText2
	turnobject ELMSLAB_ELM, DOWN
	showtext ElmDirectionsText3
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene $6
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	jumpopenedtext ElmsLabHealingMachineText1

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	endtext

ElmsLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	endtext

ElmAfterTheftDoneScript:
	waitendtext

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkkeyitem MYSTERY_EGG
	iffalse ElmAfterTheftDoneScript
	promptbutton
	writetext ElmAfterTheftText2
	waitbutton
	takekeyitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	promptbutton
	writetext ElmAfterTheftText5
	promptbutton
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	setflag ENGINE_BUG_CONTEST_ON
	clearevent EVENT_LYRA_ROUTE_29
	setmapscene ROUTE_29, $1
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	setscene $2
	jumpopenedtext ElmAfterTheftText6

ShowElmTogepiScript:
	writetext ShowElmTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowElmTogepiText2
	promptbutton
	writetext ShowElmTogepiText3
	promptbutton
ElmGiveEverstoneScript:
	writetext ElmGiveEverstoneText1
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse_endtext
	setevent EVENT_GOT_EVERSTONE_FROM_ELM
	jumpopenedtext ElmGiveEverstoneText2

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse_endtext
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	jumpopenedtext ElmGiveMasterBallText2

ElmGiveTicketScript:
	writetext ElmChallengeText
	yesorno
	iffalse_jumpopenedtext ElmRefusedBattleText
	writetext ElmSeenText
	waitbutton
	closetext
	winlosstext ElmWinText, 0
	setlasttalked ELMSLAB_ELM
	loadtrainer PROF_ELM, 1
	startbattle
	reloadmapafterbattle
	opentext
	writetext ElmGiveTicketText1
	promptbutton
	verbosegivekeyitem S_S_TICKET
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	special Special_FadeOutMusic
	pause 10
	readvar VAR_FACING
	ifequal UP, .Longest
	ifequal DOWN, .Shortest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 4, 7
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	sjump .Continue

.Longest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 5, 8
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	sjump .Continue

.Shortest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 5, 6
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInLessMovement

.Continue
	turnobject ELMSLAB_ELM, DOWN
	turnobject PLAYER, DOWN
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext LyraAnnouncesGymChallengeText
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	pause 10
	faceplayer
	playmusic MUSIC_PROF_ELM
	showtext ElmAfterTicketText
	setevent EVENT_LYRA_IN_HER_ROOM
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	end

ElmJumpBackScript1:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpDownScript
	ifequal UP, ElmJumpUpScript
	ifequal LEFT, ElmJumpLeftScript
	ifequal RIGHT, ElmJumpRightScript
	end

ElmJumpBackScript2:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpUpScript
	ifequal UP, ElmJumpDownScript
	ifequal LEFT, ElmJumpRightScript
	ifequal RIGHT, ElmJumpLeftScript
	end

ElmJumpUpScript:
	applymovement ELMSLAB_ELM, ElmJumpUpMovement
	opentext
	end

ElmJumpDownScript:
	applymovement ELMSLAB_ELM, ElmJumpDownMovement
	opentext
	end

ElmJumpLeftScript:
	applymovement ELMSLAB_ELM, ElmJumpLeftMovement
	opentext
	end

ElmJumpRightScript:
	applymovement ELMSLAB_ELM, ElmJumpRightMovement
	opentext
	end

LyraBattleScript:
	turnobject ELMSLAB_LYRA, DOWN
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext ElmsLabLyraChallengeText
	applymovement ELMSLAB_LYRA, LyraBattleMovement
	turnobject PLAYER, RIGHT
	winlosstext ElmsLabLyraWinText, ElmsLabLyraLossText
	setlasttalked ELMSLAB_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	loadtrainer LYRA1, LYRA1_1
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterYourDefeat
	sjump .AfterVictorious

.Totodile:
	loadtrainer LYRA1, LYRA1_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterVictorious
	sjump .AfterYourDefeat

.Chikorita:
	loadtrainer LYRA1, LYRA1_3
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterVictorious
	sjump .AfterYourDefeat

.AfterVictorious:
	showtext ElmsLabLyraText_YouWon
	sjump .FinishLyra

.AfterYourDefeat:
	showtext ElmsLabLyraText_YouLost
.FinishLyra:
	turnobject ELMSLAB_LYRA, UP
	opentext
	writetext ElmsLabLyraThankYouText
	waitbutton
	turnobject ELMSLAB_LYRA, LEFT
	writetext ElmsLabLyraSeeYouText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	special HealPartyEvenForNuzlocke
	setscene $5
	playmapmusic
	end

AideScript_WalkPotions1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotions2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotions:
	opentext
	writetext AideText_GiveYouPotions
	promptbutton
	verbosegiveitem POTION
	setscene $2
	jumpopenedtext AideText_AlwaysBusy

ElmsAideScript:
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue_jumptextfaceplayer AideText_AlwaysBusy
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue_jumptextfaceplayer AideText_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer AideText_AlwaysBusy
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue_jumptextfaceplayer AideText_TheftTestimony
	jumptextfaceplayer AideText_AlwaysBusy

MeetCopScript2:
	applyonemovement PLAYER, step_left
MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	showtext ElmsLabOfficerText1
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 5, 8
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	turnobject ELMSLAB_OFFICER, DOWN
	showtext ElmsLabLyraTheftInnocentText
	pause 10
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText2
	promptbutton
	special SpecialNameRival
	writetext ElmsLabOfficerText3
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraStepsAsideMovement
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	pause 10
	turnobject ELMSLAB_LYRA, UP
	turnobject PLAYER, DOWN
	showtext ElmsLabLyraTheftGoodbyeText
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	setscene $2
	pause 10
	applymovement PLAYER, MeetCopScript_GiveEgg
	opentext
	sjump ElmAfterTheftScript

ElmsLabLyraScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse_jumptextfaceplayer ElmsLabLyraWhichPokemonText
	jumptextfaceplayer ElmsLabLyraGoodChoiceText

ElmsLabWindow:
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue_jumptext ElmsLabWindowText1
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue_jumptext ElmsLabWindowText2
	jumptext ElmsLabWindowText1

ElmsLabPC:
	jumptext ElmsLabPCText

ElmsLab_WalkUpToElmMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	turn_head_left
	step_end

LyraPicksChikoritaMovement:
	step_right
LyraPicksTotodileMovement:
	step_right
LyraPicksCyndaquilMovement:
	step_right
	step_right
	step_up
	step_end

LyraAfterChikoritaMovement:
	step_down
	step_left
	step_left
	step_left
	turn_head_up
	step_end

LyraAfterTotodileMovement:
	step_down
	step_left
	step_left
	turn_head_up
	step_end

LyraAfterCyndaquilMovement:
	step_down
	step_left
	turn_head_up
	step_end

LyraBattleMovement:
	step_down
	turn_head_left
	step_end

LyraLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

LyraRunsInMovement:
	step_up
LyraRunsInLessMovement:
	step_up
	step_up
	step_up
	step_end

LyraStepsAsideMovement:
	step_left
	turn_head_right
	step_end

MeetCopScript_WalkUp:
	step_up
	step_up
	turn_head_right
	step_end

MeetCopScript_GiveEgg:
	step_right
	turn_head_up
	step_end

OfficerLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

AideWalksRight1:
	step_right
	step_right
	turn_head_up
	step_end

AideWalksRight2:
	step_right
	step_right
	step_right
	turn_head_up
	step_end

AideWalksLeft1:
	step_left
	step_left
	turn_head_down
	step_end

AideWalksLeft2:
	step_left
	step_left
	step_left
	turn_head_down
	step_end

AideWalksDownMovement:
	step_right
	step_right
	step_down
	step_end

AideWalksBackMovement:
	step_up
	step_left
	step_left
	step_end

ElmJumpUpMovement:
	fix_facing
	run_step_up
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	run_step_down
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	step_end

ElmsLab_ElmToDefaultPositionMovement:
	step_right
	step_right
	step_up
	turn_head_down
	step_end

AfterCyndaquilMovement:
	step_left
	step_up
	turn_head_up
	step_end

AfterTotodileMovement:
	step_left
	step_left
	step_up
	turn_head_up
	step_end

AfterChikoritaMovement:
	step_left
	step_left
	step_left
	step_up
	turn_head_up
	step_end

ElmText_Intro:
	text "Elm: <PLAYER>!"
	line "There you are!"

if !DEF(DEBUG)
	para "Hello to you too,"
	line "Lyra."

	para "I needed to ask"
	line "you both a favor."

	para "You see…"

	para "I'm writing a"
	line "paper that I want"

	para "to present at a"
	line "conference."

	para "But there are some"
	line "things I don't"

	para "quite understand"
	line "yet."

	para "So!"

	para "I'd like you both"
	line "to raise #mon"

	para "that I recently"
	line "caught."
endc
	done

ElmText_Accepted:
	text "Thanks, <PLAYER>!"

	para "You're a great"
	line "help!"
	done

ElmText_Refused:
	text "But… Please, I"
	line "need your help!"
	done

ElmText_ResearchAmbitions:
	text "When I announce my"
	line "findings, I'm sure"

	para "we'll delve a bit"
	line "deeper into the"

	para "many mysteries of"
	line "#mon."

	para "You can count on"
	line "it!"
	done

ElmText_GotAnEmail:
	text "Oh, hey! I got an"
	line "e-mail!"

	para "………………"
	line "Hm… Uh-huh…"

	para "OK…"
	done

ElmText_MissionFromMrPokemon:
	text "Hey, listen."

	para "I have an acquain-"
	line "tance called Mr."
	cont "#mon."

	para "He keeps finding"
	line "weird things and"

	para "raving about his"
	line "discoveries."

	para "Anyway, I just got"
	line "an e-mail from him"

	para "saying that this"
	line "time it's real."

	para "It is intriguing,"
	line "but we're busy"

	para "with our #mon"
	line "research…"

	para "Wait!"

	para "I know!"

	para "<PLAYER>, can you"
	line "go in our place?"
	done

ElmText_ChooseAPokemon:
	text "I want you to"
	line "raise one of the"

	para "#mon contained"
	line "in these Balls."

	para "You'll be that"
	line "#mon's first"
	cont "partner, <PLAYER>!"

	para "Go on. Pick one!"
	done

ElmText_LetYourMonBattleIt:
	text "If a wild #mon"
	line "appears, let your"
	cont "#mon battle it!"
	done

LabWhereGoingText:
	text "Elm: Wait! Where"
	line "are you going?"
	done

TakeCyndaquilText:
	text "Elm: You'll take"
	line "Cyndaquil, the"
	cont "fire #mon?"
	done

TakeTotodileText:
	text "Elm: Do you want"
	line "Totodile, the"
	cont "water #mon?"
	done

TakeChikoritaText:
	text "Elm: So, you like"
	line "Chikorita, the"
	cont "grass #mon?"
	done

DidntChooseStarterText:
	text "Elm: Think it over"
	line "carefully."

	para "Your partner is"
	line "important."
	done

ChoseStarterText:
	text "Elm: I think"
	line "that's a great"
	cont "#mon too!"
	done

ReceivedStarterText:
	text "<PLAYER> received"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

ElmDirectionsText1:
	text "Mr.#mon lives a"
	line "little bit beyond"

	para "Cherrygrove, the"
	line "next city over."

	para "It's almost a"
	line "direct route"

	para "there, so you"
	line "can't miss it."

	para "But just in case,"
	line "here's my phone"

	para "number. Call me if"
	line "anything comes up!"
	done

ElmDirectionsText2:
	text "If your #mon is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "Feel free to use"
	line "it anytime."
	done

ElmDirectionsText3:
	text "<PLAYER>, I'm"
	line "counting on you!"
	done

GotElmsNumberText:
	text "<PLAYER> got Elm's"
	line "phone number."
	done

ElmDescribesMrPokemonText:
	text "Mr.#mon goes"
	line "everywhere and"
	cont "finds rarities."

	para "Too bad they're"
	line "just rare and"
	cont "not very useful…"
	done

ElmPokeBallText:
	text "It contains a"
	line "#mon caught by"
	cont "Prof.Elm."
	done

ElmsLabHealingMachineText1:
	text "I wonder what this"
	line "does?"
	done

ElmsLabHealingMachineText2:
	text "Would you like to"
	line "heal your #mon?"
	done

ElmAfterTheftText1:
	text "Elm: <PLAYER>, this"
	line "is terrible…"

	para "Oh, yes, what was"
	line "Mr.#mon's big"
	cont "discovery?"
	done

ElmAfterTheftText2:
	text "<PLAYER> handed"
	line "the Mystery Egg to"
	cont "Prof.Elm."
	done

ElmAfterTheftText3:
	text "Elm: This?"
	done

ElmAfterTheftText4:
	text "But… Is it a"
	line "#mon Egg?"

	para "If it is, it is a"
	line "great discovery!"
	done

ElmAfterTheftText5:
	text "Elm: What?!"

if !DEF(DEBUG)
	para "Prof.Oak gave you"
	line "a #dex?"

	para "<PLAYER>, is that"
	line "true? Th-that's"
	cont "incredible!"

	para "He is superb at"
	line "seeing the poten-"
	cont "tial of people as"
	cont "trainers."

	para "Wow, <PLAYER>. You"
	line "may have what it"

	para "takes to become"
	line "the Champion."

	para "You seem to be"
	line "getting on great"
	cont "with #mon too."

	para "You should take"
	line "the #mon Gym"
	cont "challenge."

	para "The closest Gym"
	line "would be the one"
	cont "in Violet City."
endc
	done

ElmAfterTheftText6:
	text "…<PLAYER>. The"
	line "road to the"

	para "championship will"
	line "be a long one."

	para "Before you leave,"
	line "make sure that you"
	cont "talk to your mom."
	done

ElmStudyingEggText:
	text "Elm: Don't give"
	line "up! I'll call if"

	para "I learn anything"
	line "about that Egg!"
	done

ElmAideHasEggText:
	text "Elm: <PLAYER>?"
	line "Didn't you meet my"
	cont "assistant?"

	para "He should have met"
	line "you with the Egg"

	para "at Violet City's"
	line "#mon Center."

	para "You must have just"
	line "missed him. Try to"
	cont "catch him there."
	done

ElmWaitingEggHatchText:
	text "Elm: Hey, has that"
	line "Egg changed any?"
	done

ElmThoughtEggHatchedText:
	text "<PLAYER>? I thought"
	line "the Egg hatched."

	para "Where is the"
	line "#mon?"
	done

ShowElmTogepiText1:
	text "Elm: <PLAYER>, you"
	line "look great!"
	done

ShowElmTogepiText2:
	text "What?"
	line "That #mon?!"
	done

ShowElmTogepiText3:
	text "The Egg hatched!"
	line "So, #mon are"
	cont "born from Eggs…"

	para "No, perhaps not"
	line "all #mon are."

	para "Wow, there's still"
	line "a lot of research"
	cont "to be done."
	done

ElmGiveEverstoneText1:
	text "Thanks, <PLAYER>!"
	line "You're helping"

	para "unravel #mon"
	line "mysteries for us!"

	para "I want you to have"
	line "this as a token of"
	cont "our appreciation."
	done

ElmGiveEverstoneText2:
	text "That's an"
	line "Everstone."

	para "Some species of"
	line "#mon evolve"

	para "when they grow to"
	line "certain levels."

	para "A #mon holding"
	line "the Everstone"
	cont "won't evolve."

	para "Give it to a #-"
	line "mon you don't want"
	cont "to evolve."
	done

ElmText_CallYou:
	text "Elm: <PLAYER>, I'll"
	line "call you if any-"
	cont "thing comes up."
	done

AideText_AfterTheft:
	text "…sigh… That"
	line "stolen #mon."

	para "I wonder how it's"
	line "doing."

	para "They say a #mon"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

AideText_ThiefReturnedMon:
	text "<PLAYER>!"
	line "Guess what!"

	para "The boy who took"
	line "the Professor's"
	cont "#mon…"

	para "…came back to"
	line "return it!"

	para "But Prof.Elm said"
	line "to him…"

	para "“It seems that"
	line "the #mon likes"
	cont "you very much."

	para "#mon do their"
	line "best with someone"
	cont "they love."

	para "I think it should"
	line "stay with you.”"

	para "…Isn't it moving?"
	line "It made me cry!"

	para "I saw the boy's"
	line "face as he left."

	para "He looked so"
	line "happy!"
	done

ElmGiveMasterBallText1:
	text "Elm: Hi, <PLAYER>!"
	line "Thanks to you, my"

	para "research is going"
	line "great!"

	para "Take this as a"
	line "token of my"
	cont "appreciation."
	done

ElmGiveMasterBallText2:
	text "The Master Ball is"
	line "the best!"

	para "It's the ultimate"
	line "Ball! It'll catch"

	para "any #mon with-"
	line "out fail."

	para "It's given only to"
	line "recognized #mon"
	cont "researchers."

	para "I think you can"
	line "make much better"

	para "use of it than I"
	line "can, <PLAYER>!"
	done

ElmChallengeText:
	text "Elm: <PLAYER>!"
	line "There you are!"

	para "I called because I"
	line "have something for"
	cont "you."

	para "But first…"

	para "I'd like to try"
	line "battling the new"
	cont "Champion!"

	para "How about it,"
	line "<PLAYER>?"
	done

ElmSeenText:
	text "Show me how much"
	line "you've grown since"

	para "you left New Bark"
	line "Town!"
	done

ElmWinText:
	text "Astounding!"
	done

ElmRefusedBattleText:
	text "If your #mon"
	line "need healing,"

	para "just use the"
	line "machine here."
	done

ElmGiveTicketText1:
	text "Elm: I'm proud"
	line "of you, <PLAYER>."

	para "You're clearly"
	line "ready for this."

	para "See? It's an"
	line "S.S.Ticket."

	para "Now you can catch"
	line "#mon in Kanto."

	para "You can also take"
	line "on new Gyms."

	para "If you earn eight"
	line "more badges,"

	para "the Elite Four"
	line "will battle you"

	para "with all their"
	line "strength."
	done

ElmGiveTicketText2:
	text "The ship departs"
	line "from Olivine City."

	para "But you knew that"
	line "already, <PLAYER>."

	para "After all, you've"
	line "traveled all over"
	cont "with your #mon."

	para "Oh, that reminds"
	line "me!"

	para "Battle Tower has"
	line "just opened up"
	cont "near Olivine."

	para "A champ like you"
	line "should do well"
	cont "competing there!"
	done

LyraAnnouncesGymChallengeText:
	text "Lyra: There you"
	line "are, <PLAYER>!"

	para "I saw your battle"
	line "with the Champion"
	cont "on TV."

	para "You were incred-"
	line "ible!"

	para "It really inspired"
	line "me, <PLAYER>."

	para "Even if I can't"
	line "reach that level…"
	cont "I want to try."

	para "I want to see what"
	line "I'm capable of."

	para "Prof.Elm, I'm"
	line "sorry I can't keep"
	cont "helping out here."

	para "I'm going to"
	line "challenge all the"

	para "Gyms in Johto and"
	line "make it to the"
	cont "#mon League!"

	para "Wish me luck!"
	line "See you later!"
	done

ElmAfterTicketText:
	text "Elm: Well then,"
	line "<PLAYER>, you both"

	para "have your own"
	line "journeys now."

	para "I wonder if she'll"
	line "reach the League"
	cont "first?"

	para "Give my regards to"
	line "Prof.Oak in Kanto!"
	done

AideText_GiveYouPotions:
	text "<PLAYER>, I want"
	line "you to have this"
	cont "for your errand."
	done

AideText_AlwaysBusy:
	text "There are only two"
	line "of us, so we're"
	cont "always busy."
	done

AideText_TheftTestimony:
	text "There was a loud"
	line "noise outside…"

	para "When we went to"
	line "look, someone"
	cont "stole a #mon."

	para "It's unbelievable"
	line "that anyone would"
	cont "do that!"

	para "…sigh… That"
	line "stolen #mon."

	para "I wonder how it's"
	line "doing."

	para "They say a #mon"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

ElmsLabOfficerText1:
	text "I heard a #mon"
	line "was stolen here."

	para "Rule number one!"
	line "“The criminal will"

	para "always return to"
	line "the scene of the"
	cont "crime…”"

	para "Oh my… So you're"
	line "the thief?"
	done

ElmsLabOfficerText2:
	text "What?"

	para "You battled a"
	line "trainer like that?"

	para "Did you happen to"
	line "get his name?"
	done

ElmsLabOfficerText3:
	text "OK! So <RIVAL>"
	line "was his name."

	para "Thanks for helping"
	line "my investigation!"
	done

ElmsLabLyraWhichPokemonText:
	text "Which #mon are"
	line "you going to pick,"
	cont "<PLAYER>?"
	done

LyraChoosesStarterText:
	text "Lyra: Then I'll"
	line "pick this one!"
	done

LyraReceivedStarterText:
	text "Lyra received"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

LyraNicknamedChikoritaText:
	text "Lyra: It's so"
	line "cute! I'll nick-"
	cont "name it Chicory!"
	done

LyraNicknamedCyndaquilText:
	text "Lyra: It's so"
	line "cute! I'll nick-"
	cont "name it Cinder!"
	done

LyraNicknamedTotodileText:
	text "Lyra: It's so"
	line "cute! I'll nick-"
	cont "name it Toto!"
	done

ElmsLabLyraGoodChoiceText:
	text "Your #mon"
	line "looks cute too!"
	done

ElmsLabLyraChallengeText:
	text "Lyra: <PLAYER>!"
	line "Let's get to know"

	para "our #mon with"
	line "a battle!"
	done

ElmsLabLyraWinText:
	text "Good job,"
	line "<PLAYER>!"
	done

ElmsLabLyraLossText:
	text "Yay! I won!"
	done

ElmsLabLyraText_YouWon:
ElmsLabLyraText_YouLost:
	text "That was an"
	line "exciting battle!"
	done

ElmsLabLyraThankYouText:
	text "Thank you for the"
	line "#mon, Prof."
	cont "Elm."
	done

ElmsLabLyraSeeYouText:
	text "<PLAYER>, I'll"
	line "see you later!"

	para "Have fun on your"
	line "errand!"
	done

ElmsLabLyraTheftInnocentText:
	text "Lyra: Hold on!"
	line "<PLAYER> has noth-"
	cont "ing to do with it!"

	para "I saw a red-haired"
	line "boy spying on the"
	cont "building!"
	done

ElmsLabLyraTheftGoodbyeText:
	text "Lyra: <PLAYER>,"
	line "I'm glad he under-"

	para "stood that you're"
	line "innocent."

	para "I hope he makes"
	line "the thief return"
	cont "that #mon…"

	para "Well then, see"
	line "you later!"
	done

ElmsLabWindowText1:
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
	done

ElmsLabWindowText2:
	text "He broke in"
	line "through here!"
	done

ElmsLabTravelTip1Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 1:"

	para "Press Start to"
	line "open the Menu."
	done

ElmsLabTravelTip2Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 2:"

	para "Record your trip"
	line "with Save!"
	done

ElmsLabTravelTip3Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 3:"

	para "Open your Bag and"
	line "press Select to"
	cont "move items."
	done

ElmsLabTravelTip4Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 4:"

	para "Check your #mon"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

ElmsLabTrashcanText:
	text "The wrapper from"
	line "the snack Prof.Elm"
	cont "ate is in there…"
	done

ElmsLabPCText:
	text "Observations On"
	line "#mon Evolution"

	para "…It says on the"
	line "screen…"
	done
