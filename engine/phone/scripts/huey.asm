HueyPhoneScript1:
	gettrainername SAILOR, HUEY1, $0
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftruefwd .NotWednesday
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, .NotWednesday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd HueyWednesdayNight

.NotWednesday:
	special RandomPhoneMon
	farsjump HueyHangUpScript

.WantsBattle:
	getlandmarkname LIGHTHOUSE, $2
	farsjump HueyWantsBattleScript

HueyPhoneScript2:
	gettrainername SAILOR, HUEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftruefwd .Flavor
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftruefwd .Flavor
	farscall PhoneScript_Random3
	ifequalfwd $0, HueyWantsBattle
	ifequalfwd $1, HueyWantsBattle

.Flavor:
	farsjump PhoneScript_MonFlavorText

HueyWednesdayNight:
	setflag ENGINE_HUEY_WEDNESDAY_NIGHT

HueyWantsBattle:
	getlandmarkname LIGHTHOUSE, $2
	setflag ENGINE_HUEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male
