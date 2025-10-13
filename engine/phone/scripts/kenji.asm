KenjiPhoneScript1:
	gettrainername BLACKBELT_T, KENJI1, STRING_BUFFER_3
	farscall PhoneScript_AnswerPhone_Male
	farsjump KenjiAnswerPhoneScript

KenjiPhoneScript2:
	gettrainername BLACKBELT_T, KENJI1, STRING_BUFFER_3
	farscall PhoneScript_GreetPhone_Male
	farsjump KenjiCallingPhoneScript
