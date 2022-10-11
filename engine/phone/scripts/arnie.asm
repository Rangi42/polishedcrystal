ArniePhoneScript1:
	gettrainername BUG_CATCHER, ARNIE1, $0
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd83c
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ARNIE_TUESDAY_MORNING
	iftruefwd UnknownScript_0xbd832
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd832
	checktime 1 << MORN
	iftruefwd ArnieTuesdayMorning

UnknownScript_0xbd832:
	checkflag ENGINE_YANMA_SWARM
	iftruefwd UnknownScript_0xbd843
	farsjump ArnieHangUpScript

UnknownScript_0xbd83c:
	getlandmarkname ROUTE_35, $2
	farsjump ArnieReminderScript

UnknownScript_0xbd843:
	getlandmarkname ROUTE_35, $2
	farsjump ArnieHurryScript

ArniePhoneScript2:
	gettrainername BUG_CATCHER, ARNIE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd866
	checkflag ENGINE_ARNIE_TUESDAY_MORNING
	iftruefwd UnknownScript_0xbd866
	farscall PhoneScript_Random2
	ifequalfwd $0, ArnieWantsBattle

UnknownScript_0xbd866:
	farscall PhoneScript_Random5
	ifequalfwd $0, ArnieYanmaSwarm
	farscall PhoneScript_Random3
	ifequalfwd $0, ArnieFoundRare
	farsjump Phone_GenericCall_Male

ArnieTuesdayMorning:
	setflag ENGINE_ARNIE_TUESDAY_MORNING

ArnieWantsBattle:
	getlandmarkname ROUTE_35, $2
	setflag ENGINE_ARNIE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ArnieYanmaSwarm: ; start swarm
	checkflag ENGINE_YANMA_SWARM
	iftruefwd ArnieYanmaAlreadySwarming
	setflag ENGINE_YANMA_SWARM
	getmonname YANMA, $1
	swarm SWARM_YANMA, ROUTE_35
	getlandmarkname ROUTE_35, $2
	farsjump ArnieSwarmScript

ArnieFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ArnieYanmaAlreadySwarming:
	farsjump Phone_GenericCall_Male
