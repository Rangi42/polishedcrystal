WiltonPhoneScript1:
	gettrainername FISHER, WILTON1, $0
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdcf7
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftruefwd UnknownScript_0xbdcf3
	checkflag ENGINE_WILTON_HAS_ITEM
	iftruefwd UnknownScript_0xbdcfe
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbdcf3
	checktime 1 << MORN
	iftruefwd WiltonThursdayMorning

UnknownScript_0xbdcf3:
	farsjump WiltonHaventFoundAnythingScript

UnknownScript_0xbdcf7:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonNotBitingScript

UnknownScript_0xbdcfe:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonWantThisScript

WiltonPhoneScript2:
	gettrainername FISHER, WILTON1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdd2f
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftruefwd UnknownScript_0xbdd2f
	checkflag ENGINE_WILTON_HAS_ITEM
	iftruefwd UnknownScript_0xbdd2f
	farscall PhoneScript_Random2
	ifequalfwd $0, WiltonWantsBattle
	farscall PhoneScript_Random2
	ifequalfwd $0, WiltonHasItem

UnknownScript_0xbdd2f:
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
	ifequalfwd $0, UnknownScript_0xbdd5e
	random $3
	ifequalfwd $0, UnknownScript_0xbdd64
	sjumpfwd UnknownScript_0xbdd6a

UnknownScript_0xbdd5e:
	setevent EVENT_WILTON_HAS_ULTRA_BALL
	sjumpfwd UnknownScript_0xbdd6d

UnknownScript_0xbdd64:
	setevent EVENT_WILTON_HAS_GREAT_BALL
	sjumpfwd UnknownScript_0xbdd6d

UnknownScript_0xbdd6a:
	setevent EVENT_WILTON_HAS_POKE_BALL

UnknownScript_0xbdd6d:
	farsjump PhoneScript_FoundItem_Male
