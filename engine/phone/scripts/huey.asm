HueyPhoneScript1:
	gettrainername SAILOR, HUEY1, $0
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd1a2
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftruefwd UnknownScript_0xbd19b
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd19b
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd HueyWednesdayNight

UnknownScript_0xbd19b:
	special RandomPhoneMon
	farsjump HueyHangUpScript

UnknownScript_0xbd1a2:
	getlandmarkname LIGHTHOUSE, $2
	farsjump HueyWantsBattleScript

HueyPhoneScript2:
	gettrainername SAILOR, HUEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd1c9
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftruefwd UnknownScript_0xbd1c9
	farscall PhoneScript_Random3
	ifequalfwd $0, HueyWantsBattle
	ifequalfwd $1, HueyWantsBattle

UnknownScript_0xbd1c9:
	farsjump PhoneScript_MonFlavorText

HueyWednesdayNight:
	setflag ENGINE_HUEY_WEDNESDAY_NIGHT

HueyWantsBattle:
	getlandmarkname LIGHTHOUSE, $2
	setflag ENGINE_HUEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
