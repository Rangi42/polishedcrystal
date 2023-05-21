AlanPhoneScript1:
	gettrainername SCHOOLBOY, ALAN1, $0
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftruefwd .NotWednesday
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftruefwd .FireStone
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, .NotWednesday
	checktime 1 << DAY
	iftruefwd AlanWednesdayDay

.NotWednesday:
	farsjump AlanHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_36, $2
	farsjump AlanReminderScript

.FireStone:
	getlandmarkname ROUTE_36, $2
	farsjump AlanComePickUpScript

AlanPhoneScript2:
	gettrainername SCHOOLBOY, ALAN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftruefwd .Generic
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftruefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, AlanWantsBattle
	checkevent EVENT_ALAN_GAVE_FIRE_STONE
	iftruefwd .FireStone
	farscall PhoneScript_Random2
	ifequalfwd $0, AlanHasFireStone

.FireStone:
	farscall PhoneScript_Random11
	ifequalfwd $0, AlanHasFireStone

.Generic:
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
