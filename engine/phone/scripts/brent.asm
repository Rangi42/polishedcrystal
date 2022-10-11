BrentPhoneScript1:
	gettrainername POKEMANIAC, BRENT1, $0
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdb59
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftruefwd UnknownScript_0xbdb55
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbdb55
	checktime 1 << MORN
	iftruefwd BrentMondayMorning

UnknownScript_0xbdb55:
	farsjump BrentHangUpScript

UnknownScript_0xbdb59:
	getlandmarkname ROUTE_43, $2
	farsjump BrentReminderScript

BrentPhoneScript2:
	gettrainername POKEMANIAC, BRENT1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, BrentBillTrivia
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdb84
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftruefwd UnknownScript_0xbdb84
	farscall PhoneScript_Random2
	ifequalfwd $0, BrentWantsBattle

UnknownScript_0xbdb84:
	farsjump Phone_GenericCall_Male

BrentMondayMorning:
	setflag ENGINE_BRENT_MONDAY_MORNING

BrentWantsBattle:
	getlandmarkname ROUTE_43, $2
	setflag ENGINE_BRENT_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

BrentBillTrivia:
	farsjump BrentBillTriviaScript
