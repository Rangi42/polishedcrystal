JoeyPhoneScript1:
	gettrainername YOUNGSTER, JOEY1, $0
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd399
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd392
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd392
	checktime 1 << DAY
	iftruefwd JoeyMondayAfternoon

UnknownScript_0xbd392:
	special RandomPhoneMon
	farwritetext JoeyDevisingStrategiesText
	promptbutton
	farsjump PhoneScript_HangupText_Male

UnknownScript_0xbd399:
	getlandmarkname ROUTE_30, $2
	farsjump JoeyReminderScript

JoeyPhoneScript2:
	gettrainername YOUNGSTER, JOEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd3c0
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd3c0
	farscall PhoneScript_Random3
	ifequalfwd $0, JoeyWantsBattle
	ifequalfwd $1, JoeyWantsBattle

UnknownScript_0xbd3c0:
	farsjump Phone_GenericCall_Male

JoeyMondayAfternoon:
	setflag ENGINE_JOEY_MONDAY_AFTERNOON

JoeyWantsBattle:
	getlandmarkname ROUTE_30, $2
	setflag ENGINE_JOEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
