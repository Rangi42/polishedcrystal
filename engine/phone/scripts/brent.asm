BrentPhoneScript1:
	gettrainername POKEMANIAC, BRENT1, $0
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftruefwd .NotMonday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checktime 1 << MORN
	iftruefwd BrentMondayMorning

.NotMonday:
	farsjump BrentHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_43, $2
	farsjump BrentReminderScript

BrentPhoneScript2:
	gettrainername POKEMANIAC, BRENT1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, BrentBillTrivia
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftruefwd .Generic
	farscall PhoneScript_Random2
	ifequalfwd $0, BrentWantsBattle

.Generic:
	farsjump Phone_GenericCall_Male

BrentMondayMorning:
	setflag ENGINE_BRENT_MONDAY_MORNING

BrentWantsBattle:
	getlandmarkname ROUTE_43, $2
	setflag ENGINE_BRENT_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

BrentBillTrivia:
	farsjump BrentBillTriviaScript
