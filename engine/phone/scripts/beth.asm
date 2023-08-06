BethPhoneScript1:
	gettrainername COOLTRAINERF, BETH1, $0
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftruefwd .NotFriday
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	checktime 1 << DAY
	iftruefwd BethFridayAfternoon

.NotFriday:
	farsjump BethHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_26, $2
	farsjump BethBattleReminderScript

BethPhoneScript2:
	gettrainername COOLTRAINERF, BETH1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftruefwd .Generic
	farscall PhoneScript_Random2
	ifequalfwd $0, BethWantsBattle

.Generic:
	farsjump Phone_GenericCall_Female

BethFridayAfternoon:
	setflag ENGINE_BETH_FRIDAY_AFTERNOON

BethWantsBattle:
	getlandmarkname ROUTE_26, $2
	setflag ENGINE_BETH_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
