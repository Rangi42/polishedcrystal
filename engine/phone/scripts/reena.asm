ReenaPhoneScript1:
	gettrainername COOLTRAINERF, REENA1, $0
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftruefwd .NotSunday
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, .NotSunday
	checktime 1 << MORN
	iftruefwd ReenaSundayMorning

.NotSunday:
	farsjump ReenaForwardScript

.WantsBattle:
	getlandmarkname ROUTE_27, $2
	farsjump ReenaHurryScript

ReenaPhoneScript2:
	gettrainername COOLTRAINERF, REENA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftruefwd .Generic
	farscall PhoneScript_Random2
	ifequalfwd $0, ReenaWantsBattle

.Generic:
	farsjump Phone_GenericCall_Female

ReenaSundayMorning:
	setflag ENGINE_REENA_SUNDAY_MORNING

ReenaWantsBattle:
	getlandmarkname ROUTE_27, $2
	setflag ENGINE_REENA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
