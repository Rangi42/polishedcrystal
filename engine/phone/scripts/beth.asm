BethPhoneScript1:
	gettrainername COOLTRAINERF, BETH1, $0
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd260
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd25c
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd25c
	checktime 1 << DAY
	iftruefwd BethFridayAfternoon

UnknownScript_0xbd25c:
	farsjump BethHangUpScript

UnknownScript_0xbd260:
	getlandmarkname ROUTE_26, $2
	farsjump BethBattleReminderScript

BethPhoneScript2:
	gettrainername COOLTRAINERF, BETH1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd283
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd283
	farscall PhoneScript_Random2
	ifequalfwd $0, BethWantsBattle

UnknownScript_0xbd283:
	farsjump Phone_GenericCall_Female

BethFridayAfternoon:
	setflag ENGINE_BETH_FRIDAY_AFTERNOON

BethWantsBattle:
	getlandmarkname ROUTE_26, $2
	setflag ENGINE_BETH_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female
