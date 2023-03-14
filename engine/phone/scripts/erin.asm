ErinPhoneScript1:
	gettrainername PICNICKER, ERIN1, $0
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftruefwd .NotSaturday
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, .NotSaturday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd ErinSaturdayNight

.NotSaturday:
	farsjump ErinWorkingHardScript

.WantsBattle:
	getlandmarkname ROUTE_46, $2
	farsjump ErinComeBattleScript

ErinPhoneScript2:
	gettrainername PICNICKER, ERIN1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftruefwd .GenericCall
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftruefwd .GenericCall
	farscall PhoneScript_Random3
	ifequalfwd $0, ErinWantsBattle
	ifequalfwd $1, ErinWantsBattle

.GenericCall:
	farsjump Phone_GenericCall_Female

ErinSaturdayNight:
	setflag ENGINE_ERIN_SATURDAY_NIGHT

ErinWantsBattle:
	getlandmarkname ROUTE_46, $2
	setflag ENGINE_ERIN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
