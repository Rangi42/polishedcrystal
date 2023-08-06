GinaPhoneScript1:
	gettrainername PICNICKER, GINA1, $0
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftruefwd .NotSunday
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftruefwd .HasLeafStone
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, .NotSunday
	checktime 1 << DAY
	iftruefwd GinaSundayDay

.NotSunday:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd .Rockets
	farsjump GinaHangUpScript

.Rockets:
	farsjump GinaRocketRumorScript

.WantsBattle:
	getlandmarkname ROUTE_34, $2
	farsjump GinaReminderScript

.HasLeafStone:
	getlandmarkname ROUTE_34, $2
	farsjump GinaComePickUpScript

GinaPhoneScript2:
	gettrainername PICNICKER, GINA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd GinaRockets
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftruefwd .Generic
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftruefwd .Generic
	checkevent EVENT_GINA_GAVE_LEAF_STONE
	iftruefwd .GaveLeafStone
	farscall PhoneScript_Random2
	ifequalfwd $0, GinaHasLeafStone

.GaveLeafStone:
	farscall PhoneScript_Random11
	ifequalfwd $0, GinaHasLeafStone
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, GinaWantsBattle

.Generic:
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
