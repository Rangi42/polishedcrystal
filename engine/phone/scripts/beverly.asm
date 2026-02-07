BeverlyPhoneScript1:
	gettrainername POKEFANF, BEVERLY1, STRING_BUFFER_3
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd .HasNugget
	farsjump BeverlyHangUpScript

.HasNugget:
	getlandmarkname NATIONAL_PARK, STRING_BUFFER_5
	farsjump BeverlyComePickUpScript

BeverlyPhoneScript2:
	gettrainername POKEFANF, BEVERLY1, STRING_BUFFER_3
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd .HasNugget
	farscall PhoneScript_Random4
	ifequalfwd $0, .FoundNugget

.HasNugget:
	farsjump Phone_GenericCall_Female

.FoundNugget:
	setflag ENGINE_BEVERLY_HAS_NUGGET
	getlandmarkname NATIONAL_PARK, STRING_BUFFER_5
	farsjump PhoneScript_FoundItem_Female
