JoeyPhoneScript1:
	gettrainername YOUNGSTER, JOEY1, $0
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftruefwd .NotMonday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checktime 1 << DAY
	iftruefwd JoeyMondayAfternoon

.NotMonday:
	special RandomPhoneMon
	farwritetext JoeyDevisingStrategiesText
	promptbutton
	farsjump PhoneScript_HangupText_Male

.WantsBattle:
	getlandmarkname ROUTE_30, $2
	farsjump JoeyReminderScript

JoeyPhoneScript2:
	gettrainername YOUNGSTER, JOEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftruefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, JoeyWantsBattle
	ifequalfwd $1, JoeyWantsBattle

.Generic:
	farsjump Phone_GenericCall_Male

JoeyMondayAfternoon:
	setflag ENGINE_JOEY_MONDAY_AFTERNOON

JoeyWantsBattle:
	getlandmarkname ROUTE_30, $2
	setflag ENGINE_JOEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
