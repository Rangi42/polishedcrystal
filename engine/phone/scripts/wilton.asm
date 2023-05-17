WiltonPhoneScript1:
	gettrainername FISHER, WILTON1, $0
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftruefwd .NotThursday
	checkflag ENGINE_WILTON_HAS_ITEM
	iftruefwd .HasItem
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, .NotThursday
	checktime 1 << MORN
	iftruefwd WiltonThursdayMorning

.NotThursday:
	farsjump WiltonHaventFoundAnythingScript

.WantsBattle:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonNotBitingScript

.HasItem:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonWantThisScript

WiltonPhoneScript2:
	gettrainername FISHER, WILTON1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftruefwd .GenericCall
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftruefwd .GenericCall
	checkflag ENGINE_WILTON_HAS_ITEM
	iftruefwd .GenericCall
	farscall PhoneScript_Random2
	ifequalfwd $0, WiltonWantsBattle
	farscall PhoneScript_Random2
	ifequalfwd $0, WiltonHasItem

.GenericCall:
	farsjump Phone_GenericCall_Male

WiltonThursdayMorning:
	setflag ENGINE_WILTON_THRUSDAY_MORNING

WiltonWantsBattle:
	getlandmarkname ROUTE_44, $2
	setflag ENGINE_WILTON_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WiltonHasItem:
	setflag ENGINE_WILTON_HAS_ITEM
	getlandmarkname ROUTE_44, $2
	clearevent EVENT_WILTON_HAS_ULTRA_BALL
	clearevent EVENT_WILTON_HAS_GREAT_BALL
	clearevent EVENT_WILTON_HAS_POKE_BALL
	random $5
	ifequalfwd $0, .UltraBall
	random $3
	ifequalfwd $0, .GreatBall
	sjumpfwd .PokeBall

.UltraBall:
	setevent EVENT_WILTON_HAS_ULTRA_BALL
	sjumpfwd .FoundItem

.GreatBall:
	setevent EVENT_WILTON_HAS_GREAT_BALL
	sjumpfwd .FoundItem

.PokeBall:
	setevent EVENT_WILTON_HAS_POKE_BALL

.FoundItem:
	farsjump PhoneScript_FoundItem_Male
