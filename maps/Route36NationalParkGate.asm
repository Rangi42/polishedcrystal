Route36NationalParkGate_MapScriptHeader:

.MapTriggers: db 3
	dw Route36NationalParkGateTrigger0
	dw Route36NationalParkGateTrigger1
	dw Route36NationalParkGateTrigger2

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, Route36NationalParkGateCheckIfContestRunning
	dbw MAPCALLBACK_OBJECTS, Route36NationalParkGateCheckIfContestAvailable

Route36NationalParkGate_MapEventHeader:

.Warps: db 4
	warp_def 4, 0, 1, NATIONAL_PARK
	warp_def 5, 0, 2, NATIONAL_PARK
	warp_def 4, 9, 1, ROUTE_36
	warp_def 5, 9, 2, ROUTE_36

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 6, SIGNPOST_JUMPTEXT, UnknownText_0x6a90e

.PersonEvents: db 12
	person_event SPRITE_OFFICER, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route36OfficerScriptContest, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	person_event SPRITE_BUG_CATCHER, 5, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x6ad06, EVENT_BUG_CATCHING_CONTESTANT_1B
	person_event SPRITE_BUG_MANIAC, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BugManiacScript_0x6ad1a, EVENT_BUG_CATCHING_CONTESTANT_2B
	person_event SPRITE_COOLTRAINER_M, 6, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x6ad2e, EVENT_BUG_CATCHING_CONTESTANT_3B
	person_event SPRITE_POKEFAN_M, 5, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x6ad42, EVENT_BUG_CATCHING_CONTESTANT_4B
	person_event SPRITE_BUG_CATCHER, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x6ad56, EVENT_BUG_CATCHING_CONTESTANT_5B
	person_event SPRITE_YOUNGSTER, 6, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x6ad6a, EVENT_BUG_CATCHING_CONTESTANT_6B
	person_event SPRITE_LASS, 6, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x6ad7e, EVENT_BUG_CATCHING_CONTESTANT_7B
	person_event SPRITE_BUG_CATCHER, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x6ad92, EVENT_BUG_CATCHING_CONTESTANT_8B
	person_event SPRITE_YOUNGSTER, 7, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x6ada6, EVENT_BUG_CATCHING_CONTESTANT_9B
	person_event SPRITE_YOUNGSTER, 6, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x6adba, EVENT_BUG_CATCHING_CONTESTANT_10B
	person_event SPRITE_OFFICER, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, OfficerScript_0x6acf4, EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY

const_value set 1
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
	priorityjump Route36NationalParkGateLeftTheContestEarly
Route36NationalParkGateTrigger0:
Route36NationalParkGateTrigger1:
	end

Route36NationalParkGateCheckIfContestRunning:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	dotrigger $0
	return

.BugContestIsRunning:
	dotrigger $2
	return

Route36NationalParkGateCheckIfContestAvailable:
	checkevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	iftrue .Return
	checkcode VAR_WEEKDAY
	if_equal TUESDAY, .SetContestOfficer
	if_equal THURSDAY, .SetContestOfficer
	if_equal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .SetContestOfficer
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	return

.SetContestOfficer:
	appear ROUTE36NATIONALPARKGATE_OFFICER1
	disappear ROUTE36NATIONALPARKGATE_OFFICER2
.Return:
	return

Route36NationalParkGateLeftTheContestEarly:
	spriteface PLAYER, UP
	opentext
	checkcode VAR_CONTESTMINUTES
	addvar $1
	RAM2MEM $0
	writetext UnknownText_0x6a79a
	yesorno
	iffalse .GoBackToContest
	writetext UnknownText_0x6b2c5
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	scall .CopyContestants
	disappear ROUTE36NATIONALPARKGATE_OFFICER1
	appear ROUTE36NATIONALPARKGATE_OFFICER2
	applymovement PLAYER, MovementData_0x6add1
	pause 15
	special Special_FadeInQuickly
	jumpstd bugcontestresults

.GoBackToContest:
	writetext UnknownText_0x6a823
	waitbutton
	closetext
	spriteface PLAYER, LEFT
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
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, .ContestNotOn
	if_equal MONDAY, .ContestNotOn
	if_equal WEDNESDAY, .ContestNotOn
	if_equal FRIDAY, .ContestNotOn
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	faceplayer
	opentext
	callstd daytotext
	writetext UnknownText_0x6a2eb
	yesorno
	iffalse_jumpopenedtext UnknownText_0x6a5dc
	checkcode VAR_PARTYCOUNT
	if_greater_than $1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext UnknownText_0x6a39d
	buttonsound
	waitsfx
	writetext UnknownText_0x6a3c7
	playsound SFX_ITEM
	waitsfx
	writetext UnknownText_0x6a3e2
	waitbutton
	closetext
	setflag ENGINE_BUG_CONTEST_TIMER
	special Special_GiveParkBalls
	spriteface PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special Special_SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 35, 18
	end

.ContestNotOn:
	jumptextfaceplayer UnknownText_0x6b370

.LeaveMonsWithOfficer:
	checkcode VAR_PARTYCOUNT
	if_less_than $6, .ContinueLeavingMons
	checkcode VAR_BOXSPACE
	if_equal $0, .BoxFull
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	if_equal $1, .FirstMonIsEgg
	writetext UnknownText_0x6a4c6
	yesorno
	iffalse_jumpopenedtext UnknownText_0x6a597
	special ContestDropOffMons
	iftrue_jumpopenedtext UnknownText_0x6a608
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext UnknownText_0x6a537
	buttonsound
	writetext UnknownText_0x6a56b
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	buttonsound
	jump .ResumeStartingContest

.BoxFull:
	jumpopenedtext UnknownText_0x6a67c

.FirstMonIsEgg:
	jumpopenedtext UnknownText_0x6a71f

Route36Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	iffalse_jumptextfaceplayer UnknownText_0x6a84f
	faceplayer
	opentext
	writetext UnknownText_0x6b97f
	buttonsound
	copybytetovar wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iffalse_jumpopenedtext UnknownText_0x6b910
	clearevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	endtext

OfficerScript_0x6acf4:
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	jumptextfaceplayer UnknownText_0x6b370

BugCatcherScript_0x6ad06:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b3c4
	jumptextfaceplayer UnknownText_0x6b399

BugManiacScript_0x6ad1a:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b440
	jumptextfaceplayer UnknownText_0x6b40f

CooltrainerMScript_0x6ad2e:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b496
	jumptextfaceplayer UnknownText_0x6b462

PokefanMScript_0x6ad42:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b50a
	jumptextfaceplayer UnknownText_0x6b4da

BugCatcherScript_0x6ad56:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b57c
	jumptextfaceplayer UnknownText_0x6b54e

YoungsterScript_0x6ad6a:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b5dd
	jumptextfaceplayer UnknownText_0x6b5b0

LassScript_0x6ad7e:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b698
	jumptextfaceplayer UnknownText_0x6b64b

BugCatcherScript_0x6ad92:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b6e9
	jumptextfaceplayer UnknownText_0x6b6b8

YoungsterScript_0x6ada6:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b740
	jumptextfaceplayer UnknownText_0x6b71b

YoungsterScript_0x6adba:
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse_jumptextfaceplayer UnknownText_0x6b7af
	jumptextfaceplayer UnknownText_0x6b76f

MovementData_0x6add1:
	big_step_down
	big_step_right
	turn_head_up
	step_end

UnknownText_0x6b2c5:
	text "OK. Please wait"
	line "here for the"

	para "announcement of"
	line "the winners."
	done

UnknownText_0x6b370:
	text "Some #mon can"
	line "only be seen in"
	cont "the Park."
	done

UnknownText_0x6b399:
	text "Don: Wow, you beat"
	line "me. You're pretty"
	cont "good."
	done

UnknownText_0x6b3c4:
	text "Don: Luck plays a"
	line "big part in this."

	para "You never know"
	line "what #mon will"
	cont "appear."
	done

UnknownText_0x6b40f:
	text "Lou: I envy you."
	line "I just couldn't"
	cont "do it this time."
	done

UnknownText_0x6b440:
	text "Lou: Maybe you win"
	line "with big #mon?"
	done

UnknownText_0x6b462:
	text "Nick: Well done!"
	line "I'm going to raise"
	cont "my #mon better."
	done

UnknownText_0x6b496:
	text "Nick: Maybe you"
	line "get a higher score"

	para "for a #mon of"
	line "an unusual color."
	done

UnknownText_0x6b4da:
	text "William: You're"
	line "the winner? What"
	cont "did you catch?"
	done

UnknownText_0x6b50a:
	text "William: Well, I'm"
	line "satisfied because"

	para "I caught a #mon"
	line "that I wanted."
	done

UnknownText_0x6b54e:
	text "Benny: Congrats!"
	line "You have earned my"
	cont "respect!"
	done

UnknownText_0x6b57c:
	text "Benny: I caught a"
	line "Scyther before,"
	cont "but I didn't win."
	done

UnknownText_0x6b5b0:
	text "Barry: That #-"
	line "mon you caught…"
	cont "it's awesome!"
	done

UnknownText_0x6b5dd:
	text "Barry: It's easier"
	line "to win if you get"

	para "a high-level bug"
	line "#mon."

	para "But I think they"
	line "also consider some"
	cont "other points."
	done

UnknownText_0x6b64b:
	text "Cindy: You won?"
	line "That's great!"

	para "Do you feel like"
	line "looking for bug"
	cont "#mon with me?"
	done

UnknownText_0x6b698:
	text "Cindy: I really"
	line "love bug #mon!"
	done

UnknownText_0x6b6b8:
	text "Josh: I… I can't"
	line "believe I lost at"
	cont "bug-catching…"
	done

UnknownText_0x6b6e9:
	text "Josh: I heard that"
	line "somebody won with"
	cont "a Caterpie!"
	done

UnknownText_0x6b71b:
	text "Johnny: Next time,"
	line "I'm going to win."
	done

UnknownText_0x6b740:
	text "Johnny: Darn."
	line "I thought I would"
	cont "score higher…"
	done

UnknownText_0x6b76f:
	text "Kipp: Could you"
	line "give me some tips?"

	para "I want to study"
	line "your style."
	done

UnknownText_0x6b7af:
	text "Kipp: I study a"
	line "lot, but that's"

	para "not good enough to"
	line "win."
	done

UnknownText_0x6b910:
	text "Uh-oh… Your Bag"
	line "is full."

	para "We'll hold on to"
	line "your prize, but"
	cont "only for today."

	para "Please make room,"
	line "then come see me."
	done

UnknownText_0x6b97f:
	text "<PLAYER>?"

	para "Here's the prize"
	line "we were holding"
	cont "for you."
	done
