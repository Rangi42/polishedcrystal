ReenaPhoneScript1:
	gettrainername COOLTRAINERF, REENA1, $0
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd33f
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftruefwd UnknownScript_0xbd33b
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd33b
	checktime 1 << MORN
	iftruefwd ReenaSundayMorning

UnknownScript_0xbd33b:
	farsjump ReenaForwardScript

UnknownScript_0xbd33f:
	getlandmarkname ROUTE_27, $2
	farsjump ReenaHurryScript

ReenaPhoneScript2:
	gettrainername COOLTRAINERF, REENA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd362
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftruefwd UnknownScript_0xbd362
	farscall PhoneScript_Random2
	ifequalfwd $0, ReenaWantsBattle

UnknownScript_0xbd362:
	farsjump Phone_GenericCall_Female

ReenaSundayMorning:
	setflag ENGINE_REENA_SUNDAY_MORNING

ReenaWantsBattle:
	getlandmarkname ROUTE_27, $2
	setflag ENGINE_REENA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
