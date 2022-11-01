PhoneScript_Random2:
	random 2
	end

PhoneScript_Random3:
	random 3
	end

PhoneScript_Random4:
	random 4
	end

PhoneScript_Random5:
	random 5
	end

PhoneScript_Random11:
	random 11
	end

PhoneScript_AnswerPhone_Male:
	checktime 1 << DAY
	iftruefwd PhoneScript_AnswerPhone_Male_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_AnswerPhone_Male_Nite
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneText
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Male_Day:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneDayText
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneDayText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneDayText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneDayText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneDayText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneDayText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneDayText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneDayText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneDayText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneDayText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneDayText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneDayText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneDayText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneDayText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneDayText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneDayText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneDayText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneDayText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneDayText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneDayText
	promptbutton
	end

PhoneScript_AnswerPhone_Male_Nite:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneNiteText
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneNiteText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneNiteText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneNiteText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneNiteText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneNiteText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneNiteText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneNiteText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneNiteText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneNiteText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneNiteText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneNiteText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneNiteText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneNiteText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneNiteText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneNiteText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneNiteText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneNiteText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneNiteText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneNiteText
	promptbutton
	end

PhoneScript_AnswerPhone_Female:
	checktime 1 << DAY
	iftruefwd PhoneScript_AnswerPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd PhoneScript_AnswerPhone_Female_Nite
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneText
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Female_Day:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneDayText
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneDayText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneDayText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneDayText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneDayText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneDayText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneDayText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneDayText
	promptbutton
	end

PhoneScript_AnswerPhone_Female_Nite:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneNiteText
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneNiteText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneNiteText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneNiteText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneNiteText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneNiteText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneNiteText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneNiteText
	promptbutton
	end

PhoneScript_GreetPhone_Male:
	checktime 1 << DAY
	iftruefwd PhoneScript_GreetPhone_Male_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_GreetPhone_Male_Nite
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetText
	promptbutton
	end

.Huey:
	farwritetext HueyGreetText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Male_Day:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetDayText
	promptbutton
	end

.Huey:
	farwritetext HueyGreetDayText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetDayText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetDayText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetDayText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetDayText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetDayText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetDayText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetDayText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetDayText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetDayText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetDayText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetDayText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetDayText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetDayText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetDayText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetDayText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetDayText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetDayText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetDayText
	promptbutton
	end

PhoneScript_GreetPhone_Male_Nite:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_SAILOR_HUEY, .Huey
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_JUGGLER_IRWIN, .Irwin
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_BLACKBELT_KENJI, .Kenji
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetNiteText
	promptbutton
	end

.Huey:
	farwritetext HueyGreetNiteText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetNiteText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetNiteText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetNiteText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetNiteText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetNiteText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetNiteText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetNiteText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetNiteText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetNiteText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetNiteText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetNiteText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetNiteText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetNiteText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetNiteText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetNiteText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetNiteText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetNiteText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetNiteText
	promptbutton
	end

PhoneScript_GreetPhone_Female:
	checktime 1 << DAY
	iftruefwd PhoneScript_GreetPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd PhoneScript_GreetPhone_Female_Nite
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetText
	promptbutton
	end

.Beth:
	farwritetext BethGreetText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetText
	promptbutton
	end

.Liz:
	farwritetext LizGreetText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Female_Day:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetDayText
	promptbutton
	end

.Beth:
	farwritetext BethGreetDayText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetDayText
	promptbutton
	end

.Liz:
	farwritetext LizGreetDayText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetDayText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetDayText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetDayText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetDayText
	promptbutton
	end

PhoneScript_GreetPhone_Female_Nite:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetNiteText
	promptbutton
	end

.Beth:
	farwritetext BethGreetNiteText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetNiteText
	promptbutton
	end

.Liz:
	farwritetext LizGreetNiteText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetNiteText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetNiteText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetNiteText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetNiteText
	promptbutton
	end

PhoneScript_Generic_Male:
	readvar VAR_CALLERID
	ifequalfwd PHONE_SCHOOLBOY_JACK, .Jack
	ifequalfwd PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequalfwd PHONE_BIRDKEEPER_JOSE, .Jose
	ifequalfwd PHONE_YOUNGSTER_JOEY, .Joey
	ifequalfwd PHONE_BUG_CATCHER_WADE, .Wade
	ifequalfwd PHONE_FISHER_RALPH, .Ralph
	ifequalfwd PHONE_HIKER_ANTHONY, .Anthony
	ifequalfwd PHONE_CAMPER_TODD, .Todd
	ifequalfwd PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequalfwd PHONE_SCHOOLBOY_ALAN, .Alan
	ifequalfwd PHONE_SCHOOLBOY_CHAD, .Chad
	ifequalfwd PHONE_POKEFANM_DEREK, .Derek
	ifequalfwd PHONE_FISHER_TULLY, .Tully
	ifequalfwd PHONE_POKEMANIAC_BRENT, .Brent
	ifequalfwd PHONE_BIRDKEEPER_VANCE, .Vance
	ifequalfwd PHONE_FISHER_WILTON, .Wilton
	ifequalfwd PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGenericText
	promptbutton
	end

.Unknown:
	farwritetext UnknownGenericText
	promptbutton
	end

.Gaven:
	farwritetext GavenGenericText
	promptbutton
	end

.Jose:
	farwritetext JoseGenericText
	promptbutton
	end

.Joey:
	farwritetext JoeyGenericText
	promptbutton
	end

.Wade:
	farwritetext WadeGenericText
	promptbutton
	end

.Ralph:
	farwritetext RalphGenericText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGenericText
	promptbutton
	end

.Todd:
	farwritetext ToddGenericText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGenericText
	promptbutton
	end

.Alan:
	farwritetext AlanGenericText
	promptbutton
	end

.Chad:
	farwritetext ChadGenericText
	promptbutton
	end

.Derek:
	farwritetext DerekGenericText
	promptbutton
	end

.Tully:
	farwritetext TullyGenericText
	promptbutton
	end

.Brent:
	farwritetext BrentGenericText
	promptbutton
	end

.Vance:
	farwritetext VanceGenericText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGenericText
	promptbutton
	end

.Parry:
	farwritetext ParryGenericText
	promptbutton
	end

PhoneScript_Generic_Female:
	readvar VAR_CALLERID
	ifequalfwd PHONE_POKEFAN_BEVERLY, .Beverly
	ifequalfwd PHONE_COOLTRAINERF_BETH, .Beth
	ifequalfwd PHONE_COOLTRAINERF_REENA, .Reena
	ifequalfwd PHONE_PICNICKER_LIZ, .Liz
	ifequalfwd PHONE_PICNICKER_GINA, .Gina
	ifequalfwd PHONE_LASS_DANA, .Dana
	ifequalfwd PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequalfwd PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGenericText
	promptbutton
	end

.Beth:
	farwritetext BethGenericText
	promptbutton
	end

.Reena:
	farwritetext ReenaGenericText
	promptbutton
	end

.Liz:
	farwritetext LizGenericText
	promptbutton
	end

.Gina:
	farwritetext GinaGenericText
	promptbutton
	end

.Dana:
	farwritetext DanaGenericText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGenericText
	promptbutton
	end

.Erin:
	farwritetext ErinGenericText
	promptbutton
	end

PhoneScript_MonFlavorText:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequalfwd $0, .TooEnergetic
	farwritetext UnknownGenericText
	promptbutton
	farsjump PhoneScript_HangupText_Male

.TooEnergetic:
	farwritetext UnknownTougherThanEverText
	promptbutton
	farsjump PhoneScript_HangupText_Male

Phone_GrandmaString: db "Grandma@"
Phone_GrandpaString: db "Grandpa@"
Phone_MomString:     db "Mom@"
Phone_DadString:     db "Dad@"
Phone_SisterString:  db "Sister@"
Phone_BrotherString: db "Brother@"
