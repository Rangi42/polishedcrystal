TullyPhoneScript1:
	gettrainername FISHER, TULLY1, $0
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftruefwd .NotSunday
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftruefwd .WaterStone
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, .NotSunday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd TullySundayNight

.NotSunday:
	farsjump TullyNoItemScript

.WantsBattle:
	getlandmarkname ROUTE_42, $2
	farsjump TullyForwardScript

.WaterStone:
	getlandmarkname ROUTE_42, $2
	farsjump TullyHurryScript

TullyPhoneScript2:
	gettrainername FISHER, TULLY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftruefwd .Generic
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftruefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, TullyWantsBattle
	checkevent EVENT_TULLY_GAVE_WATER_STONE
	iftruefwd .WaterStone
	farscall PhoneScript_Random2
	ifequalfwd $0, TullyFoundWaterStone

.WaterStone:
	farscall PhoneScript_Random11
	ifequalfwd $0, TullyFoundWaterStone

.Generic:
	farsjump Phone_GenericCall_Male

TullySundayNight:
	setflag ENGINE_TULLY_SUNDAY_NIGHT

TullyWantsBattle:
	getlandmarkname ROUTE_42, $2
	setflag ENGINE_TULLY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

TullyFoundWaterStone:
	setflag ENGINE_TULLY_HAS_WATER_STONE
	getlandmarkname ROUTE_42, $2
	farsjump PhoneScript_FoundItem_Male
