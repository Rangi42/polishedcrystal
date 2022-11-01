WadePhoneScript1:
	gettrainername BUG_CATCHER, WADE1, $0
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd41a
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftruefwd UnknownScript_0xbd3f6
	checkflag ENGINE_WADE_HAS_ITEM
	iftruefwd UnknownScript_0xbd421
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd3f6
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd WadeTuesdayNight

UnknownScript_0xbd3f6:
	farscall PhoneScript_Random2
	ifequalfwd $0, UnknownScript_0xbd412
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd UnknownScript_0xbd412
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, UnknownScript_0xbd416
	ifequalfwd THURSDAY, UnknownScript_0xbd416
	ifequalfwd SATURDAY, UnknownScript_0xbd416

UnknownScript_0xbd412:
	farsjump WadeNoBerriesScript

UnknownScript_0xbd416:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbd41a:
	getlandmarkname ROUTE_31, $2
	farsjump WadeQuickBattleScript

UnknownScript_0xbd421:
	getlandmarkname ROUTE_31, $2
	farsjump WadeComeQuickScript

WadePhoneScript2:
	gettrainername BUG_CATCHER, WADE1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, UnknownScript_0xbd44c
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd UnknownScript_0xbd44c
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, UnknownScript_0xbd480
	ifequalfwd THURSDAY, UnknownScript_0xbd480
	ifequalfwd SATURDAY, UnknownScript_0xbd480

UnknownScript_0xbd44c:
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd474
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftruefwd UnknownScript_0xbd474
	checkflag ENGINE_WADE_HAS_ITEM
	iftruefwd UnknownScript_0xbd474
	farscall PhoneScript_Random2
	ifequalfwd $0, WadeHasItem2
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd UnknownScript_0xbd474
	farscall PhoneScript_Random2
	ifequalfwd $0, WadeWantsBattle2

UnknownScript_0xbd474:
	farscall PhoneScript_Random3
	ifequalfwd $0, WadeFoundRare
	farsjump Phone_GenericCall_Male

UnknownScript_0xbd480:
	farsjump PhoneScript_BugCatchingContest

WadeTuesdayNight:
	setflag ENGINE_WADE_TUESDAY_NIGHT

WadeWantsBattle2:
	getlandmarkname ROUTE_31, $2
	setflag ENGINE_WADE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WadeFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

WadeHasItem2:
	setflag ENGINE_WADE_HAS_ITEM
	getlandmarkname ROUTE_31, $2
	clearevent EVENT_WADE_HAS_ORAN_BERRY
	clearevent EVENT_WADE_HAS_PECHA_BERRY
	clearevent EVENT_WADE_HAS_CHERI_BERRY
	clearevent EVENT_WADE_HAS_PERSIM_BERRY
	random $4
	ifequalfwd $0, UnknownScript_0xbd4b9
	ifequalfwd $1, UnknownScript_0xbd4bf
	ifequalfwd $2, UnknownScript_0xbd4c5
	ifequalfwd $3, UnknownScript_0xbd4cb

UnknownScript_0xbd4b9:
	setevent EVENT_WADE_HAS_ORAN_BERRY
	sjumpfwd UnknownScript_0xbd4ce

UnknownScript_0xbd4bf:
	setevent EVENT_WADE_HAS_PECHA_BERRY
	sjumpfwd UnknownScript_0xbd4ce

UnknownScript_0xbd4c5:
	setevent EVENT_WADE_HAS_CHERI_BERRY
	sjumpfwd UnknownScript_0xbd4ce

UnknownScript_0xbd4cb:
	setevent EVENT_WADE_HAS_PERSIM_BERRY

UnknownScript_0xbd4ce:
	farsjump PhoneScript_FoundItem_Male
