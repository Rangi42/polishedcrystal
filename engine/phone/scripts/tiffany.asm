TiffanyPhoneScript1:
	gettrainername PICNICKER, TIFFANY1, $0
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdbc2
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_TIFFANY_TUESDAY_AFTERNOON
	iftruefwd UnknownScript_0xbdbbe
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftruefwd UnknownScript_0xbdbc9
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbdbbe
	checktime 1 << DAY
	iftruefwd TiffanyTuesdayAfternoon

UnknownScript_0xbdbbe:
	farsjump TiffanyNoItemScript

UnknownScript_0xbdbc2:
	getlandmarkname ROUTE_43, $2
	farsjump TiffanyAsleepScript

UnknownScript_0xbdbc9:
	getlandmarkname ROUTE_43, $2
	farsjump TiffanyHurryScript

TiffanyPhoneScript2:
	gettrainername PICNICKER, TIFFANY1, $0
	farscall PhoneScript_Random4
	ifequalfwd $0, TiffanysFamilyMembers
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbdc10
	checkflag ENGINE_TIFFANY_TUESDAY_AFTERNOON
	iftruefwd UnknownScript_0xbdc10
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftruefwd UnknownScript_0xbdc10
	farscall PhoneScript_Random3
	ifequalfwd $0, TiffanyWantsBattle
	checkevent EVENT_TIFFANY_GAVE_PINK_BOW
	iftruefwd UnknownScript_0xbdc08
	farscall PhoneScript_Random2
	ifequalfwd $0, TiffanyHasPinkBow

UnknownScript_0xbdc08:
	farscall PhoneScript_Random11
	ifequalfwd $0, TiffanyHasPinkBow

UnknownScript_0xbdc10:
	farsjump Phone_GenericCall_Female

TiffanyTuesdayAfternoon:
	setflag ENGINE_TIFFANY_TUESDAY_AFTERNOON

TiffanyWantsBattle:
	getlandmarkname ROUTE_43, $2
	setflag ENGINE_TIFFANY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

TiffanysFamilyMembers:
	random $6
	ifequalfwd $0, UnknownScript_0xbdc3b
	ifequalfwd $1, UnknownScript_0xbdc42
	ifequalfwd $2, UnknownScript_0xbdc49
	ifequalfwd $3, UnknownScript_0xbdc50
	ifequalfwd $4, UnknownScript_0xbdc57
	ifequalfwd $5, UnknownScript_0xbdc5e

UnknownScript_0xbdc3b:
	getstring Phone_GrandmaString, $1
	sjumpfwd UnknownScript_0xbdc65

UnknownScript_0xbdc42:
	getstring Phone_GrandpaString, $1
	sjumpfwd UnknownScript_0xbdc65

UnknownScript_0xbdc49:
	getstring Phone_MomString, $1
	sjumpfwd UnknownScript_0xbdc65

UnknownScript_0xbdc50:
	getstring Phone_DadString, $1
	sjumpfwd UnknownScript_0xbdc65

UnknownScript_0xbdc57:
	getstring Phone_SisterString, $1
	sjumpfwd UnknownScript_0xbdc65

UnknownScript_0xbdc5e:
	getstring Phone_BrotherString, $1
	; fallthrough

UnknownScript_0xbdc65:
	farsjump TiffanyItsAwful

TiffanyHasPinkBow:
	setflag ENGINE_TIFFANY_HAS_PINK_BOW
	getlandmarkname ROUTE_43, $2
	farsjump PhoneScript_FoundItem_Female
