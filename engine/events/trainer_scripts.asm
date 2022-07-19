TalkToTrainerScript::
	faceplayer
	trainerflagaction CHECK_FLAG
	iftruefwd AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjumpfwd StartBattleWithMapTrainerScript

SeenByTrainerScript::
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	; fallthrough

StartBattleWithMapTrainerScript:
	opentext
	trainertext $0
	waitbutton
	closetext
	loadtemptrainer
	callasm CheckTrainerClass
	iffalsefwd .nobattle
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
