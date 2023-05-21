JackPhoneScript1:
	gettrainername SCHOOLBOY, JACK1, $0
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftruefwd .NotMonday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checktime 1 << MORN
	iftruefwd JackMondayMorning

.NotMonday:
	farsjump JackPhoneTipsScript

.WantsBattle:
	getlandmarkname NATIONAL_PARK, $2
	farsjump JackWantsBattleScript

JackPhoneScript2:
	gettrainername SCHOOLBOY, JACK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, JackBattleTrivia
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftruefwd .WaitingForBattle
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftruefwd .WaitingForBattle
	farscall PhoneScript_Random2
	ifequalfwd $0, JackWantsToBattle

.WaitingForBattle:
	farscall PhoneScript_Random3
	ifequalfwd $0, JackFindsRare
	farsjump Phone_GenericCall_Male

JackMondayMorning:
	setflag ENGINE_JACK_MONDAY_MORNING

JackWantsToBattle:
	getlandmarkname NATIONAL_PARK, $2
	setflag ENGINE_JACK_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

JackFindsRare:
	farsjump Phone_CheckIfUnseenRare_Male

JackBattleTrivia:
	farsjump JackTriviaScript
