JosePhoneScript1:
	gettrainername BIRD_KEEPER, JOSE2, $0
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftruefwd .NotSaturday
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftruefwd .HasItem
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, .NotSaturday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd JoseSaturdayNight

.NotSaturday:
	farsjump JoseHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

.HasItem:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

JosePhoneScript2:
	gettrainername BIRD_KEEPER, JOSE2, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftruefwd .Generic
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftruefwd .Generic
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftruefwd .Generic
	farscall PhoneScript_Random3
	ifequalfwd $0, JoseWantsBattle
	farscall PhoneScript_Random3
	ifequalfwd $0, JoseHasStarPiece

.Generic:
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
