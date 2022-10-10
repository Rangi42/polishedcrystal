IrwinPhoneScript1:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd UnknownScript_0xbd7f9
	farsjump IrwinRandomTextScript

UnknownScript_0xbd7f9:
	farsjump IrwinRocketRumorScript

IrwinPhoneScript2:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd UnknownScript_0xbd80f
	farsjump IrwinRumorScript

UnknownScript_0xbd80f:
	farsjump IrwinRocketRumorScript
