GinaPhoneScript1:
	gettrainername PICNICKER, GINA1, $0
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd776
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd768
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftruefwd UnknownScript_0xbd77d
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd768
	checktime 1 << DAY
	iftruefwd GinaSundayDay

UnknownScript_0xbd768:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd UnknownScript_0xbd772
	farsjump GinaHangUpScript

UnknownScript_0xbd772:
	farsjump GinaRocketRumorScript

UnknownScript_0xbd776:
	getlandmarkname ROUTE_34, $2
	farsjump GinaReminderScript

UnknownScript_0xbd77d:
	getlandmarkname ROUTE_34, $2
	farsjump GinaComePickUpScript

GinaPhoneScript2:
	gettrainername PICNICKER, GINA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd GinaRockets
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd7c8
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd7c8
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftruefwd UnknownScript_0xbd7c8
	checkevent EVENT_GINA_GAVE_LEAF_STONE
	iftruefwd UnknownScript_0xbd7b2
	farscall PhoneScript_Random2
	ifequalfwd $0, GinaHasLeafStone

UnknownScript_0xbd7b2:
	farscall PhoneScript_Random11
	ifequalfwd $0, GinaHasLeafStone
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd UnknownScript_0xbd7c8
	farscall PhoneScript_Random3
	ifequalfwd $0, GinaWantsBattle

UnknownScript_0xbd7c8:
	farsjump Phone_GenericCall_Female

GinaSundayDay:
	setflag ENGINE_GINA_SUNDAY_AFTERNOON

GinaWantsBattle:
	getlandmarkname ROUTE_34, $2
	setflag ENGINE_GINA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

GinaRockets:
	farsjump GinaRocketRumorScript

GinaHasLeafStone:
	setflag ENGINE_GINA_HAS_LEAF_STONE
	getlandmarkname ROUTE_34, $2
	farsjump PhoneScript_FoundItem_Female
