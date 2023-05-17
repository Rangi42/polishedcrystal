BeverlyPhoneScript1:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd .HasNugget
	farsjump BeverlyHangUpScript

.HasNugget:
	getlandmarkname NATIONAL_PARK, $2
	farsjump BeverlyComePickUpScript

BeverlyPhoneScript2:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftruefwd .HasNugget
	farscall PhoneScript_Random4
	ifequalfwd $0, .FoundNugget

.HasNugget:
	farsjump Phone_GenericCall_Female

.FoundNugget:
	setflag ENGINE_BEVERLY_HAS_NUGGET
	getlandmarkname NATIONAL_PARK, $2
	farsjump PhoneScript_FoundItem_Female
