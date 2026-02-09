StdScripts::
; all scripts must be defined in this bank
	dw PokeCenterNurseScript
	dw DifficultBookshelfScript
	dw PictureBookshelfScript
	dw MagazineBookshelfScript
	dw TeamRocketOathScript
	dw IncenseBurnerScript
	dw MerchandiseShelfScript
	dw TownMapScript
	dw WindowScript
	dw TVScript
	dw Radio1Script
	dw Radio2Script
	dw TrashCanScript
	dw StrengthBoulderScript
	dw SmashRockScript
	dw PokeCenterSignScript
	dw MartSignScript
	dw ElevatorButtonScript
	dw DayToTextScript
	dw BugContestResultsWarpScript
	dw BugContestResultsScript
	dw AskNumber1MScript
	dw AskNumber2MScript
	dw RegisteredNumberMScript
	dw NumberAcceptedMScript
	dw NumberDeclinedMScript
	dw PhoneFullMScript
	dw RematchMScript
	dw GiftMScript
	dw PackFullMScript
	dw RematchGiftMScript
	dw AskNumber1FScript
	dw AskNumber2FScript
	dw RegisteredNumberFScript
	dw NumberAcceptedFScript
	dw NumberDeclinedFScript
	dw PhoneFullFScript
	dw RematchFScript
	dw GiftFScript
	dw PackFullFScript
	dw RematchGiftFScript
	dw GymStatue0Script
	dw GymStatue1Script
	dw GymStatue2Script
	dw GymStatue3Script
	dw PCScript
	dw GameCornerCoinVendorScript
	dw HappinessCheckScript
	dw CutTreeScript
	dw RefrigeratorScript
	dw SinkScript
	dw StoveScript
	dw VendingMachineScript
	dw TreeGrottoScript
	dw CaveGrottoScript
	dw KantoPostGymEventsScript

PokeCenterNurseScript:
	opentext
	checkevent EVENT_NURSE_SAW_TRAINER_STAR
	iftruefwd .star_center
	checktime 1 << MORN
	iftruefwd .morn
	checktime 1 << DAY
	iftruefwd .day
	checktime 1 << EVE
	iftruefwd .eve
	checktime 1 << NITE
	iftruefwd .nite
	sjumpfwd .ok

.morn
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftruefwd .morn_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalsefwd .morn_center
	farwritetext PokeComNurseMornText
	promptbutton
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	sjumpfwd .ok
.morn_center
	farwritetext NurseMornText
	promptbutton
	sjumpfwd .ok

.day
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftruefwd .day_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalsefwd .day_center
	farwritetext PokeComNurseDayText
	promptbutton
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	sjumpfwd .ok
.day_center
	farwritetext NurseDayText
	promptbutton
	sjumpfwd .ok

.eve
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftruefwd .eve_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalsefwd .eve_center
	farwritetext PokeComNurseEveText
	promptbutton
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	sjumpfwd .ok
.eve_center
	farwritetext NurseEveText
	promptbutton
	sjumpfwd .ok

.nite
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftruefwd .nite_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalsefwd .nite_center
	farwritetext PokeComNurseNiteText
	promptbutton
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	sjumpfwd .ok
.nite_center
	farwritetext NurseNiteText
	promptbutton
	; fallthrough

.ok
	readvar VAR_TRAINER_STARS
	ifequalfwd 0, .ask_heal
	farwritetext NurseTrainerStarText
	setevent EVENT_NURSE_SAW_TRAINER_STAR
	sjumpfwd .answer_heal

.ask_heal
	farwritetext NurseAskHealText
.answer_heal
	yesorno
	iffalsefwd .goodbye
	sjumpfwd .heal_pokemon

.star_center
	farwritetext NurseTheUsualText
	yesorno
	iffalsefwd .goodbye
.heal_pokemon
	farwritetext NurseTakePokemonText
	pause 20
	turnobject LAST_TALKED, LEFT
	pause 10
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval 0 ; Machine is at a Pokemon Center
	special HealMachineAnim
	pause 30
	special RestoreMusic
	turnobject LAST_TALKED, DOWN
	pause 10

	checkphonecall ; elm already called about pokerus
	iftruefwd .no
	checkflag ENGINE_CAUGHT_POKERUS ; nurse already talked about pokerus
	iftruefwd .no
	special SpecialCheckPokerus
	iftruefwd .pokerus
.no

	farwritetext NurseReturnPokemonText
	pause 20

.goodbye
	farwritetext NurseGoodbyeText

	turnobject LAST_TALKED, UP
	pause 10
	turnobject LAST_TALKED, DOWN
	pause 10

	waitbutton
	closetext
	sjumpfwd .done

.pokerus
	; already cleared earlier in the script
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftruefwd .pokerus_comcenter
	farwritetext NursePokerusText
	waitbutton
	closetext
	sjumpfwd .pokerus_done

.pokerus_comcenter
	farwritetext PokeComNursePokerusText
	waitbutton
	closetext

.pokerus_done
	setflag ENGINE_CAUGHT_POKERUS
	specialphonecall SPECIALCALL_POKERUS
.done
	turnobject PLAYER, DOWN
	end

DifficultBookshelfScript:
	farjumptext DifficultBookshelfText

PictureBookshelfScript:
	farjumptext PictureBookshelfText

MagazineBookshelfScript:
	farjumptext MagazineBookshelfText

TeamRocketOathScript:
	farjumptext TeamRocketOathText

IncenseBurnerScript:
	farjumptext IncenseBurnerText

MerchandiseShelfScript:
	farjumptext MerchandiseShelfText

RefrigeratorScript:
	farjumptext RefrigeratorText

SinkScript:
	farjumptext SinkText

StoveScript:
	farjumptext StoveText

TownMapScript:
	opentext
	farwritetext TownMapText
	waitbutton
	special Special_TownMap
	endtext

WindowScript:
	farjumptext WindowText

TVScript:
	readvar VAR_FACING
	ifnotequal UP, WrongSideScript
	farjumptext TVText

WrongSideScript:
	farjumptext WrongSideText

Radio1Script:
	callasm IsKantoRadioOffAir
	iftruefwd RadioOffAirScript
	opentext
	setval MAPRADIO_POKEMON_CHANNEL
	special MapRadio
	endtext

Radio2Script:
	callasm IsKantoRadioOffAir
	iftruefwd RadioOffAirScript
	opentext
	setval MAPRADIO_LUCKY_CHANNEL
	special MapRadio
	endtext

RadioOffAirScript:
	farjumptext RadioOffAirText

IsKantoRadioOffAir:
	call RegionCheck
	ld a, e
	cp KANTO_REGION
	jr nz, .no
	ld a, [wPokegearFlags]
	bit 3, a
	ld a, TRUE
	jr z, .ok
.no
	xor a ; ld a, FALSE
.ok
	ldh [hScriptVar], a
	ret

TrashCanScript:
	farjumptext TrashCanText

PCScript:
	readvar VAR_FACING
	ifnotequal UP, WrongSideScript
	opentext
	special PokemonCenterPC
	endtext

ElevatorButtonScript:
	playsound SFX_READ_TEXT_2
	pause 15
	playsound SFX_ELEVATOR_END
	end

StrengthBoulderScript:
	farsjump AskStrengthScript

SmashRockScript:
	farsjump AskRockSmashScript

PokeCenterSignScript:
	farjumptext PokeCenterSignText

MartSignScript:
	farjumptext MartSignText

DayToTextScript:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequalfwd THURSDAY, .Thursday
	ifequalfwd FRIDAY, .Friday
	ifequalfwd SATURDAY, .Saturday
	getstring .SundayText, STRING_BUFFER_3
	end
.Monday:
	getstring .MondayText, STRING_BUFFER_3
	end
.Tuesday:
	getstring .TuesdayText, STRING_BUFFER_3
	end
.Wednesday:
	getstring .WednesdayText, STRING_BUFFER_3
	end
.Thursday:
	getstring .ThursdayText, STRING_BUFFER_3
	end
.Friday:
	getstring .FridayText, STRING_BUFFER_3
	end
.Saturday:
	getstring .SaturdayText, STRING_BUFFER_3
	end
.SundayText:
	db "Sunday@"
.MondayText:
	db "Monday@"
.TuesdayText:
	db "Tuesday@"
.WednesdayText:
	db "Wednesday@"
.ThursdayText:
	db "Thursday@"
.FridayText:
	db "Friday@"
.SaturdayText:
	db "Saturday@"

BugContestResultsWarpScript:
	special ClearBGPalettes
	scall BugContestResults_CopyContestantsToResults
	setevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	clearevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	setevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	warp ROUTE_36_NATIONAL_PARK_GATE, $0, $4
	applymovement PLAYER, Movement_ContestResults_WalkAfterWarp
	; fallthrough

BugContestResultsScript:
	clearflag ENGINE_BUG_CONTEST_TIMER
	clearevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	clearevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	opentext
	farwritetext ContestResults_ReadyToJudgeText
	waitbutton
	special BugContestJudging
	getnum STRING_BUFFER_3
	ifequalfwd 1, .FirstPlace
	ifequalfwd 2, .SecondPlace
	ifequalfwd 3, .ThirdPlace
	readmem wBugContestOfficerPrize
	getitemname USE_SCRIPT_VAR, STRING_BUFFER_4
	farwritetext ContestResults_ConsolationPrizeText
	promptbutton
	waitsfx
	readmem wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iftruefwd .GotConsolationPrize
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_PRIZE
.GotConsolationPrize
	farwritetext ContestResults_DidNotWinText
	promptbutton
	sjumpfwd .FinishUp

.FirstPlace
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.SecondPlace
.ThirdPlace
	readmem wBugContestOfficerPrize
	getitemname USE_SCRIPT_VAR, STRING_BUFFER_4
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	readmem wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iftruefwd .GotWinnersPrize
	farwritetext BugContestPrizeNoRoomText
	promptbutton
	setevent EVENT_CONTEST_OFFICER_HAS_PRIZE
.GotWinnersPrize
	farwritetext ContestResults_JoinUsNextTimeText
	promptbutton
.FinishUp
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalsefwd .DidNotLeaveMons
	farwritetext ContestResults_ReturnPartyText
	waitbutton
	special ContestReturnMons
.DidNotLeaveMons
	special CheckPartyFullAfterContest
	ifequalfwd $0, .CleanUp
	ifequalfwd $2, .CleanUp
	farwritetext ContestResults_PartyFullText
	waitbutton
.CleanUp
	closetext
	setscene $0
	setmapscene ROUTE_35_NATIONAL_PARK_GATE, SCENE_ROUTE35NATIONALPARKGATE_NOOP
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	special PlayMapMusic
	end

BugContestResults_CopyContestantsToResults:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftruefwd .skip1
	clearevent EVENT_BUG_CATCHING_CONTESTANT_1B
.skip1
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftruefwd .skip2
	clearevent EVENT_BUG_CATCHING_CONTESTANT_2B
.skip2
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftruefwd .skip3
	clearevent EVENT_BUG_CATCHING_CONTESTANT_3B
.skip3
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftruefwd .skip4
	clearevent EVENT_BUG_CATCHING_CONTESTANT_4B
.skip4
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftruefwd .skip5
	clearevent EVENT_BUG_CATCHING_CONTESTANT_5B
.skip5
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftruefwd .skip6
	clearevent EVENT_BUG_CATCHING_CONTESTANT_6B
.skip6
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftruefwd .skip7
	clearevent EVENT_BUG_CATCHING_CONTESTANT_7B
.skip7
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftruefwd .skip8
	clearevent EVENT_BUG_CATCHING_CONTESTANT_8B
.skip8
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftruefwd .skip9
	clearevent EVENT_BUG_CATCHING_CONTESTANT_9B
.skip9
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftruefwd .skip10
	clearevent EVENT_BUG_CATCHING_CONTESTANT_10B
.skip10
	end

AskNumber1MScript:
	special RandomPhoneMon
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber1Text
	end
.Huey:
	farwritetext HueyAskNumber1Text
	end
.Gaven:
	farwritetext GavenAskNumber1Text
	end
.Jose:
	farwritetext JoseAskNumber1Text
	end
.Joey:
	farwritetext JoeyAskNumber1Text
	end
.Wade:
	farwritetext WadeAskNumber1Text
	end
.Ralph:
	farwritetext RalphAskNumber1Text
	end
.Anthony:
	farwritetext AnthonyAskNumber1Text
	end
.Todd:
	farwritetext ToddAskNumber1Text
	end
.Irwin:
	farwritetext IrwinAskNumber1Text
	end
.Arnie:
	farwritetext ArnieAskNumber1Text
	end
.Alan:
	farwritetext AlanAskNumber1Text
	end
.Chad:
	farwritetext ChadAskNumber1Text
	end
.Derek:
	farwritetext DerekAskNumber1Text
	end
.Tully:
	farwritetext TullyAskNumber1Text
	end
.Brent:
	farwritetext BrentAskNumber1Text
	end
.Vance:
	farwritetext VanceAskNumber1Text
	end
.Wilton:
	farwritetext WiltonAskNumber1Text
	end
.Kenji:
	farwritetext KenjiAskNumber1Text
	end
.Parry:
	farwritetext ParryAskNumber1Text
	end

AskNumber2MScript:
	special RandomPhoneMon
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber2Text
	end
.Huey:
	farwritetext HueyAskNumber2Text
	end
.Gaven:
	farwritetext GavenAskNumber2Text
	end
.Jose:
	farwritetext JoseAskNumber2Text
	end
.Joey:
	farwritetext JoeyAskNumber2Text
	end
.Wade:
	farwritetext WadeAskNumber2Text
	end
.Ralph:
	farwritetext RalphAskNumber2Text
	end
.Anthony:
	farwritetext AnthonyAskNumber2Text
	end
.Todd:
	farwritetext ToddAskNumber2Text
	end
.Irwin:
	farwritetext IrwinAskNumber2Text
	end
.Arnie:
	farwritetext ArnieAskNumber2Text
	end
.Alan:
	farwritetext AlanAskNumber2Text
	end
.Chad:
	farwritetext ChadAskNumber2Text
	end
.Derek:
	farwritetext DerekAskNumber2Text
	end
.Tully:
	farwritetext TullyAskNumber2Text
	end
.Brent:
	farwritetext BrentAskNumber2Text
	end
.Vance:
	farwritetext VanceAskNumber2Text
	end
.Wilton:
	farwritetext WiltonAskNumber2Text
	end
.Kenji:
	farwritetext KenjiAskNumber2Text
	end
.Parry:
	farwritetext ParryAskNumber2Text
	end

RegisteredNumberMScript:
	farwritetext RegisteredNumber1Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberAcceptedText
	waitendtext

.Huey:
	farwritetext HueyNumberAcceptedText
	waitendtext

.Gaven:
	farwritetext GavenNumberAcceptedText
	waitendtext

.Jose:
	farwritetext JoseNumberAcceptedText
	waitendtext

.Joey:
	farwritetext JoeyNumberAcceptedText
	waitendtext

.Wade:
	farwritetext WadeNumberAcceptedText
	waitendtext

.Ralph:
	farwritetext RalphNumberAcceptedText
	waitendtext

.Anthony:
	farwritetext AnthonyNumberAcceptedText
	waitendtext

.Todd:
	farwritetext ToddNumberAcceptedText
	waitendtext

.Irwin:
	farwritetext IrwinNumberAcceptedText
	waitendtext

.Arnie:
	farwritetext ArnieNumberAcceptedText
	waitendtext

.Alan:
	farwritetext AlanNumberAcceptedText
	waitendtext

.Chad:
	farwritetext ChadNumberAcceptedText
	waitendtext

.Derek:
	farwritetext DerekNumberAcceptedText
	waitendtext

.Tully:
	farwritetext TullyNumberAcceptedText
	waitendtext

.Brent:
	farwritetext BrentNumberAcceptedText
	waitendtext

.Vance:
	farwritetext VanceNumberAcceptedText
	waitendtext

.Wilton:
	farwritetext WiltonNumberAcceptedText
	waitendtext

.Kenji:
	farwritetext KenjiNumberAcceptedText
	waitendtext

.Parry:
	farwritetext ParryNumberAcceptedText
	waitendtext

NumberDeclinedMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberDeclinedText
	waitendtext

.Huey:
	farwritetext HueyNumberDeclinedText
	waitendtext

.Gaven:
	farwritetext GavenNumberDeclinedText
	waitendtext

.Jose:
	farwritetext JoseNumberDeclinedText
	waitendtext

.Joey:
	farwritetext JoeyNumberDeclinedText
	waitendtext

.Wade:
	farwritetext WadeNumberDeclinedText
	waitendtext

.Ralph:
	farwritetext RalphNumberDeclinedText
	waitendtext

.Anthony:
	farwritetext AnthonyNumberDeclinedText
	waitendtext

.Todd:
	farwritetext ToddNumberDeclinedText
	waitendtext

.Irwin:
	farwritetext IrwinNumberDeclinedText
	waitendtext

.Arnie:
	farwritetext ArnieNumberDeclinedText
	waitendtext

.Alan:
	farwritetext AlanNumberDeclinedText
	waitendtext

.Chad:
	farwritetext ChadNumberDeclinedText
	waitendtext

.Derek:
	farwritetext DerekNumberDeclinedText
	waitendtext

.Tully:
	farwritetext TullyNumberDeclinedText
	waitendtext

.Brent:
	farwritetext BrentNumberDeclinedText
	waitendtext

.Vance:
	farwritetext VanceNumberDeclinedText
	waitendtext

.Wilton:
	farwritetext WiltonNumberDeclinedText
	waitendtext

.Kenji:
	farwritetext KenjiNumberDeclinedText
	waitendtext

.Parry:
	farwritetext ParryNumberDeclinedText
	waitendtext

PhoneFullMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackPhoneFullText
	waitendtext

.Huey:
	farwritetext HueyPhoneFullText
	waitendtext

.Gaven:
	farwritetext GavenPhoneFullText
	waitendtext

.Jose:
	farwritetext JosePhoneFullText
	waitendtext

.Joey:
	farwritetext JoeyPhoneFullText
	waitendtext

.Wade:
	farwritetext WadePhoneFullText
	waitendtext

.Ralph:
	farwritetext RalphPhoneFullText
	waitendtext

.Anthony:
	farwritetext AnthonyPhoneFullText
	waitendtext

.Todd:
	farwritetext ToddPhoneFullText
	waitendtext

.Irwin:
	farwritetext IrwinPhoneFullText
	waitendtext

.Arnie:
	farwritetext ArniePhoneFullText
	waitendtext

.Alan:
	farwritetext AlanPhoneFullText
	waitendtext

.Chad:
	farwritetext ChadPhoneFullText
	waitendtext

.Derek:
	farwritetext DerekPhoneFullText
	waitendtext

.Tully:
	farwritetext TullyPhoneFullText
	waitendtext

.Brent:
	farwritetext BrentPhoneFullText
	waitendtext

.Vance:
	farwritetext VancePhoneFullText
	waitendtext

.Wilton:
	farwritetext WiltonPhoneFullText
	waitendtext

.Kenji:
	farwritetext KenjiPhoneFullText
	waitendtext

.Parry:
	farwritetext ParryPhoneFullText
	waitendtext

RematchMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackRematchText
	waitendtext

.Huey:
	farwritetext HueyRematchText
	waitendtext

.Gaven:
	farwritetext GavenRematchText
	waitendtext

.Jose:
	farwritetext JoseRematchText
	waitendtext

.Joey:
	farwritetext JoeyRematchText
	waitendtext

.Wade:
	farwritetext WadeRematchText
	waitendtext

.Ralph:
	farwritetext RalphRematchText
	waitendtext

.Anthony:
	farwritetext AnthonyRematchText
	waitendtext

.Todd:
	farwritetext ToddRematchText
	waitendtext

.Arnie:
	farwritetext ArnieRematchText
	waitendtext

.Alan:
	farwritetext AlanRematchText
	waitendtext

.Chad:
	farwritetext ChadRematchText
	waitendtext

.Tully:
	farwritetext TullyRematchText
	waitendtext

.Brent:
	farwritetext BrentRematchText
	waitendtext

.Vance:
	farwritetext VanceRematchText
	waitendtext

.Wilton:
	farwritetext WiltonRematchText
	waitendtext

.Parry:
	farwritetext ParryRematchText
	waitendtext

GiftMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji

.Jose:
	farwritetext JoseGiftText
	promptbutton
	end
.Wade:
	farwritetext WadeGiftText
	promptbutton
	end
.Alan:
	farwritetext AlanGiftText
	promptbutton
	end
.Derek:
	farwritetext DerekGiftText
	promptbutton
	end
.Tully:
	farwritetext TullyGiftText
	promptbutton
	end
.Wilton:
	farwritetext WiltonGiftText
	promptbutton
	end
.Kenji:
	farwritetext KenjiGiftText
	promptbutton
	end

PackFullMScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyPackFullText
	waitendtext

.Jose:
	farwritetext JosePackFullText
	waitendtext

.Joey:
	farwritetext JoeyPackFullText
	waitendtext

.Wade:
	farwritetext WadePackFullText
	waitendtext

.Alan:
	farwritetext AlanPackFullText
	waitendtext

.Derek:
	farwritetext DerekPackFullText
	waitendtext

.Tully:
	farwritetext TullyPackFullText
	waitendtext

.Vance:
	farwritetext VancePackFullText
	waitendtext

.Wilton:
	farwritetext WiltonPackFullText
	waitendtext

.Kenji:
	farwritetext KenjiPackFullText
	waitendtext

.Parry:
	farwritetext ParryPackFullText
	waitendtext

RematchGiftMScript:
	opentext
	readvar VAR_CALLERID
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyRematchGiftText
	promptbutton
	end
.Joey:
	farwritetext JoeyRematchGiftText
	promptbutton
	end
.Vance:
	farwritetext VanceRematchGiftText
	promptbutton
	end
.Parry:
	farwritetext ParryRematchGiftText
	promptbutton
	end

AskNumber1FScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber1Text
	end
.Beth:
	farwritetext BethAskNumber1Text
	end
.Reena:
	farwritetext ReenaAskNumber1Text
	end
.Liz:
	farwritetext LizAskNumber1Text
	end
.Gina:
	farwritetext GinaAskNumber1Text
	end
.Dana:
	farwritetext DanaAskNumber1Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber1Text
	end
.Erin:
	farwritetext ErinAskNumber1Text
	end

AskNumber2FScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber2Text
	end
.Beth:
	farwritetext BethAskNumber2Text
	end
.Reena:
	farwritetext ReenaAskNumber2Text
	end
.Liz:
	farwritetext LizAskNumber2Text
	end
.Gina:
	farwritetext GinaAskNumber2Text
	end
.Dana:
	farwritetext DanaAskNumber2Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber2Text
	end
.Erin:
	farwritetext ErinAskNumber2Text
	end

RegisteredNumberFScript:
	farwritetext RegisteredNumber2Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
	end

NumberAcceptedFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberAcceptedText
	waitendtext

.Beth:
	farwritetext BethNumberAcceptedText
	waitendtext

.Reena:
	farwritetext ReenaNumberAcceptedText
	waitendtext

.Liz:
	farwritetext LizNumberAcceptedText
	waitendtext

.Gina:
	farwritetext GinaNumberAcceptedText
	waitendtext

.Dana:
	farwritetext DanaNumberAcceptedText
	waitendtext

.Tiffany:
	farwritetext TiffanyNumberAcceptedText
	waitendtext

.Erin:
	farwritetext ErinNumberAcceptedText
	waitendtext

NumberDeclinedFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberDeclinedText
	waitendtext

.Beth:
	farwritetext BethNumberDeclinedText
	waitendtext

.Reena:
	farwritetext ReenaNumberDeclinedText
	waitendtext

.Liz:
	farwritetext LizNumberDeclinedText
	waitendtext

.Gina:
	farwritetext GinaNumberDeclinedText
	waitendtext

.Dana:
	farwritetext DanaNumberDeclinedText
	waitendtext

.Tiffany:
	farwritetext TiffanyNumberDeclinedText
	waitendtext

.Erin:
	farwritetext ErinNumberDeclinedText
	waitendtext

PhoneFullFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPhoneFullText
	waitendtext

.Beth:
	farwritetext BethPhoneFullText
	waitendtext

.Reena:
	farwritetext ReenaPhoneFullText
	waitendtext

.Liz:
	farwritetext LizPhoneFullText
	waitendtext

.Gina:
	farwritetext GinaPhoneFullText
	waitendtext

.Dana:
	farwritetext DanaPhoneFullText
	waitendtext

.Tiffany:
	farwritetext TiffanyPhoneFullText
	waitendtext

.Erin:
	farwritetext ErinPhoneFullText
	waitendtext

RematchFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethRematchText
	waitendtext

.Reena:
	farwritetext ReenaRematchText
	waitendtext

.Liz:
	farwritetext LizRematchText
	waitendtext

.Gina:
	farwritetext GinaRematchText
	waitendtext

.Dana:
	farwritetext DanaRematchText
	waitendtext

.Tiffany:
	farwritetext TiffanyRematchText
	waitendtext

.Erin:
	farwritetext ErinRematchText
	waitendtext

GiftFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly:
	farwritetext BeverlyGiftText
	promptbutton
	end
.Gina:
	farwritetext GinaGiftText
	promptbutton
	end
.Dana:
	farwritetext DanaGiftText
	promptbutton
	end
.Tiffany:
	farwritetext TiffanyGiftText
	promptbutton
	end

PackFullFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPackFullText
	waitendtext

.Gina:
	farwritetext GinaPackFullText
	waitendtext

.Dana:
	farwritetext DanaPackFullText
	waitendtext

.Tiffany:
	farwritetext TiffanyPackFullText
	waitendtext

.Erin:
	farwritetext ErinPackFullText
	waitendtext

RematchGiftFScript:
	readvar VAR_CALLERID
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Erin:
	opentext
	farwritetext ErinRematchGiftText
	promptbutton
	end

GymStatue0Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	waitendtext

GymStatue1Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	farwritetext GymStatue_WinningTrainersText
	waitendtext

GymStatue2Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	farwritetext GymStatue_TwoWinningTrainersText
	waitendtext

GymStatue3Script:
	getcurlandmarkname STRING_BUFFER_3
	opentext
	farwritetext GymStatue_CityGymText
	promptbutton
	farwritetext GymStatue_ThreeWinningTrainersText
	waitendtext

GameCornerCoinVendorScript:
	faceplayer
	opentext
	farwritetext CoinVendor_WelcomeText
	promptbutton
	checkkeyitem COIN_CASE
	iftruefwd CoinVendor_IntroScript
	farwritetext CoinVendor_NoCoinCaseText
	waitendtext

CoinVendor_IntroScript:
	farwritetext CoinVendor_IntroText

.loop
	special Special_DisplayMoneyAndCoinBalance
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .Buy50
	ifequalfwd $2, .Buy500
	sjumpfwd .Cancel

.Buy50:
	checkcoins MAX_COINS - 50
	ifequalfwd HAVE_MORE, .CoinCaseFull
	checkmoney YOUR_MONEY, 1000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	givecoins 50
	takemoney YOUR_MONEY, 1000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy50CoinsText
	waitbutton
	sjump .loop

.Buy500:
	checkcoins MAX_COINS - 500
	ifequalfwd HAVE_MORE, .CoinCaseFull
	checkmoney YOUR_MONEY, 10000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	givecoins 500
	takemoney YOUR_MONEY, 10000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy500CoinsText
	waitbutton
	sjump .loop

.NotEnoughMoney:
	farwritetext CoinVendor_NotEnoughMoneyText
	waitendtext

.CoinCaseFull:
	farwritetext CoinVendor_CoinCaseFullText
	waitendtext

.Cancel:
	farwritetext CoinVendor_CancelText
	waitendtext

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db " 50 :  ¥1000@"
	db "500 : ¥10000@"
	db "Cancel@"

HappinessCheckScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	ifless 50, .Unhappy
	ifless 150, .KindaHappy
	farwritetext HappinessText3
	waitendtext

.KindaHappy:
	farwritetext HappinessText2
	waitendtext

.Unhappy:
	farwritetext HappinessText1
	waitendtext

Movement_ContestResults_WalkAfterWarp:
	step_right
	step_down
	turn_head_up
	step_end

CutTreeScript:
	farsjump AskCutTreeScript

VendingMachineScript:
	opentext
	farwritetext VendingMachineText
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequalfwd $1, .FreshWater
	ifequalfwd $2, .SodaPop
	ifequalfwd $3, .Lemonade
	endtext

.FreshWater:
	checkmoney YOUR_MONEY, 200
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalsefwd .NotEnoughSpace
	takemoney YOUR_MONEY, 200
	getitemname FRESH_WATER, STRING_BUFFER_3
	scall .VendItem
	random $20
	ifnotequal $0, .Start
	giveitem FRESH_WATER
	iffalse .Start
	getitemname FRESH_WATER, STRING_BUFFER_3
	sjumpfwd .ExtraItem

.SodaPop:
	checkmoney YOUR_MONEY, 300
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem SODA_POP
	iffalsefwd .NotEnoughSpace
	takemoney YOUR_MONEY, 300
	getitemname SODA_POP, STRING_BUFFER_3
	scall .VendItem
	random $20
	ifnotequal $0, .Start
	giveitem SODA_POP
	iffalse .Start
	getitemname SODA_POP, STRING_BUFFER_3
	sjumpfwd .ExtraItem

.Lemonade:
	checkmoney YOUR_MONEY, 350
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem LEMONADE
	iffalsefwd .NotEnoughSpace
	takemoney YOUR_MONEY, 350
	getitemname LEMONADE, STRING_BUFFER_3
	scall .VendItem
	random $20
	ifnotequal $0, .Start
	giveitem LEMONADE
	iffalse .Start
	getitemname LEMONADE, STRING_BUFFER_3
	sjumpfwd .ExtraItem

.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	farwritetext VendingMachineClangText
	special ShowItemIcon
	promptbutton
	itemnotify
	end

.ExtraItem:
	pause 10
	playsound SFX_ENTER_DOOR
	farwritetext VendingMachineScoreText
	special ShowItemIcon
	promptbutton
	itemnotify
	sjump .Start

.NotEnoughMoney:
	farwritetext VendingMachineNoMoneyText
	waitbutton
	sjump .Start

.NotEnoughSpace:
	farwritetext VendingMachineNoSpaceText
	waitbutton
	sjump .Start

.MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Fresh Water  ¥200@"
	db "Soda Pop     ¥300@"
	db "Lemonade     ¥350@"
	db "Cancel@"

TreeGrottoScript:
	scall _HiddenGrottoInitScript
	iffalse_endtext
	closetext
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	pause 15
	callasm _HiddenGrottoBackupMap
	warpfacing UP, HIDDEN_TREE_GROTTO, 3, 9
	end

CaveGrottoScript:
	scall _HiddenGrottoInitScript
	iffalse_endtext
	closetext
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	pause 15
	callasm _HiddenGrottoBackupMap
	warpfacing UP, HIDDEN_CAVE_GROTTO, 3, 9
	end

_HiddenGrottoInitScript:
	callasm .StoreCurHiddenGrotto
	opentext
	farwritetext HiddenGrottoText
	yesorno
	end

.StoreCurHiddenGrotto:
	ldh a, [hScriptVar]
	ld [wCurHiddenGrotto], a
	ret

_HiddenGrottoBackupMap:
	ld a, [wMapGroup]
	ld [wBackupMapGroup], a
	ld a, [wMapNumber]
	ld [wBackupMapNumber], a
	ret

KantoPostGymEventsScript:
	readvar VAR_BADGES
	ifequalfwd 9, .FirstBadge
	ifequalfwd 10, .SecondBadge
	ifequalfwd 12, .LyrasEgg
	end

.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	end

.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftruefwd .Done
	specialphonecall SPECIALCALL_SECONDBADGE
.Done:
	end

.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
	end
