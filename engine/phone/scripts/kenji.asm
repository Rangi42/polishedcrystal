KenjiPhoneScript1:
	gettrainername BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_AnswerPhone_Male
	farsjump KenjiAnswerPhoneScript

KenjiPhoneScript2:
	gettrainername BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_GreetPhone_Male
	farsjump KenjiCallingPhoneScript
