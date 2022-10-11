ChadPhoneScript1:
	gettrainername SCHOOLBOY, CHAD1, $0
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd9e9
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftruefwd UnknownScript_0xbd9e5
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd9e5
	checktime 1 << MORN
	iftruefwd ChadFridayMorning

UnknownScript_0xbd9e5:
	farsjump ChadHangUpScript

UnknownScript_0xbd9e9:
	getlandmarkname ROUTE_38, $2
	farsjump ChadReminderScript

ChadPhoneScript2:
	gettrainername SCHOOLBOY, CHAD1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, ChadOakGossip
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbda14
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftruefwd UnknownScript_0xbda14
	farscall PhoneScript_Random2
	ifequalfwd $0, ChadWantsBattle

UnknownScript_0xbda14:
	farscall PhoneScript_Random3
	ifequalfwd $0, ChadFoundRare
	farsjump Phone_GenericCall_Male

ChadFridayMorning:
	setflag ENGINE_CHAD_FRIDAY_MORNING

ChadWantsBattle:
	getlandmarkname ROUTE_38, $2
	setflag ENGINE_CHAD_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ChadFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ChadOakGossip:
	farsjump ChadOakGossipScript
