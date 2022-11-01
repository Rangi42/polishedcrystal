DerekPhoneScript1:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftruefwd UnknownScript_0xbda67
	farscall PhoneScript_Random2
	ifequalfwd $0, UnknownScript_0xbda5f
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd UnknownScript_0xbda5f
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, UnknownScript_0xbda63
	ifequalfwd THURSDAY, UnknownScript_0xbda63
	ifequalfwd SATURDAY, UnknownScript_0xbda63

UnknownScript_0xbda5f:
	farsjump DerekHangUpScript

UnknownScript_0xbda63:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbda67:
	getlandmarkname ROUTE_39, $2
	farsjump DerekComePickUpScript

DerekPhoneScript2:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, UnknownScript_0xbda92
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd UnknownScript_0xbda92
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, UnknownScript_0xbda9e
	ifequalfwd THURSDAY, UnknownScript_0xbda9e
	ifequalfwd SATURDAY, UnknownScript_0xbda9e

UnknownScript_0xbda92:
	farscall PhoneScript_Random4
	ifequalfwd $0, UnknownScript_0xbdaa2
	farsjump Phone_GenericCall_Male

UnknownScript_0xbda9e:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbdaa2:
	setflag ENGINE_DEREK_HAS_NUGGET
	getlandmarkname ROUTE_39, $2
	farsjump PhoneScript_FoundItem_Male
