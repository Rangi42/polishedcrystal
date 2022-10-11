TullyPhoneScript1:
	gettrainername FISHER, TULLY1, $0
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdad5
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftruefwd UnknownScript_0xbdad1
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftruefwd UnknownScript_0xbdadc
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbdad1
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd TullySundayNight

UnknownScript_0xbdad1:
	farsjump TullyNoItemScript

UnknownScript_0xbdad5:
	getlandmarkname ROUTE_42, $2
	farsjump TullyForwardScript

UnknownScript_0xbdadc:
	getlandmarkname ROUTE_42, $2
	farsjump TullyHurryScript

TullyPhoneScript2:
	gettrainername FISHER, TULLY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdb1b
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftruefwd UnknownScript_0xbdb1b
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftruefwd UnknownScript_0xbdb1b
	farscall PhoneScript_Random3
	ifequalfwd $0, TullyWantsBattle
	checkevent EVENT_TULLY_GAVE_WATER_STONE
	iftruefwd UnknownScript_0xbdb13
	farscall PhoneScript_Random2
	ifequalfwd $0, TullyFoundWaterStone

UnknownScript_0xbdb13:
	farscall PhoneScript_Random11
	ifequalfwd $0, TullyFoundWaterStone

UnknownScript_0xbdb1b:
	farsjump Phone_GenericCall_Male

TullySundayNight:
	setflag ENGINE_TULLY_SUNDAY_NIGHT

TullyWantsBattle:
	getlandmarkname ROUTE_42, $2
	setflag ENGINE_TULLY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

TullyFoundWaterStone:
	setflag ENGINE_TULLY_HAS_WATER_STONE
	getlandmarkname ROUTE_42, $2
	farsjump PhoneScript_FoundItem_Male
