BeverlyPhoneScript1:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd UnknownScript_0xbd151
	farsjump BeverlyHangUpScript

UnknownScript_0xbd151:
	getlandmarkname NATIONAL_PARK, $2
	farsjump BeverlyComePickUpScript

BeverlyPhoneScript2:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd UnknownScript_0xbd16e
	farscall PhoneScript_Random4
	ifequalfwd $0, UnknownScript_0xbd172

UnknownScript_0xbd16e:
	farsjump Phone_GenericCall_Female

UnknownScript_0xbd172:
	setflag ENGINE_BEVERLY_HAS_NUGGET
	getlandmarkname NATIONAL_PARK, $2
	farsjump PhoneScript_FoundItem_Female
