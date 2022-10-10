DanaPhoneScript1:
	gettrainername LASS, DANA1, $0
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd959
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftruefwd UnknownScript_0xbd955
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftruefwd UnknownScript_0xbd960
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd955
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd DanaThursdayNight

UnknownScript_0xbd955:
	farsjump DanaHangUpScript

UnknownScript_0xbd959:
	getlandmarkname ROUTE_38, $2
	farsjump DanaReminderScript

UnknownScript_0xbd960:
	getlandmarkname ROUTE_38, $2
	farsjump DanaComePickUpScript

DanaPhoneScript2:
	gettrainername LASS, DANA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd99f
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftruefwd UnknownScript_0xbd99f
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftruefwd UnknownScript_0xbd99f
	farscall PhoneScript_Random3
	ifequalfwd $0, DanaWantsBattle
	checkevent EVENT_DANA_GAVE_THUNDERSTONE
	iftruefwd UnknownScript_0xbd997
	farscall PhoneScript_Random2
	ifequalfwd $0, DanaHasThunderstone

UnknownScript_0xbd997:
	farscall PhoneScript_Random11
	ifequalfwd $0, DanaHasThunderstone

UnknownScript_0xbd99f:
	farscall PhoneScript_Random3
	ifequalfwd $0, DanaFoundRare
	farsjump Phone_GenericCall_Female

DanaThursdayNight:
	setflag ENGINE_DANA_THURSDAY_NIGHT

DanaWantsBattle:
	getlandmarkname ROUTE_38, $2
	setflag ENGINE_DANA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

DanaFoundRare:
	farsjump Phone_CheckIfUnseenRare_Female

DanaHasThunderstone:
	setflag ENGINE_DANA_HAS_THUNDERSTONE
	getlandmarkname ROUTE_38, $2
	farsjump PhoneScript_FoundItem_Female
