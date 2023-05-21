GavenPhoneScript1:
	gettrainername COOLTRAINERM, GAVEN1, $0
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftruefwd .NotThursday
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, .NotThursday
	checktime 1 << MORN
	iftruefwd GavenThursdayMorningScript

.NotThursday:
	farsjump GavenHangUpNotThursdayScript

.WantsBattle:
	getlandmarkname ROUTE_26, $2
	farsjump GavenReminderScript

GavenPhoneScript2:
	gettrainername COOLTRAINERM, GAVEN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftruefwd .WaitingForBattle
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftruefwd .WaitingForBattle
	farscall PhoneScript_Random2
	ifequalfwd $0, GavenWantsRematch

.WaitingForBattle:
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
