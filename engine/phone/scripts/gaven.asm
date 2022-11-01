GavenPhoneScript1:
	gettrainername COOLTRAINERM, GAVEN1, $0
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd1fd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftruefwd UnknownScript_0xbd1f9
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd1f9
	checktime 1 << MORN
	iftruefwd GavenThursdayMorningScript

UnknownScript_0xbd1f9:
	farsjump GavenHangUpNotThursdayScript

UnknownScript_0xbd1fd:
	getlandmarkname ROUTE_26, $2
	farsjump GavenReminderScript

GavenPhoneScript2:
	gettrainername COOLTRAINERM, GAVEN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd220
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftruefwd UnknownScript_0xbd220
	farscall PhoneScript_Random2
	ifequalfwd $0, GavenWantsRematch

UnknownScript_0xbd220:
	farscall PhoneScript_Random3
	ifequalfwd $0, GavenFoundRare
	farsjump Phone_GenericCall_Male

GavenThursdayMorningScript:
	setflag ENGINE_GAVEN_THURSDAY_MORNING

GavenWantsRematch:
	getlandmarkname ROUTE_26, $2
	setflag ENGINE_GAVEN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

GavenFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male
