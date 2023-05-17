RalphPhoneScript1:
	gettrainername FISHER, RALPH1, $0
	checkflag ENGINE_RALPH_READY_FOR_REMATCH
	iftruefwd Ralph_Rematch
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftruefwd Ralph_CheckSwarm
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, Ralph_CheckSwarm
	checktime 1 << MORN
	iftruefwd Ralph_WednesdayMorning
Ralph_CheckSwarm:
	checkflag ENGINE_FISH_SWARM
	iftruefwd Ralph_ReportSwarm
	farsjump RalphNoItemScript

Ralph_Rematch:
	getlandmarkname ROUTE_32, $2
	farsjump RalphReminderScript

Ralph_ReportSwarm:
	getlandmarkname ROUTE_32, $2
	farsjump RalphHurryScript

RalphPhoneScript2:
	gettrainername FISHER, RALPH1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalsefwd Ralph_CheckSwarm2
	checkflag ENGINE_RALPH_READY_FOR_REMATCH
	iftruefwd Ralph_CheckSwarm2
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftruefwd Ralph_CheckSwarm2
	farscall PhoneScript_Random2
	ifequalfwd $0, Ralph_FightMe
Ralph_CheckSwarm2:
	farscall PhoneScript_Random5
	ifequalfwd $0, Ralph_SetUpSwarm
	farsjump Phone_GenericCall_Male

Ralph_WednesdayMorning:
	setflag ENGINE_RALPH_WEDNESDAY_MORNING
Ralph_FightMe:
	getlandmarkname ROUTE_32, $2
	setflag ENGINE_RALPH_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

Ralph_SetUpSwarm:
	checkflag ENGINE_FISH_SWARM
	iftruefwd .Generic
	setflag ENGINE_FISH_SWARM
	getmonname QWILFISH, $1
	getlandmarkname ROUTE_32, $2
	setval FISHSWARM_QWILFISH
	special Special_ActivateFishingSwarm
	farsjump RalphItemScript

.Generic:
	farsjump Phone_GenericCall_Male
