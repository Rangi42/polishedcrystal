TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump StartBattleWithMapTrainerScript

SeenByTrainerScript::
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	sjump StartBattleWithMapTrainerScript

StartBattleWithMapTrainerScript:
	opentext
	trainertext $0
	waitbutton
	closetext
	loadtemptrainer
	callasm CheckTrainerClass
	iffalse .nobattle
	startbattle
	reloadmapafterbattle
.nobattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1

AlreadyBeatenTrainerScript:
	scripttalkafter

CheckTrainerClass:
	ld a, [wTempTrainerClass]
	ldh [hScriptVar], a
	ret
