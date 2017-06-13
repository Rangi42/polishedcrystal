const_value set 2
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER
	const ELMSLAB_LYRA

ElmsLab_MapScriptHeader:
.MapTriggers:
	db 8
	dw .Trigger0
	dw .Trigger1
	dw .Trigger2
	dw .Trigger3
	dw .Trigger4
	dw .Trigger5
	dw .Trigger6
	dw .Trigger7

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_OBJECTS, .Callback_MoveElm

.Trigger0:
	priorityjump ElmsLab_AutowalkUpToElm
.Trigger1:
.Trigger2:
.Trigger3:
.Trigger4:
.Trigger5:
.Trigger6:
	end

.Trigger7:
	priorityjump ElmsLab_AutoAideSpeech
	end

.Callback_MoveElm:
	checktriggers
	iftrue .Skip
	moveperson ELMSLAB_ELM, $3, $4
.Skip:
	return

ElmsLab_AutowalkUpToElm:
	follow PLAYER, ELMSLAB_LYRA
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	stopfollow
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	spriteface ELMSLAB_ELM, RIGHT
	opentext
	writetext ElmText_Intro
ElmsLab_RefuseLoop:
	yesorno
	iftrue ElmsLab_ElmGetsEmail
	writetext ElmText_Refused
	jump ElmsLab_RefuseLoop

ElmsLab_ElmGetsEmail:
	writetext ElmText_Accepted
	buttonsound
	writetext ElmText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	spriteface ELMSLAB_ELM, DOWN
	opentext
	writetext ElmText_GotAnEmail
	waitbutton
	closetext
	opentext
	spriteface ELMSLAB_ELM, RIGHT
	writetext ElmText_MissionFromMrPokemon
	waitbutton
	closetext
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	spriteface PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	spriteface PLAYER, RIGHT
	opentext
	writetext ElmText_ChooseAPokemon
	waitbutton
	closetext
	dotrigger $1
	end

ElmsLab_AutoAideSpeech:
	spriteface ELMSLAB_ELMS_AIDE, DOWN
	showemote EMOTE_SHOCK, ELMSLAB_ELMS_AIDE, 15
	applymovement ELMSLAB_ELMS_AIDE, AideWalksDownMovement
	opentext
	writetext AideText_ThiefReturnedMon
	waitbutton
	closetext
	applymovement ELMSLAB_ELMS_AIDE, AideWalksBackMovement
	spriteface ELMSLAB_ELMS_AIDE, DOWN
	dotrigger $2
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
	iftrue ElmScript_CallYou
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue ElmGiveEverstoneScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse ElmCheckTogepiEgg
	writebyte TOGEPI
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writebyte TOGETIC
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writebyte TOGEKISS
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writetext UnknownText_0x79a40
	waitbutton
	closetext
	end

ElmEggHatchedScript:
	writebyte TOGEPI
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writebyte TOGETIC
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writebyte TOGEKISS
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	jump ElmCheckGotEggAgain

ElmCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse ElmCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue ElmEggHatchedScript
ElmCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue ElmWaitingEggHatchScript
	checkflag ENGINE_ZEPHYRBADGE
	iftrue ElmAideHasEggScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue ElmStudyingEggScript
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue ElmDescribesMrPokemonScript
	writetext ElmText_LetYourMonBattleIt
	waitbutton
	closetext
	end

LabTryToLeaveScript:
	spriteface ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x78f70
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	spriteface ELMSLAB_ELM, DOWN
	refreshscreen $0
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	buttonsound
	waitsfx
	pokenamemem CYNDAQUIL, $0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CYNDAQUIL, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksChikoritaMovement
	pause 15
	disappear ELMSLAB_POKE_BALL3
	opentext
	pokenamemem CHIKORITA, $0
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	writetext LyraNicknamedChikoritaText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterChikoritaMovement
	checkcode VAR_FACING
	if_equal RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	jump ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	spriteface ELMSLAB_ELM, DOWN
	refreshscreen $0
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	buttonsound
	waitsfx
	pokenamemem TOTODILE, $0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke TOTODILE, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksCyndaquilMovement
	pause 15
	disappear ELMSLAB_POKE_BALL1
	opentext
	pokenamemem CYNDAQUIL, $0
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	writetext LyraNicknamedCyndaquilText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterCyndaquilMovement
	applymovement PLAYER, AfterTotodileMovement
	jump ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	spriteface ELMSLAB_ELM, DOWN
	refreshscreen $0
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	buttonsound
	waitsfx
	pokenamemem CHIKORITA, $0
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CHIKORITA, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksTotodileMovement
	pause 15
	disappear ELMSLAB_POKE_BALL2
	opentext
	pokenamemem TOTODILE, $0
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	writetext LyraNicknamedTotodileText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterTotodileMovement
	applymovement PLAYER, AfterChikoritaMovement
	jump ElmDirectionsScript

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	waitbutton
	closetext
	end

ElmDirectionsScript:
	spriteface PLAYER, UP
	opentext
	writetext ElmDirectionsText1
	waitbutton
	closetext
	addcellnum PHONE_ELM
	opentext
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	spriteface ELMSLAB_ELM, LEFT
	opentext
	writetext ElmDirectionsText2
	waitbutton
	closetext
	spriteface ELMSLAB_ELM, DOWN
	opentext
	writetext ElmDirectionsText3
	waitbutton
	closetext
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	dotrigger $6
	end

ElmDescribesMrPokemonScript:
	writetext ElmDescribesMrPokemonText
	waitbutton
	closetext
	end

LookAtElmPokeBallScript:
	opentext
	writetext ElmPokeBallText
	waitbutton
	closetext
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	writetext ElmsLabHealingMachineText1
	waitbutton
	closetext
	end

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	closetext
	end

ElmsLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	closetext
	end

ElmAfterTheftDoneScript:
	waitbutton
	closetext
	end

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkitem MYSTERY_EGG
	iffalse ElmAfterTheftDoneScript
	buttonsound
	writetext ElmAfterTheftText2
	waitbutton
	takeitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	buttonsound
	writetext ElmAfterTheftText5
	buttonsound
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	setflag ENGINE_BUG_CONTEST_ON
	clearevent EVENT_LYRA_ROUTE_29
	domaptrigger ROUTE_29, $1
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	writetext ElmAfterTheftText6
	waitbutton
	closetext
	dotrigger $2
	end

ElmStudyingEggScript:
	writetext ElmStudyingEggText
	waitbutton
	closetext
	end

ElmAideHasEggScript:
	writetext ElmAideHasEggText
	waitbutton
	closetext
	end

ElmWaitingEggHatchScript:
	writetext ElmWaitingEggHatchText
	waitbutton
	closetext
	end

ShowElmTogepiScript:
	writetext ShowElmTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowElmTogepiText2
	buttonsound
	writetext ShowElmTogepiText3
	buttonsound
ElmGiveEverstoneScript:
	writetext ElmGiveEverstoneText1
	buttonsound
	verbosegiveitem EVERSTONE
	iffalse ElmScript_NoRoomForEverstone
	writetext ElmGiveEverstoneText2
	waitbutton
	closetext
	setevent EVENT_GOT_EVERSTONE_FROM_ELM
	end

ElmScript_CallYou:
	writetext ElmText_CallYou
	waitbutton
ElmScript_NoRoomForEverstone:
	closetext
	end

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	buttonsound
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext ElmGiveMasterBallText2
	waitbutton
.notdone
	closetext
	end

ElmGiveTicketScript:
	writetext ElmChallengeText
	yesorno
	iffalse .Refused
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
	buttonsound
	verbosegiveitem S_S_TICKET
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	special Special_FadeOutMusic
	pause 10
	checkcode VAR_FACING
	if_equal UP, .Longest
	if_equal DOWN, .Shortest
	disappear ELMSLAB_LYRA
	moveperson ELMSLAB_LYRA, 4, 7
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	jump .Continue

.Longest
	disappear ELMSLAB_LYRA
	moveperson ELMSLAB_LYRA, 5, 8
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	jump .Continue

.Shortest
	disappear ELMSLAB_LYRA
	moveperson ELMSLAB_LYRA, 5, 6
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInLessMovement

.Continue
	spriteface ELMSLAB_ELM, DOWN
	spriteface PLAYER, DOWN
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	opentext
	writetext LyraAnnouncesGymChallengeText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	pause 10
	faceplayer
	playmusic MUSIC_PROF_ELM
	opentext
	writetext ElmAfterTicketText
	waitbutton
	closetext
	setevent EVENT_LYRA_IN_HER_ROOM
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	end

.Refused:
	writetext ElmRefusedBattleText
	waitbutton
	closetext
	end

ElmJumpBackScript1:
	closetext
	checkcode VAR_FACING
	if_equal DOWN, ElmJumpDownScript
	if_equal UP, ElmJumpUpScript
	if_equal LEFT, ElmJumpLeftScript
	if_equal RIGHT, ElmJumpRightScript
	end

ElmJumpBackScript2:
	closetext
	checkcode VAR_FACING
	if_equal DOWN, ElmJumpUpScript
	if_equal UP, ElmJumpDownScript
	if_equal LEFT, ElmJumpRightScript
	if_equal RIGHT, ElmJumpLeftScript
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
	spriteface ELMSLAB_LYRA, DOWN
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	opentext
	writetext ElmsLabLyraChallengeText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraBattleMovement
	spriteface PLAYER, RIGHT
	winlosstext ElmsLabLyraWinText, ElmsLabLyraLossText
	setlasttalked ELMSLAB_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	loadtrainer LYRA1, LYRA1_1
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterVictorious
	jump .AfterYourDefeat

.Totodile:
	loadtrainer LYRA1, LYRA1_2
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterVictorious
	jump .AfterYourDefeat

.Chikorita:
	loadtrainer LYRA1, LYRA1_3
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftrue .AfterVictorious
	jump .AfterYourDefeat

.AfterVictorious:
	opentext
	writetext ElmsLabLyraText_YouWon
	waitbutton
	closetext
	jump .FinishLyra

.AfterYourDefeat:
	opentext
	writetext ElmsLabLyraText_YouLost
	waitbutton
	closetext
.FinishLyra:
	spriteface PLAYER, DOWN
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	special HealPartyEvenForNuzlocke
	dotrigger $5
	playmapmusic
	end

AideScript_WalkPotions1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	spriteface PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotions2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	spriteface PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotions:
	opentext
	writetext AideText_GiveYouPotions
	buttonsound
	verbosegiveitem POTION
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	dotrigger $2
	end

ElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue AideScript_AlwaysBusy
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue AideScript_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue AideScript_AlwaysBusy
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony
AideScript_AlwaysBusy:
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	end

AideScript_TheftTestimony:
	writetext AideText_TheftTestimony
	waitbutton
	closetext
	end

AideScript_AfterTheft:
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

MeetCopScript2:
	applymovement PLAYER, MeetCopScript2_StepLeft

MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	spriteface ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText1
	waitbutton
	closetext
	disappear ELMSLAB_LYRA
	moveperson ELMSLAB_LYRA, 5, 8
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	spriteface ELMSLAB_OFFICER, DOWN
	opentext
	writetext ElmsLabLyraTheftInnocentText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_OFFICER, 15
	pause 10
	spriteface ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText2
	buttonsound
	special SpecialNameRival
	writetext ElmsLabOfficerText3
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraStepsAsideMovement
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	pause 10
	spriteface ELMSLAB_LYRA, UP
	spriteface PLAYER, DOWN
	opentext
	writetext ElmsLabLyraTheftGoodbyeText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	dotrigger $2
	pause 10
	applymovement PLAYER, MeetCopScript_GiveEgg
	opentext
	jump ElmAfterTheftScript

ElmsLabLyraScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .LyraWhichPokemon
	writetext ElmsLabLyraGoodChoiceText
	waitbutton
	closetext
	end

.LyraWhichPokemon:
	writetext ElmsLabLyraWhichPokemonText
	waitbutton
	closetext
	end

ElmsLabWindow:
	opentext
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .Normal
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .BreakIn
	jump .Normal

.BreakIn:
	writetext ElmsLabWindowText2
	waitbutton
	closetext
	end

.Normal:
	writetext ElmsLabWindowText1
	waitbutton
	closetext
	end

ElmsLabTravelTip1:
	jumptext ElmsLabTravelTip1Text

ElmsLabTravelTip2:
	jumptext ElmsLabTravelTip2Text

ElmsLabTravelTip3:
	jumptext ElmsLabTravelTip3Text

ElmsLabTravelTip4:
	jumptext ElmsLabTravelTip4Text

ElmsLabTrashcan:
	jumptext ElmsLabTrashcanText

ElmsLabPC:
	jumptext ElmsLabPCText

ElmsLabBookshelf:
	jumpstd difficultbookshelf

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

MovementData_0x78f70:
	step_up
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

MeetCopScript2_StepLeft:
	step_left
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
	big_step_up
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	big_step_down
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	big_step_left
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	big_step_right
	remove_fixed_facing
	step_end

ElmsLab_ElmToDefaultPositionMovement1:
	step_up
	step_end

ElmsLab_ElmToDefaultPositionMovement2:
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
	line "@"
	text_from_ram StringBuffer3
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
	line "you with the Elm"

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

UnknownText_0x79a40:
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
	line "the Pokemon likes"
	cont "you very much."

	para "Pokemon do their"
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
	line "@"
	text_from_ram StringBuffer3
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

	para "Thank you for the"
	line "#mon, Prof."
	cont "Elm."

	para "<PLAYER>, I'll"
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
	line "real thief return"
	cont "that #mon…"

	para "See you later!"
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

ElmsLab_MapEventHeader:
.Warps:
	db 2
	warp_def $b, $4, 1, NEW_BARK_TOWN
	warp_def $b, $5, 1, NEW_BARK_TOWN

.XYTriggers:
	db 7
	xy_trigger 1, $6, $4, LabTryToLeaveScript
	xy_trigger 1, $6, $5, LabTryToLeaveScript
	xy_trigger 3, $5, $4, MeetCopScript
	xy_trigger 3, $5, $5, MeetCopScript2
	xy_trigger 5, $8, $4, AideScript_WalkPotions1
	xy_trigger 5, $8, $5, AideScript_WalkPotions2
	xy_trigger 6, $6, $4, LyraBattleScript

.Signposts:
	db 16
	signpost 1, 2, SIGNPOST_READ, ElmsLabHealingMachine
	signpost 1, 6, SIGNPOST_READ, ElmsLabBookshelf
	signpost 1, 7, SIGNPOST_READ, ElmsLabBookshelf
	signpost 1, 8, SIGNPOST_READ, ElmsLabBookshelf
	signpost 1, 9, SIGNPOST_READ, ElmsLabBookshelf
	signpost 7, 0, SIGNPOST_READ, ElmsLabTravelTip1
	signpost 7, 1, SIGNPOST_READ, ElmsLabTravelTip2
	signpost 7, 2, SIGNPOST_READ, ElmsLabTravelTip3
	signpost 7, 3, SIGNPOST_READ, ElmsLabTravelTip4
	signpost 7, 6, SIGNPOST_READ, ElmsLabBookshelf
	signpost 7, 7, SIGNPOST_READ, ElmsLabBookshelf
	signpost 7, 8, SIGNPOST_READ, ElmsLabBookshelf
	signpost 7, 9, SIGNPOST_READ, ElmsLabBookshelf
	signpost 3, 9, SIGNPOST_READ, ElmsLabTrashcan
	signpost 0, 5, SIGNPOST_READ, ElmsLabWindow
	signpost 5, 3, SIGNPOST_DOWN, ElmsLabPC

.PersonEvents:
	db 7
	person_event SPRITE_ELM, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ProfElmScript, -1
	person_event SPRITE_SCIENTIST, 9, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	person_event SPRITE_BALL_CUT_FRUIT, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_BALL_CUT_FRUIT, 3, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_BALL_CUT_FRUIT, 3, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_OFFICER, 3, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
	person_event SPRITE_LYRA, 11, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ElmsLabLyraScript, EVENT_LYRA_IN_ELMS_LAB
