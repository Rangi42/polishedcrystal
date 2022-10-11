ToddPhoneScript1:
	gettrainername CAMPER, TODD1, $0
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd6ea
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftruefwd UnknownScript_0xbd6e0
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd6e0
	checktime 1 << MORN
	iftruefwd ToddSaturdayMorning

UnknownScript_0xbd6e0:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftruefwd UnknownScript_0xbd6f1
	farsjump ToddNoItemScript

UnknownScript_0xbd6ea:
	getlandmarkname ROUTE_34, $2
	farsjump ToddForwardScript

UnknownScript_0xbd6f1:
	farsjump ToddHurryScript

ToddPhoneScript2:
	gettrainername CAMPER, TODD1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd717
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftruefwd UnknownScript_0xbd717
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd UnknownScript_0xbd71f
	farscall PhoneScript_Random2
	ifequalfwd $0, ToddWantsBattle

UnknownScript_0xbd717:
	farscall PhoneScript_Random2
	ifequalfwd $0, ToddDeptStoreSale

UnknownScript_0xbd71f:
	farscall PhoneScript_Random3
	ifequalfwd $0, ToddFoundRare
	farsjump Phone_GenericCall_Male

ToddSaturdayMorning:
	setflag ENGINE_TODD_SATURDAY_MORNING

ToddWantsBattle:
	getlandmarkname ROUTE_34, $2
	setflag ENGINE_TODD_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ToddFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ToddDeptStoreSale:
	setflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	farsjump ToddItemScript
