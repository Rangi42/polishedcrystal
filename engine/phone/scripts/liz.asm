LizPhoneScript1:
	gettrainername PICNICKER, LIZ1, $0
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftruefwd .NotThursday
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, .NotThursday
	checktime 1 << DAY
	iftruefwd LizThursdayAfternoon

.NotThursday:
	special RandomPhoneMon
	farsjump LizHangUpScript

.WantsBattle:
	getlandmarkname ROUTE_32, $2
	farsjump LizReminderScript

LizPhoneScript2:
	gettrainername PICNICKER, LIZ1, $0
	farscall PhoneScript_Random4
	ifequalfwd $0, LizWrongNumber
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftruefwd .next
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftruefwd .next

.next:
	farscall PhoneScript_Random2
	ifequalfwd $0, LizGossip
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd .Generic
	farscall PhoneScript_Random2
	ifequalfwd $0, LizWantsBattle

.Generic:
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
	ifequalfwd $0, .CoolTrainerM
	ifequalfwd $1, .Beauty
	ifequalfwd $2, .Grunt
	ifequalfwd $3, .Teacher
	ifequalfwd $4, .SwimmerF
	ifequalfwd $5, .KimonoGirl
	ifequalfwd $6, .Skier
	ifequalfwd $7, .Medium
	ifequalfwd $8, .PokefanM

.CoolTrainerM:
	gettrainerclassname COOLTRAINERM, $1
	sjumpfwd LizGossipScript

.Beauty:
	gettrainerclassname BEAUTY, $1
	sjumpfwd LizGossipScript

.Grunt:
	gettrainerclassname GRUNTM, $1
	sjumpfwd LizGossipScript

.Teacher:
	gettrainerclassname TEACHER_F, $1
	sjumpfwd LizGossipScript

.SwimmerF:
	gettrainerclassname SWIMMERF, $1
	sjumpfwd LizGossipScript

.KimonoGirl:
	gettrainerclassname KIMONO_GIRL_1, $1
	sjumpfwd LizGossipScript

.Skier:
	gettrainerclassname SKIER, $1
	sjumpfwd LizGossipScript

.Medium:
	gettrainerclassname MEDIUM, $1
	sjumpfwd LizGossipScript

.PokefanM:
	gettrainerclassname POKEFANM, $1
	; fallthrough

LizGossipScript:
	farsjump LizGossipRandomScript
