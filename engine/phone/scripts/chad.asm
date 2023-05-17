ChadPhoneScript1:
	gettrainername SCHOOLBOY, CHAD1, $0
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftruefwd .NotFriday
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	checktime 1 << MORN
	iftruefwd ChadFridayMorning

.NotFriday:
	farsjump ChadHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_38, $2
	farsjump ChadReminderScript

ChadPhoneScript2:
	gettrainername SCHOOLBOY, CHAD1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, ChadOakGossip
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftruefwd .Generic
	farscall PhoneScript_Random2
	ifequalfwd $0, ChadWantsBattle

.Generic:
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
