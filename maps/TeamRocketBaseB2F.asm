TeamRocketBaseB2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, TransmitterDoorCallback

	def_warp_events
	warp_event  3, 14, TEAM_ROCKET_BASE_B1F, 2
	warp_event  3,  2, TEAM_ROCKET_BASE_B3F, 1
	warp_event 27,  2, TEAM_ROCKET_BASE_B3F, 2
	warp_event  3,  6, TEAM_ROCKET_BASE_B3F, 3
	warp_event 27, 14, TEAM_ROCKET_BASE_B3F, 4

	def_coord_events
	coord_event  5, 14, 0, LanceHealsScript
	coord_event  4, 13, 0, LanceHealsScript
	coord_event 14, 11, 1, RocketBaseBossFLeft
	coord_event 15, 11, 1, RocketBaseBossFRight
	coord_event 14, 12, 2, RocketBaseCantLeaveScript
	coord_event 15, 12, 2, RocketBaseCantLeaveScript
	coord_event 12,  3, 2, RocketBaseLancesSideScript
	coord_event 12, 10, 2, RocketBaseLancesSideScript
	coord_event 12, 11, 2, RocketBaseLancesSideScript

	def_bg_events
	bg_event 14, 12, BGEVENT_IFNOTSET, MapTeamRocketBaseB2FSignpostPtr1
	bg_event 15, 12, BGEVENT_IFNOTSET, MapTeamRocketBaseB2FSignpostPtr1
	bg_event 17,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 16,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 15,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 14,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 13,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  9, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  8, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  7, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  6, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  5, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 12,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 13,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 14,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 15,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 16,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 17,  4, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 17,  5, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 17,  6, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 17,  7, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 17,  8, BGEVENT_READ, MapTeamRocketBaseB2FSignpost21Script
	bg_event 26,  7, BGEVENT_ITEM + FULL_HEAL, EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL

	def_object_events
	object_event 20, 16, SPRITE_PETREL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_PETREL
	object_event 20, 16, SPRITE_ARIANA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ARIANA
	object_event  5, 13, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	object_event  9, 13, SPRITE_DRAGONITE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	object_event  7,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode1, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event  7,  7, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode2, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event  7,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode3, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 22,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event 22,  7, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event 22,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTRODE, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 25, 13, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM17, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGruntM18, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGruntM19, EVENT_TEAM_ROCKET_BASE_POPULATION
	itemball_event  3, 10, HYPER_POTION, 1, EVENT_TEAM_ROCKET_BASE_B2F_HYPER_POTION

	object_const_def
	const TEAMROCKETBASEB2F_PETREL
	const TEAMROCKETBASEB2F_ARIANA
	const TEAMROCKETBASEB2F_LANCE
	const TEAMROCKETBASEB2F_DRAGONITE
	const TEAMROCKETBASEB2F_ELECTRODE1
	const TEAMROCKETBASEB2F_ELECTRODE2
	const TEAMROCKETBASEB2F_ELECTRODE3
	const TEAMROCKETBASEB2F_ELECTRODE4
	const TEAMROCKETBASEB2F_ELECTRODE5
	const TEAMROCKETBASEB2F_ELECTRODE6
	const TEAMROCKETBASEB2F_ROCKET1
	const TEAMROCKETBASEB2F_ROCKET2
	const TEAMROCKETBASEB2F_ROCKET3

TransmitterDoorCallback:
	checkevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	iftrue .Change
	return

.Change:
	changeblock 14, 12, $7
	return

RocketBaseBossFLeft:
	moveobject TEAMROCKETBASEB2F_LANCE, 9, 13
	jump RocketBaseBossFScript

RocketBaseBossFRight:
	moveobject TEAMROCKETBASEB2F_ARIANA, 21, 16
	moveobject TEAMROCKETBASEB2F_PETREL, 21, 16
	moveobject TEAMROCKETBASEB2F_DRAGONITE, 10, 13
	moveobject TEAMROCKETBASEB2F_LANCE, 10, 13
RocketBaseBossFScript:
	appear TEAMROCKETBASEB2F_ARIANA
	appear TEAMROCKETBASEB2F_PETREL
	showtext RocketBaseExecutiveFHoldItText
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, RocketBasePlayerApproachesBossFMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	applymovement TEAMROCKETBASEB2F_ARIANA, RocketBaseBossFApproachesPlayerMovement
	turnobject PLAYER, UP
	applymovement TEAMROCKETBASEB2F_PETREL, RocketBaseGruntApproachesPlayerMovement
	showtext RocketBaseBossFThrashText
	cry DRAGONITE
	turnobject TEAMROCKETBASEB2F_ARIANA, LEFT
	turnobject PLAYER, LEFT
	appear TEAMROCKETBASEB2F_DRAGONITE
	applymovement TEAMROCKETBASEB2F_DRAGONITE, RocketBaseDragoniteAttacksMovement
	applymovement TEAMROCKETBASEB2F_ARIANA, RocketBaseBossFHitMovement
	applymovement TEAMROCKETBASEB2F_PETREL, RocketBaseGruntProtectsBossFMovement
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesBossFMovement
	showtext RocketBaseLanceShareFunText
	turnobject PLAYER, RIGHT
	applymovement TEAMROCKETBASEB2F_ARIANA, RocketBaseBossFFacesPlayerMovement
	showtext RocketBaseBossDontMeddleText
	applyonemovement TEAMROCKETBASEB2F_PETREL, big_step_left
	applyonemovement TEAMROCKETBASEB2F_ARIANA, big_step_left
	winlosstext RocketBaseBossWinText, 0
	setlasttalked TEAMROCKETBASEB2F_ARIANA
	loadtrainer ARIANA, ARIANA2
	startbattle
	disappear TEAMROCKETBASEB2F_DRAGONITE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_ARIANA
	setevent EVENT_TEAM_ROCKET_BASE_B2F_PETREL
	setevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	reloadmapafterbattle
	setevent EVENT_BEAT_ARIANA_2
	showtext RocketBaseBossRetreatText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear TEAMROCKETBASEB2F_PETREL
	disappear TEAMROCKETBASEB2F_ARIANA
	disappear TEAMROCKETBASEB2F_ROCKET1
	disappear TEAMROCKETBASEB2F_ROCKET2
	disappear TEAMROCKETBASEB2F_ROCKET3
	pause 15
	special Special_FadeInQuickly
	setscene $2
	clearevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	showtext RocketBaseLancePostBattleText
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceChecksPlayerMovement
	turnobject PLAYER, UP
	showtext RocketBaseLancePowerOffText
	follow TEAMROCKETBASEB2F_LANCE, PLAYER
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesMachineMovement
	stopfollow
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLancePacesMovement
	showtext RockerBaseLanceElectrodeFaintText
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesElectrodesMovement
	disappear TEAMROCKETBASEB2F_LANCE

RocketBaseCantLeaveScript:
	applymovement PLAYER, RocketBasePlayerCantLeaveElectrodesMovement
	end

RocketBaseLancesSideScript:
	showtext RocketBaseLancesSideText
	applyonemovement PLAYER, step_left
	end

LanceHealsScript:
	faceobject PLAYER, TEAMROCKETBASEB2F_LANCE
	faceobject TEAMROCKETBASEB2F_LANCE, PLAYER
	showtext LanceHealsText1
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes
	showtext LanceHealsText2
	setscene $1
	setevent EVENT_LANCE_HEALED_YOU_IN_TEAM_ROCKET_BASE
	checkcode VAR_FACING
	ifequal RIGHT, UnknownScript_0x6d0be
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

UnknownScript_0x6d0be:
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealRightMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

GenericTrainerGruntM17:
	generictrainer GRUNTM, 17, EVENT_BEAT_ROCKET_GRUNTM_17, GruntM17SeenText, GruntM17BeatenText

	text "Heh, I'm just a"
	line "Grunt."

	para "I don't know the"
	line "password. Too bad"
	cont "for you."
	done

GenericTrainerGruntM18:
	generictrainer GRUNTM, 18, EVENT_BEAT_ROCKET_GRUNTM_18, GruntM18SeenText, GruntM18BeatenText

	text "I got wiped out on"
	line "the last mission"
	cont "by a kid too."

	para "When we were ab-"
	line "ducting #mon,"

	para "this kid with long"
	line "red hair and mean-"

	para "looking eyes just"
	line "creamed me…"
	done

GenericTrainerGruntM19:
	generictrainer GRUNTM, 19, EVENT_BEAT_ROCKET_GRUNTM_19, GruntM19SeenText, GruntM19BeatenText

	text "Heh, only the boss"
	line "knows the password"
	cont "for that door."

	para "Where's the boss?"
	line "Who knows? Go look"
	cont "for yourself."
	done

RocketElectrode1:
	cry ELECTRODE
	loadwildmon ELECTRODE, 33
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE1
	disappear TEAMROCKETBASEB2F_ELECTRODE4
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement1
	jump RocketBaseElectrodeScript

RocketElectrode2:
	cry ELECTRODE
	loadwildmon ELECTRODE, 33
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE2
	disappear TEAMROCKETBASEB2F_ELECTRODE5
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement2
	jump RocketBaseElectrodeScript

RocketElectrode3:
	cry ELECTRODE
	loadwildmon ELECTRODE, 33
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE3
	disappear TEAMROCKETBASEB2F_ELECTRODE6
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement3
	jump RocketBaseElectrodeScript

TeamRocketBaseB2FReloadMap:
	reloadmapafterbattle
	end

RocketBaseElectrodeScript:
	moveobject TEAMROCKETBASEB2F_LANCE, 18, 6
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesElectrodesMovement
	turnobject PLAYER, RIGHT
	opentext
	writetext RocketBaseLanceElectrodeDoneText
	buttonsound
	verbosegivetmhm TM_THIEF
	setevent EVENT_GOT_TM46_THIEF_FROM_LANCE
	writetext RocketBaseLanceWhirlpoolText
	waitbutton
	closetext
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	showtext RocketBaseLanceMonMasterText
	turnobject PLAYER, DOWN
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesBaseMovement
	disappear TEAMROCKETBASEB2F_LANCE
	setevent EVENT_CLEARED_ROCKET_HIDEOUT
	clearflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setevent EVENT_ROUTE_43_GATE_ROCKETS
	setevent EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	setscene $3
	clearevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

MapTeamRocketBaseB2FSignpostPtr1:
	dw EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	opentext
	checkevent EVENT_LEARNED_HAIL_GIOVANNI
	iftrue UnknownScript_0x6d1e8
	jumpopenedtext RocketBaseDoorNoPasswordText

UnknownScript_0x6d1e8:
	writetext RocketBaseDoorKnowPasswordText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 14, 12, $7
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	waitsfx
	end

MapTeamRocketBaseB2FSignpost21Script:
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x6d207
	jumpopenedtext RocketBaseB2FTransmitterText

UnknownScript_0x6d207:
	jumpopenedtext RocketBaseB2FDeactivateTransmitterText

RocketBaseLanceLeavesAfterHealMovement:
	step_right
RocketBaseLanceLeavesAfterHealRightMovement:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

RocketBasePlayerApproachesBossFMovement:
	step_down
	step_down
	step_down
	turn_head_right
	step_end

RocketBaseBossFApproachesPlayerMovement:
	run_step_left
	run_step_left
	run_step_up
	run_step_up
	run_step_up
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	turn_head_down
	step_end

RocketBaseGruntApproachesPlayerMovement:
	run_step_left
	run_step_left
	run_step_up
	run_step_up
	run_step_left
	run_step_left
	step_end

RocketBaseDragoniteAttacksMovement:
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	step_end

RocketBaseBossFHitMovement:
	fix_facing
	set_sliding
	jump_step_right
	remove_sliding
	remove_fixed_facing
	step_end

RocketBaseBossFFacesPlayerMovement:
	slow_step_down
	turn_head_left
	step_end

RocketBaseLanceApproachesBossFMovement:
	step_right
	step_right
	step_right
	step_end

RocketBaseGruntProtectsBossFMovement:
	run_step_left
	run_step_up
	turn_head_left
	step_end

RocketBaseLanceChecksPlayerMovement:
	step_right
	step_right
	turn_head_down
	step_end

RocketBaseLanceApproachesMachineMovement:
	step_up
	step_up
	step_up
	step_end

RocketBaseLancePacesMovement:
	step_sleep_8
	step_left
	step_left
	turn_head_up
	step_sleep_8
	step_right
	step_right
	step_right
	step_right
	turn_head_up
	step_sleep_8
	step_left
	step_left
	turn_head_down
	step_end

RocketBaseLanceApproachesElectrodesMovement:
	step_right
	step_right
	step_right
	step_right
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

RocketBasePlayerCantLeaveElectrodesMovement:
	step_up
	step_left
	step_left
	step_left
	step_left
	turn_head_up
	step_end

RocketBaseLanceLeavesElectrodesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_end

RocketBaseLanceLeavesBaseMovement:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

RocketBasePlayerLeavesElectrodesMovement1:
	step_right
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_end

RocketBasePlayerLeavesElectrodesMovement2:
	step_right
	step_right
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_end

RocketBasePlayerLeavesElectrodesMovement3:
	step_right
	step_right
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_end

RocketBaseExecutiveFHoldItText:
	text "Hold it right"
	line "there!"
	done

RocketBaseBossFThrashText:
	text "We can't have a"
	line "brat like you on"
	cont "the loose."

	para "It's harmful to"
	line "Team Rocket's"
	cont "pride, you see."

	para "However strong you"
	line "may be, you can't"

	para "take both of us at"
	line "the same time."

	para "Sorry, baby. Now"
	line "get ready to be"
	cont "thrashed."
	done

RocketBaseLanceShareFunText:
	text "Hey! Don't be so"
	line "selfish. Spread"
	cont "the fun around."
	done

RocketBaseBossDontMeddleText:
	text "What? You had an"
	line "accomplice?"

	para "Where is your"
	line "sense of honor?"

	para "As the interim"
	line "boss in place of"

	para "Giovanni, I'll"
	line "show you how wrong"

	para "it is to meddle"
	line "with Team Rocket!"
	done

RocketBaseBossWinText:
	text "Tch, you really"
	line "are strong."

	para "It's too bad."

	para "If you were to"
	line "join Team Rocket,"

	para "you could become"
	line "an Executive."
	done

RocketBaseBossRetreatText:
	text "…This hideout is"
	line "done for…"

	para "But that's fine."
	line "The broadcast ex-"
	cont "periment was a"
	cont "total success."

	para "It doesn't matter"
	line "what happens to"
	cont "this hideout now."

	para "We have much big-"
	line "ger plans."

	para "You'll come to"
	line "appreciate Team"

	para "Rocket's true"
	line "power soon enough."

	para "Enjoy yourself"
	line "while you can…"

	para "Fufufufu…"
	done

RocketBaseLancePostBattleText:
	text "Lance: That did"
	line "it. We defeated"

	para "all the Rockets"
	line "here."

	para "But I'm concerned"
	line "about the young"

	para "guy I battled in"
	line "the process…"
	done

RocketBaseLancePowerOffText:
	text "Sorry, <PLAYER>."
	line "I saw how well you"

	para "were doing, so I"
	line "just hung back."

	para "Now all there is"
	line "left to do is to"

	para "turn off that odd"
	line "radio signal."
	done

RockerBaseLanceElectrodeFaintText:
	text "It's this machine"
	line "that's causing all"
	cont "the problems."

	para "I don't see a"
	line "switch on it…"

	para "We have no choice."
	line "We have to make"

	para "all the Electrode"
	line "faint."

	para "That should stop"
	line "this machine from"

	para "transmitting that"
	line "strange signal."

	para "It's no fault of"
	line "the #mon, so it"

	para "makes me feel"
	line "guilty."

	para "<PLAYER>, let's"
	line "split the job."
	done

RocketBaseLancesSideText:
	text "Lance: Leave this"
	line "side to me."
	done

RocketBaseLanceElectrodeDoneText:
	text "Lance: That odd"
	line "signal has finally"
	cont "stopped."

	para "The lake should be"
	line "back to normal."

	para "You're the hero!"
	line "Let me thank you"

	para "on behalf of all"
	line "the #mon."

	para "Oh, yes. You"
	line "should take this."

	para "I found it here,"
	line "but I don't have"
	cont "any need for it."
	done

RocketBaseLanceWhirlpoolText:
	text "That's Thief."
	line "I trust you won't"

	para "abuse it the way"
	line "Team Rocket does."
	done

RocketBaseLanceMonMasterText:
	text "<PLAYER>…"

	para "The journey to be-"
	line "coming the #mon"

	para "Master is long and"
	line "difficult."

	para "Knowing that, will"
	line "you keep going?"

	para "…"

	para "I see. No, you're"
	line "right."

	para "If you would give"
	line "up that easily,"

	para "you would have"
	line "never chased that"

	para "dream in the first"
	line "place."

	para "I look forward to"
	line "seeing you again!"
	done

LanceHealsText1:
	text "Lance: Are you all"
	line "right?"

	para "Your #mon are"
	line "hurt and tired."

	para "Here, give them"
	line "some of my medi-"
	cont "cine."
	done

LanceHealsText2:
	text "Lance: <PLAYER>,"
	line "let's give it our"
	cont "best for #mon."
	done

GruntM17SeenText:
	text "The door won't"
	line "open?"

	para "Well, duh."
	line "It has to have a"

	para "password that only"
	line "Team Rocket knows."
	done

GruntM17BeatenText:
	text "What? I lost?"
	done

GruntM18SeenText:
	text "Oh, a kid? I don't"
	line "really like this,"

	para "but eliminate you"
	line "I must."
	done

GruntM18BeatenText:
	text "I knew I'd lose…"
	done

GruntM19SeenText:
	text "You rotten little"
	line "pest!"
	done

GruntM19BeatenText:
	text "Grrrr…"
	done

RocketBaseDoorNoPasswordText:
	text "The door's closed…"

	para "It needs a pass-"
	line "word to open."
	done

RocketBaseDoorKnowPasswordText:
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the password."

	para "The door opened!"
	done

RocketBaseB2FTransmitterText:
	text "It's the radio"
	line "transmitter that's"

	para "sending the"
	line "sinister signal."

	para "It's working at"
	line "full capacity."
	done

RocketBaseB2FDeactivateTransmitterText:
	text "The radio trans-"
	line "mitter has finally"

	para "stopped its evil"
	line "broadcast."
	done
