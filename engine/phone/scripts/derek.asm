DerekPhoneScript1:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftruefwd .Nugget
	farscall PhoneScript_Random2
	ifequalfwd $0, .NoContest
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd .NoContest
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .ContestToday
	ifequalfwd THURSDAY, .ContestToday
	ifequalfwd SATURDAY, .ContestToday

.NoContest:
	farsjump DerekHangUpScript

.ContestToday:
	farsjump PhoneScript_BugCatchingContest

.Nugget:
	getlandmarkname ROUTE_39, $2
	farsjump DerekComePickUpScript

DerekPhoneScript2:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequalfwd $0, .NoContest
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftruefwd .NoContest
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .ContestToday
	ifequalfwd THURSDAY, .ContestToday
	ifequalfwd SATURDAY, .ContestToday

.NoContest:
	farscall PhoneScript_Random4
	ifequalfwd $0, .Nugget
	farsjump Phone_GenericCall_Male

.ContestToday:
	farsjump PhoneScript_BugCatchingContest

.Nugget:
	setflag ENGINE_DEREK_HAS_NUGGET
	getlandmarkname ROUTE_39, $2
	farsjump PhoneScript_FoundItem_Male
