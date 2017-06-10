const_value set 2
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

Route36NationalParkgate_MapScriptHeader:
.MapTriggers:
	db 3
	dw .Trigger0
	dw .Trigger1
	dw .Trigger2

.MapCallbacks:
	db 2
	dbw MAPCALLBACK_NEWMAP, .CheckIfContestRunning
	dbw MAPCALLBACK_OBJECTS, .CheckIfContestAvailable

.Trigger2:
	priorityjump .LeftTheContestEarly
.Trigger0:
.Trigger1:
	end

.CheckIfContestRunning:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	dotrigger $0
	return

.BugContestIsRunning:
	dotrigger $2
	return

.CheckIfContestAvailable:
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

.LeftTheContestEarly:
	spriteface PLAYER, UP
	opentext
	checkcode VAR_CONTESTMINUTES
	addvar $1
	RAM2MEM $0
	writetext UnknownText_0x6b284
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
	writetext UnknownText_0x6b300
	waitbutton
	closetext
	spriteface PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, $23, $12
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
	if_equal SUNDAY, _ContestNotOn
	if_equal MONDAY, _ContestNotOn
	if_equal WEDNESDAY, _ContestNotOn
	if_equal FRIDAY, _ContestNotOn
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	scall Route36Parkgate_DayToText
	writetext UnknownText_0x6add5
	yesorno
	iffalse .DecidedNotToJoinContest
	checkcode VAR_PARTYCOUNT
	if_greater_than $1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext UnknownText_0x6ae87
	buttonsound
	waitsfx
	writetext UnknownText_0x6aeb1
	playsound SFX_ITEM
	waitsfx
	writetext UnknownText_0x6aecc
	waitbutton
	closetext
	setflag ENGINE_BUG_CONTEST_TIMER
	special Special_GiveParkBalls
	spriteface PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special Special_SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, $23, $12
	end

.LeaveMonsWithOfficer:
	checkcode VAR_PARTYCOUNT
	if_less_than $6, .ContinueLeavingMons
	checkcode VAR_BOXSPACE
	if_equal $0, .BoxFull
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	if_equal $1, .FirstMonIsEgg
	writetext UnknownText_0x6afb0
	yesorno
	iffalse .RefusedToLeaveMons
	special ContestDropOffMons
	iftrue .FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext UnknownText_0x6b021
	buttonsound
	writetext UnknownText_0x6b055
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	buttonsound
	jump .ResumeStartingContest

.DecidedNotToJoinContest:
	writetext UnknownText_0x6b0c6
	waitbutton
	closetext
	end

.RefusedToLeaveMons:
	writetext UnknownText_0x6b081
	waitbutton
	closetext
	end

.FirstMonIsFainted:
	writetext UnknownText_0x6b0f2
	waitbutton
	closetext
	end

.BoxFull:
	writetext UnknownText_0x6b166
	waitbutton
	closetext
	end

.FirstMonIsEgg:
	writetext UnknownText_0x6b209
	waitbutton
	closetext
	end

Route36Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	iftrue .SunStone
	checkevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	iftrue .Everstone
	checkevent EVENT_CONTEST_OFFICER_HAS_SITRUS_BERRY
	iftrue .SitrusBerry
	checkevent EVENT_CONTEST_OFFICER_HAS_ORAN_BERRY
	iftrue .OranBerry
	writetext UnknownText_0x6b32b
	waitbutton
	closetext
	end

.SunStone:
	writetext UnknownText_0x6b97f
	buttonsound
	verbosegiveitem SUN_STONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	closetext
	end

.Everstone:
	writetext UnknownText_0x6b97f
	buttonsound
	verbosegiveitem EVERSTONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	closetext
	end

.SitrusBerry:
	writetext UnknownText_0x6b97f
	buttonsound
	verbosegiveitem SITRUS_BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_SITRUS_BERRY
	closetext
	end

.OranBerry:
	writetext UnknownText_0x6b97f
	buttonsound
	verbosegiveitem ORAN_BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_ORAN_BERRY
	closetext
	end

.BagFull:
	writetext UnknownText_0x6b910
	waitbutton
	closetext
	end

_ContestNotOn:
	jumptextfaceplayer UnknownText_0x6b370

OfficerScript_0x6acf4:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route36Officer_ContestHasConcluded
	writetext UnknownText_0x6b370
	waitbutton
	closetext
	end

Route36Parkgate_DayToText:
	jumpstd daytotext
	end

BugCatcherScript_0x6ad06:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad14
	writetext UnknownText_0x6b399
	waitbutton
	closetext
	end

UnknownScript_0x6ad14:
	writetext UnknownText_0x6b3c4
	waitbutton
	closetext
	end

BugManiacScript_0x6ad1a:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad28
	writetext UnknownText_0x6b40f
	waitbutton
	closetext
	end

UnknownScript_0x6ad28:
	writetext UnknownText_0x6b440
	waitbutton
	closetext
	end

CooltrainerMScript_0x6ad2e:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad3c
	writetext UnknownText_0x6b462
	waitbutton
	closetext
	end

UnknownScript_0x6ad3c:
	writetext UnknownText_0x6b496
	waitbutton
	closetext
	end

PokefanMScript_0x6ad42:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad50
	writetext UnknownText_0x6b4da
	waitbutton
	closetext
	end

UnknownScript_0x6ad50:
	writetext UnknownText_0x6b50a
	waitbutton
	closetext
	end

BugCatcherScript_0x6ad56:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad64
	writetext UnknownText_0x6b54e
	waitbutton
	closetext
	end

UnknownScript_0x6ad64:
	writetext UnknownText_0x6b57c
	waitbutton
	closetext
	end

YoungsterScript_0x6ad6a:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad78
	writetext UnknownText_0x6b5b0
	waitbutton
	closetext
	end

UnknownScript_0x6ad78:
	writetext UnknownText_0x6b5dd
	waitbutton
	closetext
	end

LassScript_0x6ad7e:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ad8c
	writetext UnknownText_0x6b64b
	waitbutton
	closetext
	end

UnknownScript_0x6ad8c:
	writetext UnknownText_0x6b698
	waitbutton
	closetext
	end

BugCatcherScript_0x6ad92:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6ada0
	writetext UnknownText_0x6b6b8
	waitbutton
	closetext
	end

UnknownScript_0x6ada0:
	writetext UnknownText_0x6b6e9
	waitbutton
	closetext
	end

YoungsterScript_0x6ada6:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6adb4
	writetext UnknownText_0x6b71b
	waitbutton
	closetext
	end

UnknownScript_0x6adb4:
	writetext UnknownText_0x6b740
	waitbutton
	closetext
	end

YoungsterScript_0x6adba:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iffalse UnknownScript_0x6adc8
	writetext UnknownText_0x6b76f
	waitbutton
	closetext
	end

UnknownScript_0x6adc8:
	writetext UnknownText_0x6b7af
	waitbutton
	closetext
	end

MovementData_0x6add1:
	big_step_down
	big_step_right
	turn_head_up
	step_end

UnknownText_0x6add5:
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

UnknownText_0x6ae87:
	text "Here are the Park"
	line "Balls for the"
	cont "Contest."
	done

UnknownText_0x6aeb1:
	text "<PLAYER> received"
	line "20 Park Balls."
	done

UnknownText_0x6aecc:
	text "The person who"
	line "gets the strong-"
	cont "est bug #mon"
	cont "is the winner."

	para "You have 20"
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

UnknownText_0x6afb0:
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

UnknownText_0x6b021:
	text "Fine, we'll hold"
	line "your other #mon"
	cont "while you compete."
	done

UnknownText_0x6b055:
	text "<PLAYER>'s #mon"
	line "were left with the"
	cont "Contest Helper."
	done

UnknownText_0x6b081:
	text "Please choose the"
	line "#mon to be used"

	para "in the Contest,"
	line "then come see me."
	done

UnknownText_0x6b0c6:
	text "OK. We hope you'll"
	line "take part in the"
	cont "future."
	done

UnknownText_0x6b0f2:
	text "Uh-oh…"
	line "The first #mon"

	para "in your party"
	line "can't battle."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

UnknownText_0x6b166:
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

UnknownText_0x6b209:
	text "Uh-oh…"
	line "You have an Egg as"

	para "the first #mon"
	line "in your party."

	para "Please switch it"
	line "with the #mon"

	para "you want to use,"
	line "then come see me."
	done

UnknownText_0x6b284:
	text "You still have @"
	text_from_ram StringBuffer3
	text ""
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

UnknownText_0x6b2c5:
	text "OK. Please wait"
	line "here for the"

	para "announcement of"
	line "the winners."
	done

UnknownText_0x6b300:
	text "OK. Please go back"
	line "outside and finish"
	cont "up."
	done

UnknownText_0x6b32b:
	text "Today's Contest is"
	line "over. We hope you"

	para "will participate"
	line "in the future."
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

Route36NationalParkgate_MapEventHeader:
.Warps:
	db 4
	warp_def $4, $0, 1, NATIONAL_PARK
	warp_def $5, $0, 2, NATIONAL_PARK
	warp_def $4, $9, 1, ROUTE_36
	warp_def $5, $9, 2, ROUTE_36

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 0, 6, SIGNPOST_READ, MapRoute36NationalParkgateSignpost0Script

.PersonEvents:
	db 12
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
