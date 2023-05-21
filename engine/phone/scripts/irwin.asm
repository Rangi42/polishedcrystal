IrwinPhoneScript1:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd .Rockets
	farsjump IrwinRandomTextScript

.Rockets:
	farsjump IrwinRocketRumorScript

IrwinPhoneScript2:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd .Rockets
	farsjump IrwinRumorScript

.Rockets:
	farsjump IrwinRocketRumorScript
