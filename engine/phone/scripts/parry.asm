ParryPhoneScript1:
	gettrainername HIKER, PARRY1, $0
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftruefwd .WantsRematch
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .WantsRematch
	checktime 1 << DAY
	iftruefwd ParryFridayDay

.WantsRematch:
	farsjump ParryBattleWithMeScript

.WantsBattle:
	getlandmarkname ROUTE_45, $2
	farsjump ParryHaventYouGottenToScript

ParryPhoneScript2:
	gettrainername HIKER, PARRY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftruefwd .GenericCall
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftruefwd .GenericCall
	farscall PhoneScript_Random2
	ifequalfwd $0, ParryWantsBattle
	ifequalfwd $1, ParryWantsBattle

.GenericCall:
	farsjump Phone_GenericCall_Male

ParryFridayDay:
	setflag ENGINE_PARRY_FRIDAY_AFTERNOON

ParryWantsBattle:
	getlandmarkname ROUTE_45, $2
	setflag ENGINE_PARRY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
