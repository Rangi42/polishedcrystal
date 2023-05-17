ToddPhoneScript1:
	gettrainername CAMPER, TODD1, $0
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftruefwd .NotSaturday
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, .NotSaturday
	checktime 1 << MORN
	iftruefwd ToddSaturdayMorning

.NotSaturday:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftruefwd .SaleOn
	farsjump ToddNoItemScript

.WantsBattle:
	getlandmarkname ROUTE_34, $2
	farsjump ToddForwardScript

.SaleOn:
	farsjump ToddHurryScript

ToddPhoneScript2:
	gettrainername CAMPER, TODD1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftruefwd .TryForSale
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftruefwd .TryForSale
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd .NoGoldenrod
	farscall PhoneScript_Random2
	ifequalfwd $0, ToddWantsBattle

.TryForSale:
	farscall PhoneScript_Random2
	ifequalfwd $0, ToddDeptStoreSale

.NoGoldenrod:
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
