AnthonyPhoneScript1:
	gettrainername HIKER, ANTHONY1, $0
	checkflag ENGINE_ANTHONY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd65d
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftruefwd UnknownScript_0xbd653
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd653
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd AnthonyFridayNight

UnknownScript_0xbd653:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftruefwd UnknownScript_0xbd664
	farsjump AnthonyHangUpScript

UnknownScript_0xbd65d:
	getlandmarkname ROUTE_33, $2
	farsjump AnthonyReminderScript

UnknownScript_0xbd664:
	getlandmarkname ROUTE_33, $2
	farsjump AnthonyHurryScript

AnthonyPhoneScript2:
	gettrainername HIKER, ANTHONY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftruefwd UnknownScript_0xbd68d
	farscall PhoneScript_Random2
	ifequalfwd $0, AnthonyWantsBattle

UnknownScript_0xbd68d:
	farscall PhoneScript_Random5
	ifequalfwd $0, AnthonyTriesDunsparceSwarm
	farsjump Phone_GenericCall_Male

AnthonyFridayNight:
	setflag ENGINE_ANTHONY_FRIDAY_NIGHT

AnthonyWantsBattle:
	getlandmarkname ROUTE_33, $2
	setflag ENGINE_ANTHONY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

AnthonyTriesDunsparceSwarm:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftruefwd UnknownScript_0xbd6bd
	setflag ENGINE_DUNSPARCE_SWARM
	getmonname DUNSPARCE, $1
	swarm SWARM_DUNSPARCE, DARK_CAVE_VIOLET_ENTRANCE
	getlandmarkname DARK_CAVE, $2
	farsjump AnthonySwarmScript

UnknownScript_0xbd6bd:
	farsjump Phone_GenericCall_Male
