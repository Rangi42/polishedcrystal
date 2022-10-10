VancePhoneScript1:
	gettrainername BIRD_KEEPER, VANCE1, $0
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdc96
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftruefwd UnknownScript_0xbdc92
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbdc92
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd VanceWednesdayNight

UnknownScript_0xbdc92:
	farsjump VanceLookingForwardScript

UnknownScript_0xbdc96:
	getlandmarkname ROUTE_44, $2
	farsjump VanceHurryHurryScript

VancePhoneScript2:
	gettrainername BIRD_KEEPER, VANCE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdcbd
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftruefwd UnknownScript_0xbdcbd
	farscall PhoneScript_Random3
	ifequalfwd $0, VanceWantsRematch
	ifequalfwd $1, VanceWantsRematch

UnknownScript_0xbdcbd:
	farsjump Phone_GenericCall_Male

VanceWednesdayNight:
	setflag ENGINE_VANCE_WEDNESDAY_NIGHT

VanceWantsRematch:
	getlandmarkname ROUTE_44, $2
	setflag ENGINE_VANCE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
