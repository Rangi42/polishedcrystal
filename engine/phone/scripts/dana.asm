DanaPhoneScript1:
	gettrainername LASS, DANA1, $0
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftruefwd .NotThursday
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftruefwd .HasThunderstone
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, .NotThursday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd DanaThursdayNight

.NotThursday:
	farsjump DanaHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_38, $2
	farsjump DanaReminderScript

.HasThunderstone:
	getlandmarkname ROUTE_38, $2
	farsjump DanaComePickUpScript

DanaPhoneScript2:
	gettrainername LASS, DANA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftruefwd .Generic
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftruefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, DanaWantsBattle
	checkevent EVENT_DANA_GAVE_THUNDERSTONE
	iftruefwd .Thunderstone
	farscall PhoneScript_Random2
	ifequalfwd $0, DanaHasThunderstone

.Thunderstone:
	farscall PhoneScript_Random11
	ifequalfwd $0, DanaHasThunderstone

.Generic:
	farscall PhoneScript_Random3
	ifequalfwd $0, DanaFoundRare
	farsjump Phone_GenericCall_Female

DanaThursdayNight:
	setflag ENGINE_DANA_THURSDAY_NIGHT

DanaWantsBattle:
	getlandmarkname ROUTE_38, $2
	setflag ENGINE_DANA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

DanaFoundRare:
	farsjump Phone_CheckIfUnseenRare_Female

DanaHasThunderstone:
	setflag ENGINE_DANA_HAS_THUNDERSTONE
	getlandmarkname ROUTE_38, $2
	farsjump PhoneScript_FoundItem_Female
