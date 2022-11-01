ErinPhoneScript1:
	gettrainername PICNICKER, ERIN1, $0
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbde07
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftruefwd UnknownScript_0xbde03
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbde03
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd ErinSaturdayNight

UnknownScript_0xbde03:
	farsjump ErinWorkingHardScript

UnknownScript_0xbde07:
	getlandmarkname ROUTE_46, $2
	farsjump ErinComeBattleScript

ErinPhoneScript2:
	gettrainername PICNICKER, ERIN1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbde2e
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftruefwd UnknownScript_0xbde2e
	farscall PhoneScript_Random3
	ifequalfwd $0, ErinWantsBattle
	ifequalfwd $1, ErinWantsBattle

UnknownScript_0xbde2e:
	farsjump Phone_GenericCall_Female

ErinSaturdayNight:
	setflag ENGINE_ERIN_SATURDAY_NIGHT

ErinWantsBattle:
	getlandmarkname ROUTE_46, $2
	setflag ENGINE_ERIN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
