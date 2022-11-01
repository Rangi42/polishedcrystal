LizPhoneScript1:
	gettrainername PICNICKER, LIZ1, $0
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd586
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd57f
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd57f
	checktime 1 << DAY
	iftruefwd LizThursdayAfternoon

UnknownScript_0xbd57f:
	special RandomPhoneMon
	farsjump LizHangUpScript

UnknownScript_0xbd586:
	getlandmarkname ROUTE_32, $2
	farsjump LizReminderScript

LizPhoneScript2:
	gettrainername PICNICKER, LIZ1, $0
	farscall PhoneScript_Random4
	ifequalfwd $0, LizWrongNumber
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftruefwd UnknownScript_0xbd5a9
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftruefwd UnknownScript_0xbd5a9

UnknownScript_0xbd5a9:
	farscall PhoneScript_Random2
	ifequalfwd $0, LizGossip
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd UnknownScript_0xbd5bf
	farscall PhoneScript_Random2
	ifequalfwd $0, LizWantsBattle

UnknownScript_0xbd5bf:
	farsjump Phone_GenericCall_Female

LizThursdayAfternoon:
	setflag ENGINE_LIZ_THURSDAY_AFTERNOON

LizWantsBattle:
	getlandmarkname ROUTE_32, $2
	setflag ENGINE_LIZ_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

LizWrongNumber:
	farsjump LizWrongNumberScript

LizGossip:
	random $9
	ifequalfwd $0, UnknownScript_0xbd5fa
	ifequalfwd $1, UnknownScript_0xbd600
	ifequalfwd $2, UnknownScript_0xbd606
	ifequalfwd $3, UnknownScript_0xbd60c
	ifequalfwd $4, UnknownScript_0xbd612
	ifequalfwd $5, UnknownScript_0xbd618
	ifequalfwd $6, UnknownScript_0xbd61e
	ifequalfwd $7, UnknownScript_0xbd624
	ifequalfwd $8, UnknownScript_0xbd62a

UnknownScript_0xbd5fa:
	gettrainerclassname COOLTRAINERM, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd600:
	gettrainerclassname BEAUTY, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd606:
	gettrainerclassname GRUNTM, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd60c:
	gettrainerclassname TEACHER, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd612:
	gettrainerclassname SWIMMERF, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd618:
	gettrainerclassname KIMONO_GIRL_1, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd61e:
	gettrainerclassname SKIER, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd624:
	gettrainerclassname MEDIUM, $1
	sjumpfwd LizGossipScript

UnknownScript_0xbd62a:
	gettrainerclassname POKEFANM, $1
	; fallthrough

LizGossipScript:
	farsjump LizGossipRandomScript
