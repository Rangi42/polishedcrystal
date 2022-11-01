JackPhoneScript1:
	gettrainername SCHOOLBOY, JACK1, $0
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd0f3
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftruefwd UnknownScript_0xbd0ef
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd0ef
	checktime 1 << MORN
	iftruefwd JackMondayMorning

UnknownScript_0xbd0ef:
	farsjump JackPhoneTipsScript

UnknownScript_0xbd0f3:
	getlandmarkname NATIONAL_PARK, $2
	farsjump JackWantsBattleScript

JackPhoneScript2:
	gettrainername SCHOOLBOY, JACK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, JackBattleTrivia
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd11e
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftruefwd UnknownScript_0xbd11e
	farscall PhoneScript_Random2
	ifequalfwd $0, JackWantsToBattle

UnknownScript_0xbd11e:
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
