PowerPlant_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2, 17, ROUTE_10_NORTH, 2
	warp_event  3, 17, ROUTE_10_NORTH, 2

	db 1 ; coord events
	coord_event  5, 12, 1, PowerPlantGuardPhoneScript

	db 2 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  1,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 7 ; object events
	object_event  4, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, OfficerScript_0x188df5, -1
	object_event  2,  9, SPRITE_GYM_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GymGuyScript_0x188e15, -1
	object_event  6, 11, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GymGuyScript_0x188e29, -1
	object_event  9,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, OfficerScript_0x188e3d, -1
	object_event  7,  2, SPRITE_GYM_GUY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GymGuyScript_0x188e51, -1
	object_event 14, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, PowerPlantManager, -1
	object_event  5,  5, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, PowerPlantForestText, -1

	const_def 1 ; object constants
	const POWERPLANT_OFFICER1
	const POWERPLANT_GYM_GUY1
	const POWERPLANT_GYM_GUY2

PowerPlantGuardPhoneScript:
	playsound SFX_CALL
	showemote EMOTE_SHOCK, POWERPLANT_OFFICER1, 15
	waitsfx
	pause 30
	applymovement POWERPLANT_OFFICER1, MovementData_0x188ed5
	turnobject POWERPLANT_GYM_GUY1, DOWN
	turnobject POWERPLANT_GYM_GUY2, DOWN
	showtext UnknownText_0x188f22
	turnobject POWERPLANT_OFFICER1, LEFT
	turnobject PLAYER, RIGHT
	showtext UnknownText_0x188f7f
	turnobject PLAYER, DOWN
	applymovement POWERPLANT_OFFICER1, MovementData_0x188eda
	setscene $0
	end

OfficerScript_0x188df5:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x188fa2
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue_jumptextfaceplayer UnknownText_0x188f7f
	jumptextfaceplayer UnknownText_0x188ee0

GymGuyScript_0x188e15:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x189038
	jumptextfaceplayer UnknownText_0x188fcf

GymGuyScript_0x188e29:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x1890ef
	jumptextfaceplayer UnknownText_0x189079

OfficerScript_0x188e3d:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x18917f
	jumptextfaceplayer UnknownText_0x18910e

GymGuyScript_0x188e51:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x189225
	jumptextfaceplayer UnknownText_0x1891c2

PowerPlantManager:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue PowerPlantTutorZapCannonScript
	checkitem MACHINE_PART
	iftrue UnknownScript_0x188e93
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue_jumpopenedtext UnknownText_0x189308
	writetext UnknownText_0x189264
	waitbutton
	closetext
	setevent EVENT_MET_MANAGER_AT_POWER_PLANT
	clearevent EVENT_CERULEAN_GYM_ROCKET
	setmapscene CERULEAN_GYM, $1
	setscene $1
	end

UnknownScript_0x188e93:
	writetext UnknownText_0x18936e
	buttonsound
	takeitem MACHINE_PART
	setevent EVENT_RETURNED_MACHINE_PART
	clearevent EVENT_SAFFRON_TRAIN_STATION_POPULATION
	setevent EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
	setevent EVENT_ROUTE_24_ROCKET
	setevent EVENT_RESTORED_POWER_TO_KANTO
	clearevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	setmapscene ROUTE_10_NORTH, $1
	clearevent EVENT_LAWRENCE_ROUTE_10
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_LAWRENCE
	writetext UnknownText_0x1893c4
	waitbutton
PowerPlantTutorZapCannonScript:
	writetext Text_PowerPlantTutorZapCannon
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_PowerPlantTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte ZAP_CANNON
	writetext Text_PowerPlantTutorClear
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_PowerPlantTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_PowerPlantTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_PowerPlantTutorTaught

MovementData_0x188ed5:
	step_right
	step_right
	step_up
	step_up
	step_end

MovementData_0x188eda:
	step_down
	step_down
	step_left
	step_left
	turn_head_down
	step_end

UnknownText_0x188ee0:
	text "A thief broke into"
	line "the Power Plant…"

	para "What is the world"
	line "coming to?"
	done

UnknownText_0x188f22:
	text "I just got word"
	line "from Cerulean."

	para "It appears that a"
	line "shady character"

	para "has been loitering"
	line "around."
	done

UnknownText_0x188f7f:
	text "Could I ask for"
	line "your cooperation?"
	done

UnknownText_0x188fa2:
	text "We'll have to beef"
	line "up our security"
	cont "presence."
	done

UnknownText_0x188fcf:
	text "Someone made off"
	line "with a part that's"

	para "essential for the"
	line "generator."

	para "Without it, the"
	line "new generator's"
	cont "useless!"
	done

UnknownText_0x189038:
	text "The generator's up"
	line "and running. It's"

	para "making electricity"
	line "to spare."
	done

UnknownText_0x189079:
	text "This Power Plant"
	line "had been abandoned"
	cont "in the past."

	para "We got it back up"
	line "and running to"

	para "provide power to"
	line "the Magnet Train."
	done

UnknownText_0x1890ef:
	text "The generator's"
	line "running again!"
	done

UnknownText_0x18910e:
	text "The Power Plant's"
	line "Manager is up"
	cont "ahead."

	para "But since someone"
	line "wrecked the gener-"
	cont "ator, he's been"
	cont "both sad and"
	cont "furious…"
	done

UnknownText_0x18917f:
	text "Since the gener-"
	line "ator's been fixed,"

	para "the Manager has"
	line "been cheerful."
	done

UnknownText_0x1891c2:
	text "The Magnet Train"
	line "consumes a lot of"
	cont "electricity."

	para "It can't move if"
	line "the new generator"
	cont "isn't operating."
	done

UnknownText_0x189225:
	text "All right! We can"
	line "finally get the"

	para "Magnet Train"
	line "running again."
	done

UnknownText_0x189264:
	text "Manager: I, I, I'm"
	line "ready to blast"
	cont "someone!"

	para "Who would dare"
	line "ruin my generator?"

	para "I spent so much"
	line "time on it!"

	para "If I catch him,"
	line "he's going to get"

	para "a taste of my Zap"
	line "Cannon!"
	done

UnknownText_0x189308:
	text "Manager: I won't"
	line "forgive him!"

	para "The culprit can"
	line "cry and apologize,"

	para "but I'll still"
	line "hammer him!"

	para "Gahahahah!"
	done

UnknownText_0x18936e:
	text "Manager: Ah! Yeah!"

	para "That's the missing"
	line "part from my be-"
	cont "loved generator!"
	cont "You found it?"
	done

UnknownText_0x1893c4:
	text "Wahah! Thanks!"
	line "You deserve a"
	cont "reward!"
	done

Text_PowerPlantTutorZapCannon:
	text "Manager: I can"
	line "teach your"

	para "#mon to use"
	line "my Zap Cannon!"

	para "It's not what any-"
	line "one would consider"

	para "accurate, but it"
	line "packs a wallop!"

	para "I'll just need one"
	line "Silver Leaf."
	done

Text_PowerPlantTutorNoSilverLeaf:
	text "Sorry, but I can't"
	line "teach Zap Cannon"
	cont "without that Leaf!"
	done

Text_PowerPlantTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Zap Cannon?"
	done

Text_PowerPlantTutorRefused:
	text "Have it your way."
	done

Text_PowerPlantTutorClear:
	text ""
	done

Text_PowerPlantTutorTaught:
	text "Now your #mon"
	line "knows Zap Cannon!"

	para "Wahahah!"
	done

PowerPlantForestText:
	text "Magneton behaves"
	line "strangely in Rock"
	cont "Tunnel."

	para "Could the Power"
	line "Plant's turbines"

	para "have something to"
	line "do with it?"
	done
