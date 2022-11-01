ParryPhoneScript1:
	gettrainername HIKER, PARRY1, $0
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbddac
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftruefwd UnknownScript_0xbdda8
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbdda8
	checktime 1 << DAY
	iftruefwd ParryFridayDay

UnknownScript_0xbdda8:
	farsjump ParryBattleWithMeScript

UnknownScript_0xbddac:
	getlandmarkname ROUTE_45, $2
	farsjump ParryHaventYouGottenToScript

ParryPhoneScript2:
	gettrainername HIKER, PARRY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbddd3
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftruefwd UnknownScript_0xbddd3
	farscall PhoneScript_Random2
	ifequalfwd $0, ParryWantsBattle
	ifequalfwd $1, ParryWantsBattle

UnknownScript_0xbddd3:
	farsjump Phone_GenericCall_Male

ParryFridayDay:
	setflag ENGINE_PARRY_FRIDAY_AFTERNOON

ParryWantsBattle:
	getlandmarkname ROUTE_45, $2
	setflag ENGINE_PARRY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
