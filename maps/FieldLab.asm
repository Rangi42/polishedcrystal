FieldLab_MapScriptHeader:
	def_scene_scripts
	; scene_script FieldLabTrigger0
	; scene_script FieldLabTrigger1
	; scene_script FieldLabTrigger2
	; scene_script FieldLabTrigger3
	; scene_script FieldLabTrigger4
	; scene_script FieldLabTrigger5
	; scene_script FieldLabTrigger6
	; scene_script FieldLabTrigger7

	def_callbacks
	; callback MAPCALLBACK_OBJECTS, FieldLabCallback_MovePawpaw

	def_warp_events
	warp_event  9,  8, HOLLOWPORT, 2
	warp_event 14,  0, FIELD_LAB_2F, 2

	def_coord_events
	coord_event  1,  5, 1, FieldLabTryToLeaveScript
	coord_event  6,  5, 1, FieldLabTryToLeaveScript
	coord_event  7,  5, 1, FieldLabTryToLeaveScript
	coord_event  8,  5, 1, FieldLabTryToLeaveScript
	coord_event  9,  5, 1, FieldLabTryToLeaveScript
	coord_event 16,  5, 1, FieldLabTryToLeaveScript
	; coord_event  6,  5, 5, AssistantScript_WalkPotions1
	; coord_event  7,  5, 5, AssistantScript_WalkPotions2
	; coord_event 10,  5, 6, RivalBattleScript

	def_bg_events
	bg_event  3,  3, BGEVENT_READ, FieldLabHealingMachine
	bg_event 10,  0, BGEVENT_JUMPTEXT, FieldLabTravelTip1Text
	bg_event 11,  0, BGEVENT_JUMPTEXT, FieldLabTravelTip2Text
	bg_event 10,  4, BGEVENT_JUMPTEXT, FieldLabTravelTip3Text
	bg_event 11,  4, BGEVENT_JUMPTEXT, FieldLabTravelTip4Text
	bg_event  4,  0, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  5,  0, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  1, BGEVENT_JUMPTEXT, FieldLabTrashcanText
	bg_event  5,  5, BGEVENT_JUMPTEXT, FieldLabTrashcanText
	bg_event 10,  9, BGEVENT_READ, FieldLabWindow
	bg_event  2,  9, BGEVENT_READ, FieldLabWindow
	bg_event  4,  9, BGEVENT_READ, FieldLabWindow
	bg_event  6,  9, BGEVENT_READ, FieldLabWindow
	bg_event 12,  9, BGEVENT_READ, FieldLabWindow
	bg_event  3,  5, BGEVENT_DOWN, FieldLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfPawpawScript, -1
	; object_event  3,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FieldLabAssistantText, -1
	; object_event 11,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FieldAssistantScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  6,  1, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_POKE_BALL, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  1, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_DECO_ITEM, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  1, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_KEY_ITEM, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	; object_event 10,  2, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FieldLabRivalScript, EVENT_LYRA_IN_ELMS_LAB

	object_const_def
	const ELMSLAB_ELM
	; const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	; const ELMSLAB_LYRA

; FieldLabTrigger0:
; 	sdefer FieldLab_AutowalkUpToPawpaw
; FieldLabTrigger1:
; FieldLabTrigger2:
; FieldLabTrigger3:
; FieldLabTrigger4:
; FieldLabTrigger5:
; FieldLabTrigger6:
; 	end

; FieldLabTrigger7:
; 	sdefer FieldLab_AutoAssistantSpeech
; 	end

; FieldLabCallback_MovePawpaw:
; 	checkscene
; 	iftruefwd .Skip
; 	moveobject ELMSLAB_ELM, 3, 4
; .Skip:
; 	endcallback

ProfPawpawScript:
	faceplayer
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	opentext
	writetext PawpawText_Intro
	FieldLab_RefuseLoop:
	yesorno
	iftruefwd FieldLab_PawpawGetsEmail
	writetext PawpawText_Refused
	sjump FieldLab_RefuseLoop

FieldLab_PawpawGetsEmail:
if !DEF(DEBUG)
	writetext PawpawText_Accepted
	promptbutton
	writetext PawpawText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	showtext PawpawText_GotAnEmail
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext PawpawText_MissionFromMrPokemon
	waitbutton
endc
	closetext
	applyonemovement ELMSLAB_ELM, step_up
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, FieldLab_PawpawToDefaultPositionMovement
	turnobject PLAYER, RIGHT
	showtext PawpawText_ChooseAPokemon
	setscene $1
	end

; FieldLab_AutoAssistantSpeech:
; 	turnobject ELMSLAB_ELMS_AIDE, DOWN
; 	showemote EMOTE_SHOCK, ELMSLAB_ELMS_AIDE, 15
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksDownMovement
; 	showtext AssistantText_ThiefReturnedMon
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksBackMovement
; 	turnobject ELMSLAB_ELMS_AIDE, DOWN
; 	setscene $2
; 	end


; 	opentext
; 	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
; 	iftruefwd PawpawCheckMasterBall
; 	checkevent EVENT_BEAT_ELITE_FOUR
; 	iftrue PawpawGiveTicketScript
; PawpawCheckMasterBall:
; 	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
; 	iftruefwd PawpawCheckOddSouvenir
; 	checkflag ENGINE_RISINGBADGE
; 	iftrue PawpawGiveMasterBallScript
; PawpawCheckOddSouvenir:
; 	checkevent EVENT_GOT_ODD_SOUVENIR_FROM_ELM
; 	iftrue PawpawCheckBattleScript
; 	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
; 	iftrue PawpawGiveOddSouvenirScript
; 	checkevent EVENT_ELM_WANTS_TO_BATTLE
; 	iftrue PawpawAskBattleScript
; 	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
; 	iffalsefwd PawpawCheckTogepiEgg
; 	scall PawpawEggHatchedScript
; 	jumpopenedtext PawpawThoughtEggHatchedText

; PawpawEggHatchedScript:
; 	setmonval TOGEPI
; 	special Special_FindThatSpeciesYourTrainerID
; 	iftrue ShowPawpawTogepiScript
; 	setmonval TOGETIC
; 	special Special_FindThatSpeciesYourTrainerID
; 	iftrue ShowPawpawTogepiScript
; 	setmonval TOGEKISS
; 	special Special_FindThatSpeciesYourTrainerID
; 	iftrue ShowPawpawTogepiScript
; 	sjumpfwd PawpawCheckGotEggAgain

; PawpawCheckTogepiEgg:
; 	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
; 	iffalsefwd PawpawCheckGotEggAgain
; 	checkevent EVENT_TOGEPI_HATCHED
; 	iftrue PawpawEggHatchedScript
; PawpawCheckGotEggAgain:
; 	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
; 	iftrue_jumpopenedtext PawpawWaitingEggHatchText
; 	checkflag ENGINE_ZEPHYRBADGE
; 	iftrue_jumpopenedtext PawpawAssistantHasEggText
; 	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
; 	iftrue_jumpopenedtext PawpawStudyingEggText
; 	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
; 	iftrue PawpawAfterTheftScript
; 	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
; 	iftrue_jumpopenedtext PawpawDescribesMrPokemonText
; 	jumpopenedtext PawpawText_LetYourMonBattleIt

FieldLabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	showtext PawpawWhereGoingText
	applyonemovement PLAYER, step_up
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext PawpawPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
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
	givepoke CYNDAQUIL, PLAIN_FORM, 5, ORAN_BERRY
	; writetext RivalChoosesStarterText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalPicksChikoritaMovement
	; pause 15
	; disappear ELMSLAB_POKE_BALL3
	; opentext
	; getmonname CHIKORITA, STRING_BUFFER_3
	; writetext RivalReceivedStarterText
	; playsound SFX_CAUGHT_MON
	; waitsfx
	; promptbutton
	; writetext RivalNicknamedChikoritaText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalAfterChikoritaMovement
	; readvar VAR_FACING
	; ifequalfwd RIGHT, PawpawDirectionsScript
	; applymovement PLAYER, AfterCyndaquilMovement
	sjumpfwd PawpawDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext PawpawPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
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
	givepoke TOTODILE, PLAIN_FORM, 5, ORAN_BERRY
	; writetext RivalChoosesStarterText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalPicksCyndaquilMovement
	; pause 15
	; disappear ELMSLAB_POKE_BALL1
	; opentext
	; getmonname CYNDAQUIL, STRING_BUFFER_3
	; writetext RivalReceivedStarterText
	; playsound SFX_CAUGHT_MON
	; waitsfx
	; promptbutton
	; writetext RivalNicknamedCyndaquilText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalAfterCyndaquilMovement
	; applymovement PLAYER, AfterTotodileMovement
	sjumpfwd PawpawDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext PawpawPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
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
	givepoke CHIKORITA, PLAIN_FORM, 5, ORAN_BERRY
	; writetext RivalChoosesStarterText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalPicksTotodileMovement
	; pause 15
	; disappear ELMSLAB_POKE_BALL2
	; opentext
	; getmonname TOTODILE, STRING_BUFFER_3
	; writetext RivalReceivedStarterText
	; playsound SFX_CAUGHT_MON
	; waitsfx
	; promptbutton
	; writetext RivalNicknamedTotodileText
	; waitbutton
	; closetext
	; applymovement ELMSLAB_LYRA, RivalAfterTotodileMovement
	; applymovement PLAYER, AfterChikoritaMovement
	sjumpfwd PawpawDirectionsScript
	; fallthrough

PawpawDirectionsScript:
	turnobject PLAYER, LEFT
if !DEF(DEBUG)
	showtext PawpawDirectionsText1
endc
	addcellnum PHONE_ELM
	opentext
	writetext GotFieldNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	showtext PawpawDirectionsText2
	turnobject ELMSLAB_ELM, DOWN
	showtext PawpawDirectionsText3
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	; setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene $6
	end

FieldLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftruefwd .CanHeal
	jumpopenedtext FieldLabHealingMachineText1

.CanHeal:
	writetext FieldLabHealingMachineText2
	yesorno
	iftruefwd FieldLabHealingMachine_HealParty
	endtext

FieldLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval 1 ; Machine is in Pawpaw's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	endtext


; PawpawAfterTheftDoneScript:
; 	waitendtext

; PawpawAfterTheftScript:
; 	writetext PawpawAfterTheftText1
; 	checkkeyitem MYSTERY_EGG
; 	iffalse PawpawAfterTheftDoneScript
; 	promptbutton
; 	writetext PawpawAfterTheftText2
; 	waitbutton
; 	takekeyitem MYSTERY_EGG
; 	scall PawpawJumpBackScript1
; 	writetext PawpawAfterTheftText3
; 	waitbutton
; 	scall PawpawJumpBackScript2
; 	writetext PawpawAfterTheftText4
; 	promptbutton
; 	writetext PawpawAfterTheftText5
; 	promptbutton
; 	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
; 	clearevent EVENT_LYRA_ROUTE_29
; 	setmapscene ROUTE_29, $1
; 	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
; 	setevent EVENT_ROUTE_30_BATTLE
; 	setscene $2
; 	jumpopenedtext PawpawAfterTheftText6

; ShowPawpawTogepiScript:
; 	writetext ShowPawpawTogepiText1
; 	waitbutton
; 	closetext
; 	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
; 	setevent EVENT_SHOWED_TOGEPI_TO_ELM
; 	opentext
; 	writetext ShowPawpawTogepiText2
; 	promptbutton
; 	writetext ShowPawpawTogepiText3
; 	promptbutton
; PawpawGiveOddSouvenirScript:
; 	writetext PawpawGiveOddSouvenirText1
; 	promptbutton
; 	verbosegiveitem ODD_SOUVENIR
; 	iffalse_endtext
; 	setevent EVENT_GOT_ODD_SOUVENIR_FROM_ELM
; 	writetext PawpawGiveOddSouvenirText2
; 	waitbutton
; 	checkevent EVENT_BATTLED_PROF_ELM
; 	iffalsefwd PawpawAlsoBattleScript
; 	endtext

; PawpawGiveMasterBallScript:
; 	writetext PawpawGiveMasterBallText1
; 	promptbutton
; 	verbosegiveitem MASTER_BALL
; 	iffalse_endtext
; 	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
; 	writetext PawpawGiveMasterBallText2
; 	waitbutton
; 	checkevent EVENT_BATTLED_PROF_ELM
; 	iftrue_endtext
; PawpawAlsoBattleScript:
; 	writetext PawpawByTheWayText
; 	waitbutton
; 	sjumpfwd PawpawAskBattleScript

; PawpawCheckBattleScript:
; 	checkevent EVENT_BATTLED_PROF_ELM
; 	iftrue_jumpopenedtext PawpawText_CallYou
; 	checkevent EVENT_BEAT_FALKNER
; 	iffalse_jumpopenedtext PawpawText_CallYou
; 	writetext PawpawBeforeBattleText
; 	waitbutton
; PawpawAskBattleScript:
; 	setevent EVENT_ELM_WANTS_TO_BATTLE
; 	writetext PawpawAskBattleText
; 	yesorno
; 	iffalse_jumpopenedtext PawpawRefusedBattleText
; 	writetext PawpawSeenText
; 	waitbutton
; 	closetext
; 	winlosstext PawpawWinText, PawpawLoseText
; 	setlasttalked ELMSLAB_ELM
; 	readvar VAR_BADGES
; 	ifless 2, .Team1
; 	ifless 4, .Team2
; 	ifless 8, .Team3
; 	loadtrainer PROF_ELM, 4
; 	sjumpfwd .GotTeam
; .Team1:
; 	loadtrainer PROF_ELM, 1
; 	sjumpfwd .GotTeam
; .Team2:
; 	loadtrainer PROF_ELM, 2
; 	sjumpfwd .GotTeam
; .Team3:
; 	loadtrainer PROF_ELM, 3
; .GotTeam:
; 	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
; 	clearevent EVENT_ELM_WANTS_TO_BATTLE
; 	setevent EVENT_BATTLED_PROF_ELM
; 	startbattle
; 	reloadmap
; 	special HealParty
; 	jumptextfaceplayer PawpawAfterBattleText

; PawpawGiveTicketScript:
; 	writetext PawpawGiveTicketText1
; 	promptbutton
; 	verbosegivekeyitem S_S_TICKET
; 	writetext PawpawGiveTicketText2
; 	waitbutton
; 	closetext
; 	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
; 	special Special_FadeOutMusic
; 	pause 10
; 	readvar VAR_FACING
; 	ifequalfwd UP, .Shortest
; 	ifequalfwd DOWN, .Longest
; 	disappear ELMSLAB_LYRA
; 	moveobject ELMSLAB_LYRA, 4, 7
; 	scall .RivalEntryShort
; 	scall .RivalAnnouncesGymChallenge
; 	turnobject PLAYER, RIGHT
; 	sjumpfwd .Continue

; .Longest
; 	disappear ELMSLAB_LYRA
; 	moveobject ELMSLAB_LYRA, 4, 6
; 	appear ELMSLAB_LYRA
; 	applymovement ELMSLAB_LYRA, RivalRunsInMoreMovement
; 	turnobject ELMSLAB_ELM, UP
; 	turnobject ELMSLAB_LYRA, RIGHT
; 	turnobject PLAYER, LEFT
; 	scall .RivalAnnouncesGymChallenge
; 	turnobject PLAYER, DOWN
; 	sjumpfwd .Continue

; .Shortest
; 	disappear ELMSLAB_LYRA
; 	moveobject ELMSLAB_LYRA, 5, 8
; 	scall .RivalEntryShort
; 	scall .RivalAnnouncesGymChallenge
; 	turnobject PLAYER, UP

; .Continue
; 	faceplayer
; 	playmusic MUSIC_PROF_ELM
; 	showtext PawpawAfterTicketText
; 	setevent EVENT_LYRA_IN_HER_ROOM
; 	setevent EVENT_GOT_SS_TICKET_FROM_ELM
; 	end

; .RivalAnnouncesGymChallenge
; 	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
; 	showtext RivalAnnouncesGymChallengeText
; 	applymovement ELMSLAB_LYRA, RivalLeavesMovement
; 	disappear ELMSLAB_LYRA
; 	pause 10
; 	end

; .RivalEntryShort
; 	appear ELMSLAB_LYRA
; 	applymovement ELMSLAB_LYRA, RivalRunsInMovement
; 	turnobject ELMSLAB_ELM, DOWN
; 	turnobject ELMSLAB_LYRA, UP
; 	turnobject PLAYER, DOWN
; 	end

; PawpawJumpBackScript1:
; 	closetext
; 	readvar VAR_FACING
; 	ifequalfwd DOWN, PawpawJumpDownScript
; 	ifequalfwd UP, PawpawJumpUpScript
; 	ifequalfwd LEFT, PawpawJumpLeftScript
; 	ifequalfwd RIGHT, PawpawJumpRightScript
; 	end

; PawpawJumpBackScript2:
; 	closetext
; 	readvar VAR_FACING
; 	ifequalfwd DOWN, PawpawJumpUpScript
; 	ifequalfwd UP, PawpawJumpDownScript
; 	ifequalfwd LEFT, PawpawJumpRightScript
; 	ifequalfwd RIGHT, PawpawJumpLeftScript
; 	end

; PawpawJumpUpScript:
; 	applymovement ELMSLAB_ELM, PawpawJumpUpMovement
; 	opentext
; 	end

; PawpawJumpDownScript:
; 	applymovement ELMSLAB_ELM, PawpawJumpDownMovement
; 	opentext
; 	end

; PawpawJumpLeftScript:
; 	applymovement ELMSLAB_ELM, PawpawJumpLeftMovement
; 	opentext
; 	end

; PawpawJumpRightScript:
; 	applymovement ELMSLAB_ELM, PawpawJumpRightMovement
; 	opentext
; 	end

; RivalBattleScript:
; 	turnobject ELMSLAB_LYRA, DOWN
; 	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
; 	showtext FieldLabRivalChallengeText
; 	applymovement ELMSLAB_LYRA, RivalBattleMovement
; 	turnobject PLAYER, RIGHT
; 	winlosstext FieldLabRivalWinText, FieldLabRivalLossText
; 	setlasttalked ELMSLAB_LYRA
; 	checkevent EVENT_GOT_TOTODILE_FROM_ELM
; 	iftruefwd .Totodile
; 	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
; 	iftruefwd .Chikorita
; 	loadtrainer LYRA1, LYRA1_1
; 	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
; 	startbattle
; 	dontrestartmapmusic
; 	reloadmap
; 	special DeleteSavedMusic
; 	playmusic MUSIC_LYRA_DEPARTURE_HGSS
; 	iftruefwd .AfterYourDefeat
; 	sjumpfwd .AfterVictorious

; .Totodile:
; 	loadtrainer LYRA1, LYRA1_2
; 	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
; 	startbattle
; 	dontrestartmapmusic
; 	reloadmap
; 	special DeleteSavedMusic
; 	playmusic MUSIC_LYRA_DEPARTURE_HGSS
; 	iftruefwd .AfterVictorious
; 	sjumpfwd .AfterYourDefeat

; .Chikorita:
; 	loadtrainer LYRA1, LYRA1_3
; 	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
; 	startbattle
; 	dontrestartmapmusic
; 	reloadmap
; 	special DeleteSavedMusic
; 	playmusic MUSIC_LYRA_DEPARTURE_HGSS
; 	iftruefwd .AfterVictorious
; 	sjumpfwd .AfterYourDefeat

; .AfterVictorious:
; 	showtext FieldLabRivalText_YouWon
; 	sjumpfwd .FinishRival

; .AfterYourDefeat:
; 	showtext FieldLabRivalText_YouLost
; .FinishRival:
; 	turnobject ELMSLAB_LYRA, UP
; 	opentext
; 	writetext FieldLabRivalThankYouText
; 	waitbutton
; 	turnobject ELMSLAB_LYRA, LEFT
; 	writetext FieldLabRivalSeeYouText
; 	waitbutton
; 	closetext
; 	turnobject PLAYER, DOWN
; 	applymovement ELMSLAB_LYRA, RivalLeavesMovement
; 	disappear ELMSLAB_LYRA
; 	special HealParty
; 	setscene $5
; 	playmapmusic
; 	end

; AssistantScript_WalkPotions1:
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksRight1
; 	turnobject PLAYER, DOWN
; 	scall AssistantScript_GivePotions
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksLeft1
; 	end

; AssistantScript_WalkPotions2:
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksRight2
; 	turnobject PLAYER, DOWN
; 	scall AssistantScript_GivePotions
; 	applymovement ELMSLAB_ELMS_AIDE, AssistantWalksLeft2
; 	end

; AssistantScript_GivePotions:
; 	opentext
; 	writetext AssistantText_GiveYouPotions
; 	promptbutton
; 	verbosegiveitem POTION
; 	setscene $2
; 	jumpopenedtext AssistantText_AlwaysBusy

; FieldAssistantScript:
; 	checkevent EVENT_GOT_RIVALS_EGG
; 	iftrue_jumptextfaceplayer AssistantText_AlwaysBusy
; 	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
; 	iftrue_jumptextfaceplayer AssistantText_AfterTheft
; 	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
; 	iftrue_jumptextfaceplayer AssistantText_AlwaysBusy
; 	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
; 	iftrue_jumptextfaceplayer AssistantText_TheftTestimony
; 	jumptextfaceplayer AssistantText_AlwaysBusy

; FieldLabRivalScript:
; 	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
; 	iffalse_jumptextfaceplayer FieldLabRivalWhichPokemonText
; 	jumptextfaceplayer FieldLabRivalGoodChoiceText


FieldLabPC:
	jumptext FieldLabPCText

FieldLabWindow:
	jumptext FieldLabWindowText

FieldLab_WalkUpToPawpawMovement:
	step_up
	step_up
	step_left
	step_left
	step_up
	step_up
	step_up
	turn_head_left
	step_end

; RivalPicksChikoritaMovement:
; 	step_right
; RivalPicksTotodileMovement:
; 	step_right
; RivalPicksCyndaquilMovement:
; 	step_right
; 	step_right
; 	step_up
; 	step_end

; RivalAfterChikoritaMovement:
; 	step_down
; 	step_left
; 	step_left
; 	step_left
; 	turn_head_up
; 	step_end

; RivalAfterTotodileMovement:
; 	step_down
; 	step_left
; 	step_left
; 	turn_head_up
; 	step_end

; RivalAfterCyndaquilMovement:
; 	step_down
; 	step_left
; 	turn_head_up
; 	step_end

; RivalBattleMovement:
; 	step_down
; 	turn_head_left
; 	step_end

; RivalLeavesMovement:
; 	step_down
; 	step_down
; 	step_down
; 	step_down
; 	step_down
; 	step_end

; RivalRunsInMoreMovement:
; 	step_up
; RivalRunsInMovement:
; 	step_up
; 	step_up
; 	step_up
; 	step_up
; 	step_end

; RivalStepsAsideMovement:
; 	step_left
; 	turn_head_right
; 	step_end

; OfficerLeavesMovement:
; 	step_down
; 	step_down
; 	step_down
; 	step_down
; 	step_down
; 	step_end

; AssistantWalksRight1:
; 	step_right
; 	step_right
; 	turn_head_up
; 	step_end

; AssistantWalksRight2:
; 	step_right
; 	step_right
; 	step_right
; 	turn_head_up
; 	step_end

; AssistantWalksLeft1:
; 	step_left
; 	step_left
; 	turn_head_down
; 	step_end

; AssistantWalksLeft2:
; 	step_left
; 	step_left
; 	step_left
; 	turn_head_down
; 	step_end

; AssistantWalksDownMovement:
; 	step_right
; 	step_right
; 	step_down
; 	step_end

; AssistantWalksBackMovement:
; 	step_up
; 	step_left
; 	step_left
; 	step_end

PawpawJumpUpMovement:
	fix_facing
	run_step_up
	remove_fixed_facing
	step_end

PawpawJumpDownMovement:
	fix_facing
	run_step_down
	remove_fixed_facing
	step_end

PawpawJumpLeftMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	step_end

PawpawJumpRightMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	step_end

FieldLab_PawpawToDefaultPositionMovement:
	step_up
	step_right
	step_right
	turn_head_down
	step_end

AfterCyndaquilMovement:
	step_down
	step_left
	turn_head_up
	step_end

AfterTotodileMovement:
	step_down
	step_left
	turn_head_up
	step_end

AfterChikoritaMovement:
	step_down
	step_left
	step_left
	turn_head_up
	step_end

PawpawText_Intro:
	text "Pawpaw: Hi <PLAYER>!"
	line "I'm Prof.Pawpaw!"

	para "I'd like to ask"
	line "a favor of you."

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

	para "I'd like you"
	line "to raise #mon"

	para "that I recently"
	line "caught."
	done

PawpawText_Accepted:
	text "Thanks, <PLAYER>!"

	para "You're a great"
	line "help!"
	done

PawpawText_Refused:
	text "But… Please, I"
	line "need your help!"
	done

PawpawText_ResearchAmbitions:
	text "When I announce my"
	line "findings, I'm sure"

	para "we'll delve a bit"
	line "deeper into the"

	para "many mysteries of"
	line "#mon."

	para "You can count on"
	line "it!"
	done

PawpawText_GotAnEmail:
	text "Oh, hey! I got an"
	line "e-mail!"

	para "………………"
	line "Hm… Uh-huh…"

	para "OK…"
	done

PawpawText_MissionFromMrPokemon:
	text "Hey, listen."

	para "I have a coll-"
	line "eague named "
	cont "Prof. Poplar."

	para "She says she's"
	line "got something"

	para "urgent for me"
	line "that can't be"
	cont "sent via email."

	para "We've just"
	line "set up the"

	para "Field Lab and"
	line "I can't afford"
	cont "to leave yet."

	para "It's prolly"
	line "nothin' but"

	para "she's never"
	line "been wrong"
	cont "before..."

	para "Now <PLAYER>, I"
	line "reckon we just"

	para "met and all, but"
	line "would you go"

	para "for me and see"
	line "what Prof.Poplar"
	cont "wants?"
	done

PawpawText_ChooseAPokemon:
	text "HOOHOO!"
	para "I want you to"
	line "raise one of the"

	para "#mon contained"
	line "in these Balls."

	para "You'll be that"
	line "#mon's first"
	cont "partner, <PLAYER>!"

	para "Go on. Pick one!"
	done

PawpawText_LetYourMonBattleIt:
	text "If a wild #mon"
	line "appears, let your"
	cont "#mon battle it!"
	done

PawpawWhereGoingText:
	text "Pawpaw: Wait! Where"
	line "are you going?"
	done

TakeCyndaquilText:
	text "Pawpaw: So it's"
	line "Fliklit, the"
	cont "fire #mon?"
	done

TakeTotodileText:
	text "Pawpaw: You want"
	line "Gluttle, the"
	cont "water #mon?"
	done

TakeChikoritaText:
	text "Pawpaw: You like"
	line "Cupico, the"
	cont "grass #mon?"
	done

DidntChooseStarterText:
	text "Pawpaw: Think it"
	line "over carefully."

	para "Your first partner"
	line "is important."
	done

ChoseStarterText:
	text "Pawpaw: I think"
	line "that's a great"
	cont "#mon too!"
	done

PawpawDirectionsText1:
	text "Poplar is at"
	line "the Academy near"

	para "Olsteeton, the"
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

PawpawDirectionsText2:
	text "If your #mon is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "Feel free to use"
	line "it anytime."
	done

PawpawDirectionsText3:
	text "<PLAYER>, I'm"
	line "countin' on ya!"
	done

FieldLabAssistantText:
	text "I'm a recent"
	line "academy grad."

	para "I was lucky"
	line "to get this"

	para "fellowship under"
	line "Prof. Pawpaw."
	done
GotFieldNumberText:
	text "<PLAYER> got Pawpaw's"
	line "phone number."
	done

PawpawDescribesMrPokemonText:
	text "Prof. Poplar"
	line "studies object-"
	cont "like #mon."

	para "She was a part"
	line "of the team"

	para "that discovered"
	line "the #mon,"
	cont "Trubbish, in the"
	cont "Unova Region."
	done

PawpawPokeBallText:
	text "It contains a"
	line "#mon caught by"
	cont "Prof.Pawpaw."
	done

FieldLabHealingMachineText1:
	text "I wonder what this"
	line "does?"
	done

FieldLabHealingMachineText2:
	text "Would you like to"
	line "heal your #mon?"
	done

PawpawText_CallYou:
	text "Pawpaw: <PLAYER>, I'll"
	line "call you if any-"
	cont "thing comes up."
	done

FieldLabTravelTip1Text:
	text "Travel Tip 1:"

	para "Press Start to"
	line "open the Menu."
	done

FieldLabTravelTip2Text:
	text "Travel Tip 2:"

	para "Record your trip"
	line "with Save!"
	done

FieldLabTravelTip3Text:
	text "Travel Tip 3:"

	para "Open your Bag and"
	line "press Select to"
	cont "move items."
	done

FieldLabTravelTip4Text:
	text "Travel Tip 4:"

	para "Check your #mon"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

FieldLabTrashcanText:
	text "The wrapper from"
	line "the snack Prof.Pawpaw"
	cont "ate is in there…"
	done

FieldLabPCText:
	text "The screen says"
	line "Indicator #mon"

	para "Does the presence"
	line "of certain #mon"

	para "correlate with"
	line "biome health?"
	done

FieldLabWindowText:
	text "Light streams"
	line "in through the"

	para "recently in-"
	line "stalled window."
	done

; PawpawGiveMasterBallText1:
; 	text "Pawpaw: Hi, <PLAYER>!"
; 	line "Thanks to you, my"

; 	para "research is going"
; 	line "great!"

; 	para "Take this as a"
; 	line "token of my"
; 	cont "appreciation."
; 	done

; PawpawGiveMasterBallText2:
; 	text "The Master Ball is"
; 	line "the best!"

; 	para "It's the ultimate"
; 	line "Ball! It'll catch"

; 	para "any #mon with-"
; 	line "out fail."

; 	para "It's given only to"
; 	line "recognized #mon"
; 	cont "researchers."

; 	para "I think you can"
; 	line "make much better"

; 	para "use of it than I"
; 	line "can, <PLAYER>!"
; 	done

; RivalAnnouncesGymChallengeText:
; 	text "Rival: There you"
; 	line "are, <PLAYER>!"

; 	para "I saw your battle"
; 	line "with the Champion"
; 	cont "on TV."

; 	para "You were incred-"
; 	line "ible!"

; 	para "It really inspired"
; 	line "me, <PLAYER>."

; 	para "Even if I can't"
; 	line "reach that level…"
; 	cont "I want to try."

; 	para "I want to see what"
; 	line "I'm capable of."

; 	para "Prof.Pawpaw, I'm"
; 	line "sorry I can't keep"
; 	cont "helping out here."

; 	para "I'm going to"
; 	line "challenge all the"

; 	para "Gyms in Johto and"
; 	line "make it to the"
; 	cont "#mon League!"

; 	para "Wish me luck!"
; 	line "See you later!"
; 	done

; PawpawBeforeBattleText:
; 	text "Pawpaw: <PLAYER>!"
; 	line "How is your #-"
; 	cont "journey so far?"
; 	done

; PawpawByTheWayText:
; 	text "While you're here,"
; 	line "<PLAYER>…"
; 	done

; PawpawAskBattleText:
; 	text "I could use some"
; 	line "practice battling"

; 	para "a talented trainer"
; 	line "like yourself."

; 	para "How about it,"
; 	line "<PLAYER>?"
; 	done

; PawpawSeenText:
; 	text "Show me how much"
; 	line "you've grown since"

; 	para "you left New Bark"
; 	line "Town!"
; 	done

; PawpawWinText:
; 	text "Astounding!"
; 	done

; PawpawLoseText:
; 	text "Were you going"
; 	line "easy on me?"
; 	done

; PawpawRefusedBattleText:
; 	text "If your #mon"
; 	line "need healing,"

; 	para "just use the"
; 	line "machine here."
; 	done

; PawpawAfterBattleText:
; 	text "Pawpaw: I'm proud"
; 	line "of you, <PLAYER>."

; 	para "I was right to"
; 	line "trust you with"
; 	cont "a #mon!"
; 	done

; AssistantText_GiveYouPotions:
; 	text "<PLAYER>, I want"
; 	line "you to have this"
; 	cont "for your errand."
; 	done

; AssistantText_AlwaysBusy:
; 	text "There are only two"
; 	line "of us, so we're"
; 	cont "always busy."
; 	done

; FieldLabRivalWhichPokemonText:
; 	text "Which #mon are"
; 	line "you going to pick,"
; 	cont "<PLAYER>?"
; 	done

; RivalChoosesStarterText:
; 	text "Rival: Then I'll"
; 	line "pick this one!"
; 	done

; RivalReceivedStarterText:
; 	text "Rival received"
; 	line ""
; 	text_ram wStringBuffer3
; 	text "!"
; 	done

; RivalNicknamedChikoritaText:
; 	text "Rival: It's so"
; 	line "cute! I'll nick-"
; 	cont "name it Chicory!"
; 	done

; RivalNicknamedCyndaquilText:
; 	text "Rival: It's so"
; 	line "cute! I'll nick-"
; 	cont "name it Cinder!"
; 	done

; RivalNicknamedTotodileText:
; 	text "Rival: It's so"
; 	line "cute! I'll nick-"
; 	cont "name it Toto!"
; 	done

; FieldLabRivalGoodChoiceText:
; 	text "Your #mon"
; 	line "looks cute too!"
; 	done

; FieldLabRivalChallengeText:
; 	text "Rival: <PLAYER>!"
; 	line "Let's get to know"

; 	para "our #mon with"
; 	line "a battle!"
; 	done

; FieldLabRivalWinText:
; 	text "Good job,"
; 	line "<PLAYER>!"
; 	done

; FieldLabRivalLossText:
; 	text "Yay! I won!"
; 	done

; FieldLabRivalText_YouWon:
; FieldLabRivalText_YouLost:
; 	text "That was an"
; 	line "exciting battle!"
; 	done

; FieldLabRivalThankYouText:
; 	text "Thank you for the"
; 	line "#mon, Prof."
; 	cont "Pawpaw."
; 	done

; FieldLabRivalSeeYouText:
; 	text "<PLAYER>, I'll"
; 	line "see you later!"

; 	para "Have fun on your"
; 	line "errand!"
; 	done

; FieldLabRivalTheftInnocentText:
; 	text "Rival: Hold on!"
; 	line "<PLAYER> has noth-"
; 	cont "ing to do with it!"

; 	para "I saw a red-haired"
; 	line "boy spying on the"
; 	cont "building!"
; 	done

; FieldLabRivalTheftGoodbyeText:
; 	text "Rival: <PLAYER>,"
; 	line "I'm glad he under-"

; 	para "stood that you're"
; 	line "innocent."

; 	para "I hope he makes"
; 	line "the thief return"
; 	cont "that #mon…"

; 	para "Well then, see"
; 	line "you later!"
; 	done

; if !DEF(DEBUG)
; 	para "Prof.Oak gave you"
; 	line "a #dex?"

; 	para "<PLAYER>, is that"
; 	line "true? Th-that's"
; 	cont "incredible!"

; 	para "He is superb at"
; 	line "seeing the poten-"
; 	cont "tial of people as"
; 	cont "trainers."

; 	para "Wow, <PLAYER>. You"
; 	line "may have what it"

; 	para "takes to become"
; 	line "the Champion."

; 	para "You seem to be"
; 	line "getting on great"
; 	cont "with #mon too."

; 	para "You should take"
; 	line "the #mon Gym"
; 	cont "challenge."

; 	para "The closest Gym"
; 	line "would be the one"
; 	cont "in Violet City."
; endc
; 	done

; PawpawAfterTheftText6:
; 	text "…<PLAYER>. The"
; 	line "road to the"

; 	para "championship will"
; 	line "be a long one."

; 	para "Before you leave,"
; 	line "make sure that you"
; 	cont "talk to your mom."

; 	para "And give me a call"
; 	line "sometimes too."

; 	para "I can tell you all"
; 	line "about my research"

; 	para "on how #mon"
; 	line "evolve!"
; 	done


; PawpawWaitingEggHatchText:
; 	text "Pawpaw: Hey, has that"
; 	line "Egg changed any?"
; 	done

; PawpawThoughtEggHatchedText:
; 	text "<PLAYER>? I thought"
; 	line "the Egg hatched."

; 	para "Where is the"
; 	line "#mon?"
; 	done

; ShowPawpawTogepiText1:
; 	text "Pawpaw: <PLAYER>, you"
; 	line "look great!"
; 	done

; ShowPawpawTogepiText2:
; 	text "What?"
; 	line "That #mon?!"
; 	done

; ShowPawpawTogepiText3:
; 	text "The Egg hatched!"
; 	line "So, #mon are"
; 	cont "born from Eggs…"

; 	para "No, perhaps not"
; 	line "all #mon are."

; 	para "Wow, there's still"
; 	line "a lot of research"
; 	cont "to be done."
; 	done