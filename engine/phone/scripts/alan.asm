AlanPhoneScript1:
	gettrainername SCHOOLBOY, ALAN1, $0
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd8cf
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd8cb
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftruefwd UnknownScript_0xbd8d6
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd8cb
	checktime 1 << DAY
	iftruefwd AlanWednesdayDay

UnknownScript_0xbd8cb:
	farsjump AlanHangUpScript

UnknownScript_0xbd8cf:
	getlandmarkname ROUTE_36, $2
	farsjump AlanReminderScript

UnknownScript_0xbd8d6:
	getlandmarkname ROUTE_36, $2
	farsjump AlanComePickUpScript

AlanPhoneScript2:
	gettrainername SCHOOLBOY, ALAN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd915
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd915
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftruefwd UnknownScript_0xbd915
	farscall PhoneScript_Random3
	ifequalfwd $0, AlanWantsBattle
	checkevent EVENT_ALAN_GAVE_FIRE_STONE
	iftruefwd UnknownScript_0xbd90d
	farscall PhoneScript_Random2
	ifequalfwd $0, AlanHasFireStone

UnknownScript_0xbd90d:
	farscall PhoneScript_Random11
	ifequalfwd $0, AlanHasFireStone

UnknownScript_0xbd915:
	farsjump Phone_GenericCall_Male

AlanWednesdayDay:
	setflag ENGINE_ALAN_WEDNESDAY_AFTERNOON

AlanWantsBattle:
	getlandmarkname ROUTE_36, $2
	setflag ENGINE_ALAN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

AlanHasFireStone:
	setflag ENGINE_ALAN_HAS_FIRE_STONE
	getlandmarkname ROUTE_36, $2
	farsjump PhoneScript_FoundItem_Male
