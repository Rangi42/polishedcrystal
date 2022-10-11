JosePhoneScript1:
	gettrainername BIRD_KEEPER, JOSE2, $0
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd2bd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftruefwd UnknownScript_0xbd2b9
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftruefwd UnknownScript_0xbd2c4
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd2b9
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd JoseSaturdayNight

UnknownScript_0xbd2b9:
	farsjump JoseHangUpScript

UnknownScript_0xbd2bd:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

UnknownScript_0xbd2c4:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

JosePhoneScript2:
	gettrainername BIRD_KEEPER, JOSE2, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd2f5
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftruefwd UnknownScript_0xbd2f5
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftruefwd UnknownScript_0xbd2f5
	farscall PhoneScript_Random3
	ifequalfwd $0, JoseWantsBattle
	farscall PhoneScript_Random3
	ifequalfwd $0, JoseHasStarPiece

UnknownScript_0xbd2f5:
	farscall PhoneScript_Random3
	ifequalfwd $0, JoseFoundRare
	farsjump Phone_GenericCall_Male

JoseSaturdayNight:
	setflag ENGINE_JOSE_SATURDAY_NIGHT

JoseWantsBattle:
	getlandmarkname ROUTE_27, $2
	setflag ENGINE_JOSE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

JoseFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

JoseHasStarPiece:
	setflag ENGINE_JOSE_HAS_STAR_PIECE
	getlandmarkname ROUTE_27, $2
	farsjump PhoneScript_FoundItem_Male
