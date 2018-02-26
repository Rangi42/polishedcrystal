Route35NationalParkGate_MapScriptHeader:
	db 3 ; scene scripts
	scene_script Route35NationalParkGateTrigger0
	scene_script Route35NationalParkGateTrigger1
	scene_script Route35NationalParkGateTrigger2

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route35NationalParkGate_CheckIfStillInContest
	callback MAPCALLBACK_OBJECTS, Route35NationalParkGate_CheckIfContestDay

	db 6 ; warp events
	warp_event 15,  0, NATIONAL_PARK, 3
	warp_event 16,  0, NATIONAL_PARK, 4
	warp_event 15,  7, ROUTE_35, 3
	warp_event 16,  7, ROUTE_35, 3
	warp_event  0,  4, OLIVINE_CITY, 11
	warp_event  0,  5, OLIVINE_CITY, 12

	db 0 ; coord events

	db 1 ; bg events
	bg_event 17,  0, SIGNPOST_JUMPTEXT, UnknownText_0x6a90e

	db 3 ; object events
	object_event 14,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, OfficerScript_0x6a204, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event 18,  5, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x6a8d8, EVENT_ROUTE_35_NATIONAL_PARK_GATE_BUG_MANIAC
	object_event 12,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, OfficerScript_0x6a2ca, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY

	const_def 1 ; object constants
	const ROUTE35NATIONALPARKGATE_OFFICER1
	const ROUTE35NATIONALPARKGATE_BUG_MANIAC
	const ROUTE35NATIONALPARKGATE_OFFICER2

Route35NationalParkGateTrigger2:
	priorityjump Route35NationalParkGate_LeavingContestEarly
Route35NationalParkGateTrigger0:
Route35NationalParkGateTrigger1:
	end

Route35NationalParkGate_CheckIfStillInContest:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route35NationalParkGate_Yes
	setscene $0
	return

Route35NationalParkGate_Yes:
	setscene $2
	return

Route35NationalParkGate_CheckIfContestDay:
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, Route35NationalParkGate_IsContestDay
	ifequal THURSDAY, Route35NationalParkGate_IsContestDay
	ifequal SATURDAY, Route35NationalParkGate_IsContestDay
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route35NationalParkGate_Yes
	disappear ROUTE35NATIONALPARKGATE_OFFICER1
	appear ROUTE35NATIONALPARKGATE_BUG_MANIAC
	appear ROUTE35NATIONALPARKGATE_OFFICER2
	return

Route35NationalParkGate_IsContestDay:
	appear ROUTE35NATIONALPARKGATE_OFFICER1
	disappear ROUTE35NATIONALPARKGATE_BUG_MANIAC
	disappear ROUTE35NATIONALPARKGATE_OFFICER2
	return

Route35NationalParkGate_LeavingContestEarly:
	applymovement PLAYER, MovementData_0x6a2e2
	turnobject ROUTE35NATIONALPARKGATE_OFFICER1, RIGHT
	opentext
	checkcode VAR_CONTESTMINUTES
	addvar $1
	RAM2MEM $0
	writetext UnknownText_0x6a79a
	yesorno
	iffalse Route35NationalParkGate_GoBackIn
	writetext UnknownText_0x6a7db
	waitbutton
	closetext
	jumpstd bugcontestresultswarp

Route35NationalParkGate_GoBackIn:
	writetext UnknownText_0x6a823
	waitbutton
	closetext
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 12, 47
	end

OfficerScript_0x6a204:
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, Route35NationalParkGate_NoContestToday
	ifequal MONDAY, Route35NationalParkGate_NoContestToday
	ifequal WEDNESDAY, Route35NationalParkGate_NoContestToday
	ifequal FRIDAY, Route35NationalParkGate_NoContestToday
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue_jumptextfaceplayer UnknownText_0x6a84f
	faceplayer
	opentext
	callstd daytotext
	writetext UnknownText_0x6a2eb
	yesorno
	iffalse Route35NationalParkGate_DeclinedToParticipate
	checkcode VAR_PARTYCOUNT
	ifgreater $1, Route35NationalParkGate_LeaveTheRestBehind
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
Route35NationalParkGate_OkayToProceed:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext UnknownText_0x6a39d
	buttonsound
	writetext UnknownText_0x6a3c7
	playsound SFX_ITEM
	waitsfx
	writetext UnknownText_0x6a3e2
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
	checkcode VAR_FACING
	ifequal LEFT, Route35NationalParkGate_FacingLeft
	applymovement PLAYER, MovementData_0x6a2e5
	end

Route35NationalParkGate_FacingLeft:
	applyonemovement PLAYER, step_up
	end

Route35NationalParkGate_LeaveTheRestBehind:
	checkcode VAR_PARTYCOUNT
	ifless 6, Route35NationalParkGate_LessThanFullParty
	checkcode VAR_BOXSPACE
	iffalse_jumpopenedtext UnknownText_0x6a67c
Route35NationalParkGate_LessThanFullParty: ; 6a27d
	special CheckFirstMonIsEgg
	iftrue_jumpopenedtext UnknownText_0x6a71f
	writetext UnknownText_0x6a4c6
	yesorno
	iffalse Route35NationalParkGate_DeclinedToLeaveMonsBehind
	special ContestDropOffMons
	iftrue Route35NationalParkGate_FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext UnknownText_0x6a537
	buttonsound
	writetext UnknownText_0x6a56b
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	buttonsound
	jump Route35NationalParkGate_OkayToProceed

Route35NationalParkGate_DeclinedToParticipate:
	jumpopenedtext UnknownText_0x6a5dc

Route35NationalParkGate_DeclinedToLeaveMonsBehind:
	jumpopenedtext UnknownText_0x6a597

Route35NationalParkGate_FirstMonIsFainted:
	jumpopenedtext UnknownText_0x6a608

OfficerScript_0x6a2ca:
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue_jumptextfaceplayer UnknownText_0x6a84f
Route35NationalParkGate_NoContestToday:
	thistextfaceplayer

	text "We hold Contests"
	line "regularly in the"

	para "park. You should"
	line "give it a shot."
	done

MovementData_0x6a2e2:
	step_down
	turn_head_left
	step_end

MovementData_0x6a2e5:
	step_right
	step_up
	step_up
	step_end

UnknownText_0x6a2eb:
	text "Today's @"
	text_from_ram StringBuffer3
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

UnknownText_0x6a39d:
	text "Here are the Park"
	line "Balls for the"
	cont "Contest."
	done

UnknownText_0x6a3c7:
	text "<PLAYER> received"
	line "20 Park Balls."
	done

UnknownText_0x6a3e2:
	text "The person who"
	line "gets the strong-"
	cont "est bug #mon"
	cont "is the winner."

if DEF(NO_RTC)
	para "You have 120"
else
	para "You have 20"
endc
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

UnknownText_0x6a4c6:
	text "Uh-oh…"

	para "You have more than"
	line "one #mon."

	para "You'll have to use"
	line "@"
	text_from_ram StringBuffer3
	text ", the"

	para "first #mon in"
	line "your party."

	para "Is that OK with"
	line "you?"
	done

UnknownText_0x6a537:
	text "Fine, we'll hold"
	line "your other #mon"
	cont "while you compete."
	done

UnknownText_0x6a56b:
	text "<PLAYER>'s #mon"
	line "were left with the"
	cont "Contest Helper."
	done

UnknownText_0x6a597:
	text "Please choose the"
	line "#mon to be used"

	para "in the Contest,"
	line "then come see me."
	done

UnknownText_0x6a5dc:
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
	done

UnknownText_0x6a608:
	text "Uh-oh…"
	line "The first #mon"

	para "in your party"
	line "can't battle."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

UnknownText_0x6a67c:
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

UnknownText_0x6a71f:
	text "Uh-oh…"
	line "You have an Egg as"

	para "the first #mon"
	line "in your party."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

UnknownText_0x6a79a:
	text "You still have @"
	text_from_ram StringBuffer3
	text ""
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

UnknownText_0x6a7db:
	text "OK. Please wait at"
	line "the North Gate for"

	para "the announcement"
	line "of the winners."
	done

UnknownText_0x6a823:
	text "OK. Please get"
	line "back outside and"
	cont "finish up."
	done

UnknownText_0x6a84f:
	text "Today's Contest is"
	line "over. We hope you"

	para "will participate"
	line "in the future."
	done

UnknownText_0x6a8d8:
	text "When is the next"
	line "Bug-Catching Con-"
	cont "test going to be?"
	done

UnknownText_0x6a90e:
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
