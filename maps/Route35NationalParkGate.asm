Route35NationalParkGate_MapScriptHeader:
	def_scene_scripts
	scene_script Route35NationalParkGateNoopScene, SCENE_ROUTE35NATIONALPARKGATE_NOOP
	scene_script Route35NationalParkGateUnusedScene, SCENE_ROUTE35NATIONALPARKGATE_UNUSED
	scene_script Route35NationalParkGateLeaveContestEarlyScene, SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route35NationalParkGate_CheckIfStillInContest
	callback MAPCALLBACK_OBJECTS, Route35NationalParkGate_CheckIfContestDay

	def_warp_events
	warp_event 15,  0, NATIONAL_PARK, 3
	warp_event 16,  0, NATIONAL_PARK, 4
	warp_event 15,  7, ROUTE_35, 3
	warp_event 16,  7, ROUTE_35, 3
	warp_event  0,  4, ROUTE_35_COAST_NORTH, 1
	warp_event  0,  5, ROUTE_35_COAST_NORTH, 2

	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, BugCatchingContestExplanationText

	def_object_events
	object_event 14,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35OfficerScriptContest, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event 18,  5, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route35NationalParkGateYoungsterText, EVENT_ROUTE_35_NATIONAL_PARK_GATE_BUG_MANIAC
	object_event 12,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGateOfficerScript, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	object_event  5,  2, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGatePokefanFScript, -1

	object_const_def
	const ROUTE35NATIONALPARKGATE_OFFICER1
	const ROUTE35NATIONALPARKGATE_BUG_MANIAC
	const ROUTE35NATIONALPARKGATE_OFFICER2

Route35NationalParkGateLeaveContestEarlyScene:
	sdefer Route35NationalParkGate_LeavingContestEarly
Route35NationalParkGateNoopScene:
Route35NationalParkGateUnusedScene:
	end

Route35NationalParkGate_CheckIfStillInContest:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftruefwd Route35NationalParkGate_Yes
	setscene SCENE_ROUTE35NATIONALPARKGATE_NOOP
	endcallback

Route35NationalParkGate_Yes:
	setscene SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

Route35NationalParkGate_CheckIfContestDay:
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, Route35NationalParkGate_IsContestDay
	ifequalfwd THURSDAY, Route35NationalParkGate_IsContestDay
	ifequalfwd SATURDAY, Route35NationalParkGate_IsContestDay
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route35NationalParkGate_Yes
	disappear ROUTE35NATIONALPARKGATE_OFFICER1
	appear ROUTE35NATIONALPARKGATE_BUG_MANIAC
	appear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

Route35NationalParkGate_IsContestDay:
	appear ROUTE35NATIONALPARKGATE_OFFICER1
	disappear ROUTE35NATIONALPARKGATE_BUG_MANIAC
	disappear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

Route35NationalParkGate_LeavingContestEarly:
	applymovement PLAYER, Route35NationalParkGatePlayerApproachOfficer1Movement
	turnobject ROUTE35NATIONALPARKGATE_OFFICER1, RIGHT
	opentext
	readvar VAR_CONTESTMINUTES
	addval $1
	setquantity
	writetext Route35NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalsefwd Route35NationalParkGate_GoBackIn
	writetext Route35NationalParkGateOfficer1WaitAtNorthGateText
	waitbutton
	closetext
	jumpstd bugcontestresultswarp

Route35NationalParkGate_GoBackIn:
	writetext Route35NationalParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 12, 47
	end

Route35OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, Route35NationalParkGate_NoContestToday
	ifequalfwd MONDAY, Route35NationalParkGate_NoContestToday
	ifequalfwd WEDNESDAY, Route35NationalParkGate_NoContestToday
	ifequalfwd FRIDAY, Route35NationalParkGate_NoContestToday
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue_jumptextfaceplayer Route35NationalParkGateOfficer1ContestIsOverText
	faceplayer
	opentext
	callstd daytotext
	writetext Route35NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalsefwd Route35NationalParkGate_DeclinedToParticipate
	readvar VAR_PARTYCOUNT
	ifgreater $1, Route35NationalParkGate_LeaveTheRestBehind
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
Route35NationalParkGate_OkayToProceed:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext Route35NationalParkGateOfficer1GiveParkBallsText
	promptbutton
	writetext Route35NationalParkGatePlayerReceivedParkBallsText
	callasm ShowParkBallIcon
	playsound SFX_ITEM
	waitsfx
	writetext Route35NationalParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	special Special_GiveParkBalls
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	special Special_SelectRandomBugContestContestants
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 12, 47
	end

Route35NationalParkGate_EnterContest:
	readvar VAR_FACING
	ifequalfwd LEFT, Route35NationalParkGate_FacingLeft
	applymovement PLAYER, Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement
	end

Route35NationalParkGate_FacingLeft:
	applyonemovement PLAYER, step_up
	end

Route35NationalParkGate_LeaveTheRestBehind:
	readvar VAR_PARTYCOUNT
	ifless 6, Route35NationalParkGate_LessThanFullParty
	readvar VAR_BOXSPACE
	iffalse_jumpopenedtext Route35NationalParkGateOfficer1MakeRoomText
Route35NationalParkGate_LessThanFullParty: ; 6a27d
	special CheckFirstMonIsEgg
	iftrue_jumpopenedtext Route35NationalParkGateOfficer1EggAsFirstMonText
	writetext Route35NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalsefwd Route35NationalParkGate_DeclinedToLeaveMonsBehind
	special ContestDropOffMons
	iftruefwd Route35NationalParkGate_FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext Route35NationalParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext Route35NationalParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump Route35NationalParkGate_OkayToProceed

Route35NationalParkGate_DeclinedToParticipate:
	jumpopenedtext Route35NationalParkGateOfficer1TakePartInFutureText

Route35NationalParkGate_DeclinedToLeaveMonsBehind:
	jumpopenedtext Route35NationalParkGateOfficer1ChooseMonAndComeBackText

Route35NationalParkGate_FirstMonIsFainted:
	jumpopenedtext Route35NationalParkGateOfficer1FirstMonCantBattleText

Route35NationalParkGateOfficerScript:
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue_jumptextfaceplayer Route35NationalParkGateOfficer1ContestIsOverText
Route35NationalParkGate_NoContestToday:
	jumpthistextfaceplayer

	text "We hold Contests"
	line "regularly in the"

	para "park. You should"
	line "give it a shot."
	done

Route35NationalParkGatePlayerApproachOfficer1Movement:
	step_down
	turn_head_left
	step_end

Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement:
	step_right
	step_up
	step_up
	step_end

Route35NationalParkGatePokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_CHARM_INTRO
	iftruefwd Route35NationalParkGateTutorCharmScript
	writetext Route35NationalParkGatePokefanFText
	waitbutton
	setevent EVENT_LISTENED_TO_CHARM_INTRO
Route35NationalParkGateTutorCharmScript:
	writetext Text_Route35NationalParkGateTutorCharm
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Route35NationalParkGateTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval CHARM
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Aw, I guess your"
	line "#mon are cute"
	cont "enough,"

	para "but they still"
	line "could be cuter!"
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Sorry, but I can't"
	line "teach the move"

	para "unless you have a"
	line "a Silver Leaf."
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Your #mon is"
	line "cuter already!"
	done

Route35NationalParkGateOfficer1AskToParticipateText:
	text "Today's "
	text_ram wStringBuffer3
	text "."
	line "That means the"

	para "Bug-Catching Con-"
	line "test is on today."

	para "The rules are sim-"
	line "ple."

	para "Using one of your"
	line "#mon, catch a"

	para "bug #mon to be"
	line "judged."

	para "Would you like to"
	line "give it a try?"
	done

Route35NationalParkGateOfficer1GiveParkBallsText:
	text "Here are the Park"
	line "Balls for the"
	cont "Contest."
	done

Route35NationalParkGatePlayerReceivedParkBallsText:
	text "<PLAYER> gained"
	line "{d:BUG_CONTEST_BALLS} Park Balls."
	done

Route35NationalParkGateOfficer1ExplainsRulesText:
	text "The person who"
	line "gets the strong-"
	cont "est bug #mon"
	cont "is the winner."

	para "You have {d:BUG_CONTEST_MINUTES}"
	line "minutes."

	para "If you run out of"
	line "Park Balls, you're"
	cont "done."

	para "You can keep the"
	line "last #mon you"
	cont "catch as your own."

	para "Go out and catch"
	line "the strongest bug"

	para "#mon you can"
	line "find!"
	done

Route35NationalParkGateOfficer1AskToUseFirstMonText:
	text "Uh-oh…"

	para "You have more than"
	line "one #mon."

	para "You'll have to use"
	line ""
	text_ram wStringBuffer3
	text ", the"

	para "first #mon in"
	line "your party."

	para "Is that OK with"
	line "you?"
	done

Route35NationalParkGateOfficer1WellHoldYourMonText:
	text "Fine, we'll hold"
	line "your other #mon"
	cont "while you compete."
	done

Route35NationalParkGatePlayersMonLeftWithHelperText:
	text "<PLAYER>'s #mon"
	line "were left with the"
	cont "Contest Helper."
	done

Route35NationalParkGateOfficer1ChooseMonAndComeBackText:
	text "Please choose the"
	line "#mon to be used"

	para "in the Contest,"
	line "then come see me."
	done

Route35NationalParkGateOfficer1TakePartInFutureText:
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
	done

Route35NationalParkGateOfficer1FirstMonCantBattleText:
	text "Uh-oh…"
	line "The first #mon"

	para "in your party"
	line "can't battle."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

Route35NationalParkGateOfficer1MakeRoomText:
	text "Uh-oh…"
	line "Both your party"

	para "and your PC Box"
	line "are full."

	para "You have no room"
	line "to put the bug"
	cont "#mon you catch."

	para "Please make room"
	line "in your party or"

	para "your PC Box, then"
	line "come see me."
	done

Route35NationalParkGateOfficer1EggAsFirstMonText:
	text "Uh-oh…"
	line "You have an Egg as"

	para "the first #mon"
	line "in your party."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

Route35NationalParkGateOfficer1WantToFinishText:
	text "You still have "
	text_decimal wItemQuantityChangeBuffer, 1, 2
	line "minute"
	text_plural
	text " left."

	para "Do you want to"
	line "finish now?"
	done

Route35NationalParkGateOfficer1WaitAtNorthGateText:
	text "OK. Please wait at"
	line "the North Gate for"

	para "the announcement"
	line "of the winners."
	done

Route35NationalParkGateOfficer1OkGoFinishText:
	text "OK. Please get"
	line "back outside and"
	cont "finish up."
	done

Route35NationalParkGateOfficer1ContestIsOverText:
	text "Today's Contest is"
	line "over. We hope you"

	para "will participate"
	line "in the future."
	done

Route35NationalParkGateYoungsterText:
	text "When is the next"
	line "Bug-Catching Con-"
	cont "test going to be?"
	done

BugCatchingContestExplanationText:
	text "The Bug-Catching"
	line "Contest is held on"

	para "Tuesday, Thursday"
	line "and Saturday."

	para "Not only do you"
	line "earn a prize just"

	para "for participating,"
	line "you also get to"

	para "keep the bug"
	line "#mon you may"

	para "have at the end of"
	line "the contest."
	done

Route35NationalParkGatePokefanFText:
	text "Many #mon come"
	line "to National Park"

	para "with their"
	line "trainers,"

	para "and they're all"
	line "so, so cute!"

	para "Yes, the Bug"
	line "#mon too!"
	done

Text_Route35NationalParkGateTutorCharm:
	text "I can make your"
	line "#mon cuter with"
	cont "the move Charm."

	para "Even opposing"
	line "#mon won't want"

	para "to hit it as"
	line "hard afterwards!"
	done

Text_Route35NationalParkGateTutorQuestion:
	text "I just need a"
	line "Silver Leaf, so"

	para "can I teach Charm?"
	line "Pretty please?"
	done
