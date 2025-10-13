VancePhoneScript1:
	gettrainername BIRD_KEEPER, VANCE1, STRING_BUFFER_3
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftruefwd .NotWednesday
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, .NotWednesday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd VanceWednesdayNight

.NotWednesday:
	farsjump VanceLookingForwardScript

.WantsBattle:
	getlandmarkname ROUTE_44, STRING_BUFFER_5
	farsjump VanceHurryHurryScript

VancePhoneScript2:
	gettrainername BIRD_KEEPER, VANCE1, STRING_BUFFER_3
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftruefwd .WantsBattle
	farscall PhoneScript_Random3
	ifequalfwd $0, VanceWantsRematch
	ifequalfwd $1, VanceWantsRematch

.WantsBattle:
	farsjump Phone_GenericCall_Male

VanceWednesdayNight:
	setflag ENGINE_VANCE_WEDNESDAY_NIGHT

VanceWantsRematch:
	getlandmarkname ROUTE_44, STRING_BUFFER_5
	setflag ENGINE_VANCE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
