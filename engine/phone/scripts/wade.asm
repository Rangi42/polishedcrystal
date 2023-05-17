WadePhoneScript1:
	gettrainername BUG_CATCHER, WADE1, $0
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftruefwd .NotTuesday
	checkflag ENGINE_WADE_HAS_ITEM
	iftruefwd .HasItem
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, .NotTuesday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd WadeTuesdayNight

.NotTuesday:
	farscall PhoneScript_Random2
	ifequalfwd $0, .NoContest
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd .NoContest
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .ContestToday
	ifequalfwd THURSDAY, .ContestToday
	ifequalfwd SATURDAY, .ContestToday

.NoContest:
	farsjump WadeNoBerriesScript

.ContestToday:
	farsjump PhoneScript_BugCatchingContest

.WantsBattle:
	getlandmarkname ROUTE_31, $2
	farsjump WadeQuickBattleScript

.HasItem:
	getlandmarkname ROUTE_31, $2
	farsjump WadeComeQuickScript

WadePhoneScript2:
	gettrainername BUG_CATCHER, WADE1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, .NoContest
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd .NoContest
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .ContestToday
	ifequalfwd THURSDAY, .ContestToday
	ifequalfwd SATURDAY, .ContestToday

.NoContest:
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftruefwd .next
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftruefwd .next
	checkflag ENGINE_WADE_HAS_ITEM
	iftruefwd .next
	farscall PhoneScript_Random2
	ifequalfwd $0, WadeHasItem2
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd .next
	farscall PhoneScript_Random2
	ifequalfwd $0, WadeWantsBattle2

.next:
	farscall PhoneScript_Random3
	ifequalfwd $0, WadeFoundRare
	farsjump Phone_GenericCall_Male

.ContestToday:
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
	ifequalfwd $0, .Berry
	ifequalfwd $1, .PsnCureBerry
	ifequalfwd $2, .PrzCureBerry
	ifequalfwd $3, .Bitterberry

.Berry:
	setevent EVENT_WADE_HAS_ORAN_BERRY
	sjumpfwd .FoundBerry

.PsnCureBerry:
	setevent EVENT_WADE_HAS_PECHA_BERRY
	sjumpfwd .FoundBerry

.PrzCureBerry:
	setevent EVENT_WADE_HAS_CHERI_BERRY
	sjumpfwd .FoundBerry

.Bitterberry:
	setevent EVENT_WADE_HAS_PERSIM_BERRY

.FoundBerry:
	farsjump PhoneScript_FoundItem_Male
