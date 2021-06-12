Route36NationalParkGate_MapScriptHeader:
	def_scene_scripts
	scene_script Route36NationalParkGateTrigger0
	scene_script Route36NationalParkGateTrigger1
	scene_script Route36NationalParkGateTrigger2

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route36NationalParkGateCheckIfContestRunning
	callback MAPCALLBACK_OBJECTS, Route36NationalParkGateCheckIfContestAvailable

	def_warp_events
	warp_event  0,  4, NATIONAL_PARK, 1
	warp_event  0,  5, NATIONAL_PARK, 2
	warp_event  9,  4, ROUTE_36, 1
	warp_event  9,  5, ROUTE_36, 2

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_JUMPTEXT, BugCatchingContestExplanationText

	def_object_events
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36OfficerScriptContest, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  2,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1BScript, EVENT_BUG_CATCHING_CONTESTANT_1B
	object_event  4,  5, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2BScript, EVENT_BUG_CATCHING_CONTESTANT_2B
	object_event  2,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3BScript, EVENT_BUG_CATCHING_CONTESTANT_3B
	object_event  6,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4BScript, EVENT_BUG_CATCHING_CONTESTANT_4B
	object_event  2,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5BScript, EVENT_BUG_CATCHING_CONTESTANT_5B
	object_event  5,  6, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6BScript, EVENT_BUG_CATCHING_CONTESTANT_6B
	object_event  3,  6, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7BScript, EVENT_BUG_CATCHING_CONTESTANT_7B
	object_event  4,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8BScript, EVENT_BUG_CATCHING_CONTESTANT_8B
	object_event  6,  7, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9BScript, EVENT_BUG_CATCHING_CONTESTANT_9B
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10BScript, EVENT_BUG_CATCHING_CONTESTANT_10B
	object_event  3,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36NationalParkGateOfficerScript, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY

	object_const_def
	const ROUTE36NATIONALPARKGATE_OFFICER1
	const ROUTE36NATIONALPARKGATE_BUG_CATCHER1
	const ROUTE36NATIONALPARKGATE_BUG_MANIAC
	const ROUTE36NATIONALPARKGATE_COOLTRAINER_M
	const ROUTE36NATIONALPARKGATE_POKEFAN_M
	const ROUTE36NATIONALPARKGATE_BUG_CATCHER2
	const ROUTE36NATIONALPARKGATE_YOUNGSTER1
	const ROUTE36NATIONALPARKGATE_LASS
	const ROUTE36NATIONALPARKGATE_BUG_CATCHER3
	const ROUTE36NATIONALPARKGATE_YOUNGSTER2
	const ROUTE36NATIONALPARKGATE_YOUNGSTER3
	const ROUTE36NATIONALPARKGATE_OFFICER2

Route36NationalParkGateTrigger2:
	sdefer Route36NationalParkGateLeftTheContestEarly
Route36NationalParkGateTrigger0:
Route36NationalParkGateTrigger1:
	end

Route36NationalParkGateCheckIfContestRunning:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	setscene $0
	endcallback

.BugContestIsRunning:
	setscene $2
	endcallback

Route36NationalParkGateCheckIfContestAvailable:
	checkevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	iftrue .Return
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .SetContestOfficer
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE36NATIONALPARKGATE_OFFICER1
	disappear ROUTE36NATIONALPARKGATE_OFFICER2
.Return:
	endcallback

Route36NationalParkGateLeftTheContestEarly:
	turnobject PLAYER, UP
	opentext
	readvar VAR_CONTESTMINUTES
	addval $1
	getnum $0
	writetext Route35NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writetext Route36NationalParkGateOfficer1WaitHereForAnnouncementText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	scall .CopyContestants
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	applymovement PLAYER, Route36NationalParkGatePlayerWaitWithContestantsMovement
	pause 15
	special Special_FadeInQuickly
	jumpstd bugcontestresults

.GoBackToContest:
	writetext Route35NationalParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 35, 18
	end

.CopyContestants:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .Not1
	appear ROUTE36NATIONALPARKGATE_BUG_CATCHER1
.Not1:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .Not2
	appear ROUTE36NATIONALPARKGATE_BUG_MANIAC
.Not2:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .Not3
	appear ROUTE36NATIONALPARKGATE_COOLTRAINER_M
.Not3:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .Not4
	appear ROUTE36NATIONALPARKGATE_POKEFAN_M
.Not4:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .Not5
	appear ROUTE36NATIONALPARKGATE_BUG_CATCHER2
.Not5:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .Not6
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER1
.Not6:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .Not7
	appear ROUTE36NATIONALPARKGATE_LASS
.Not7:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .Not8
	appear ROUTE36NATIONALPARKGATE_BUG_CATCHER3
.Not8:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .Not9
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER2
.Not9:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .Not10
	appear ROUTE36NATIONALPARKGATE_YOUNGSTER3
.Not10:
	special UpdateSprites
	end

Route36OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .ContestNotOn
	ifequal MONDAY, .ContestNotOn
	ifequal WEDNESDAY, .ContestNotOn
	ifequal FRIDAY, .ContestNotOn
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	faceplayer
	opentext
	callstd daytotext
	writetext Route35NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse_jumpopenedtext Route35NationalParkGateOfficer1TakePartInFutureText
	readvar VAR_PARTYCOUNT
	ifgreater $1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext Route35NationalParkGateOfficer1GiveParkBallsText
	promptbutton
	waitsfx
	writetext Route35NationalParkGatePlayerReceivedParkBallsText
	playsound SFX_ITEM
	waitsfx
	writetext Route35NationalParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	setflag ENGINE_BUG_CONTEST_TIMER
	special Special_GiveParkBalls
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special Special_SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 35, 18
	end

.ContestNotOn:
	jumptextfaceplayer Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText

.LeaveMonsWithOfficer:
	readvar VAR_PARTYCOUNT
	ifless $6, .ContinueLeavingMons
	readvar VAR_BOXSPACE
	iffalse_jumpopenedtext Route35NationalParkGateOfficer1MakeRoomText
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	iftrue_jumpopenedtext Route35NationalParkGateOfficer1EggAsFirstMonText
	writetext Route35NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse_jumpopenedtext Route35NationalParkGateOfficer1ChooseMonAndComeBackText
	special ContestDropOffMons
	iftrue_jumpopenedtext Route35NationalParkGateOfficer1FirstMonCantBattleText
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext Route35NationalParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext Route35NationalParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump .ResumeStartingContest

Route36Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	iffalse_jumptextfaceplayer Route35NationalParkGateOfficer1ContestIsOverText
	faceplayer
	opentext
	writetext Route36NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	readmem wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iffalse_jumpopenedtext Route36NationalParkGateOfficer1WellHoldPrizeText
	clearevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	endtext

Route36NationalParkGateOfficerScript:
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	jumptextfaceplayer Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText

BugCatchingContestant1BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant1BStillCompetingText
	jumptextfaceplayer BugCatchingContestant1BText

BugCatchingContestant2BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant2BStillCompetingText
	jumptextfaceplayer BugCatchingContestant2BText

BugCatchingContestant3BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant3BStillCompetingText
	jumptextfaceplayer BugCatchingContestant3BText

BugCatchingContestant4BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant4BStillCompetingText
	jumptextfaceplayer BugCatchingContestant4BText

BugCatchingContestant5BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant5BStillCompetingText
	jumptextfaceplayer BugCatchingContestant5BText

BugCatchingContestant6BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant6BStillCompetingText
	jumptextfaceplayer BugCatchingContestant6BText

BugCatchingContestant7BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant7BStillCompetingText
	jumptextfaceplayer BugCatchingContestant7BText

BugCatchingContestant8BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant8BStillCompetingText
	jumptextfaceplayer BugCatchingContestant8BText

BugCatchingContestant9BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant9BStillCompetingText
	jumptextfaceplayer BugCatchingContestant9BText

BugCatchingContestant10BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse_jumptextfaceplayer BugCatchingContestant10BStillCompetingText
	jumptextfaceplayer BugCatchingContestant10BText

Route36NationalParkGatePlayerWaitWithContestantsMovement:
	run_step_down
	run_step_right
	turn_head_up
	step_end

Route36NationalParkGateOfficer1WaitHereForAnnouncementText:
	text "OK. Please wait"
	line "here for the"

	para "announcement of"
	line "the winners."
	done

Route36NationalParkGateOfficer1SomeMonOnlySeenInParkText:
	text "Some #mon can"
	line "only be seen in"
	cont "the Park."
	done

BugCatchingContestant1BText:
	text "Don: Wow, you beat"
	line "me. You're pretty"
	cont "good."
	done

BugCatchingContestant1BStillCompetingText:
	text "Don: Luck plays a"
	line "big part in this."

	para "You never know"
	line "what #mon will"
	cont "appear."
	done

BugCatchingContestant2BText:
	text "Lou: I envy you."
	line "I just couldn't"
	cont "do it this time."
	done

BugCatchingContestant2BStillCompetingText:
	text "Lou: Maybe you win"
	line "with big #mon?"
	done

BugCatchingContestant3BText:
	text "Nick: Well done!"
	line "I'm going to raise"
	cont "my #mon better."
	done

BugCatchingContestant3BStillCompetingText:
	text "Nick: Maybe you"
	line "get a higher score"

	para "for a #mon of"
	line "an unusual color."
	done

BugCatchingContestant4BText:
	text "William: You're"
	line "the winner? What"
	cont "did you catch?"
	done

BugCatchingContestant4BStillCompetingText:
	text "William: Well, I'm"
	line "satisfied because"

	para "I caught a #mon"
	line "that I wanted."
	done

BugCatchingContestant5BText:
	text "Benny: Congrats!"
	line "You have earned my"
	cont "respect!"
	done

BugCatchingContestant5BStillCompetingText:
	text "Benny: I caught a"
	line "Scyther before,"
	cont "but I didn't win."
	done

BugCatchingContestant6BText:
	text "Barry: That #-"
	line "mon you caught…"
	cont "it's awesome!"
	done

BugCatchingContestant6BStillCompetingText:
	text "Barry: It's easier"
	line "to win if you get"

	para "a high-level bug"
	line "#mon."

	para "But I think they"
	line "also consider some"
	cont "other points."
	done

BugCatchingContestant7BText:
	text "Cindy: You won?"
	line "That's great!"

	para "Do you feel like"
	line "looking for bug"
	cont "#mon with me?"
	done

BugCatchingContestant7BStillCompetingText:
	text "Cindy: I really"
	line "love bug #mon!"
	done

BugCatchingContestant8BText:
	text "Josh: I… I can't"
	line "believe I lost at"
	cont "bug-catching…"
	done

BugCatchingContestant8BStillCompetingText:
	text "Josh: I heard that"
	line "somebody won with"
	cont "a Caterpie!"
	done

BugCatchingContestant9BText:
	text "Johnny: Next time,"
	line "I'm going to win."
	done

BugCatchingContestant9BStillCompetingText:
	text "Johnny: Darn."
	line "I thought I would"
	cont "score higher…"
	done

BugCatchingContestant10BText:
	text "Kipp: Could you"
	line "give me some tips?"

	para "I want to study"
	line "your style."
	done

BugCatchingContestant10BStillCompetingText:
	text "Kipp: I study a"
	line "lot, but that's"

	para "not good enough to"
	line "win."
	done

Route36NationalParkGateOfficer1WellHoldPrizeText:
	text "Uh-oh… Your Bag"
	line "is full."

	para "We'll hold on to"
	line "your prize, but"
	cont "only for today."

	para "Please make room,"
	line "then come see me."
	done

Route36NationalParkGateOfficer1HeresThePrizeText:
	text "<PLAYER>?"

	para "Here's the prize"
	line "we were holding"
	cont "for you."
	done
