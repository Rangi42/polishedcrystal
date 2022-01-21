PowerPlant_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 17, ROUTE_10_NORTH, 2
	warp_event  3, 17, ROUTE_10_NORTH, 2

	def_coord_events
	coord_event  5, 12, 1, PowerPlantGuardPhoneScript

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  1,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  4, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficerScript, -1
	object_event  2,  9, SPRITE_GYM_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide1Script, -1
	object_event  6, 11, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide2Script, -1
	object_event  9,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficer2Script, -1
	object_event  7,  2, SPRITE_GYM_GUY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide4Script, -1
	object_event 14, 10, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantManager, -1
	object_event  5,  5, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantForestText, -1

	object_const_def
	const POWERPLANT_OFFICER1
	const POWERPLANT_GYM_GUY1
	const POWERPLANT_GYM_GUY2

PowerPlantGuardPhoneScript:
	playsound SFX_CALL
	showemote EMOTE_SHOCK, POWERPLANT_OFFICER1, 15
	waitsfx
	pause 30
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ApproachGymGuide2Movement
	turnobject POWERPLANT_GYM_GUY1, DOWN
	turnobject POWERPLANT_GYM_GUY2, DOWN
	showtext PowerPlantOfficer1CeruleanShadyCharacterText
	turnobject POWERPLANT_OFFICER1, LEFT
	turnobject PLAYER, RIGHT
	showtext PowerPlantOfficer1CouldIAskForYourCooperationText
	turnobject PLAYER, DOWN
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ReturnToPostMovement
	setscene $0
	end

PowerPlantOfficerScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer PowerPlantOfficer1HaveToBeefUpSecurityText
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue_jumptextfaceplayer PowerPlantOfficer1CouldIAskForYourCooperationText
	jumptextfaceplayer PowerPlantOfficer1AThiefBrokeInText

PowerPlantGymGuide1Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer PowerPlantGymGuide1GeneratorUpAndRunningText
	jumptextfaceplayer PowerPlantGymGuide1SomeoneStoleAPartText

PowerPlantGymGuide2Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer PowerPlantGymGuide2GeneratorIsRunningAgainText
	jumptextfaceplayer PowerPlantGymGuide2PowerPlantUpAndRunningText

PowerPlantOfficer2Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer PowerPlantOfficer2ManagerHasBeenCheerfulText
	jumptextfaceplayer PowerPlantOfficer2ManagerHasBeenSadAndFuriousText

PowerPlantGymGuide4Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer PowerPlantGymGuide4WeCanGetMagnetTrainRunningText
	jumptextfaceplayer PowerPlantGymGuide4MagnetTrainConsumesElectricityText

PowerPlantManager:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue PowerPlantTutorZapCannonScript
	checkkeyitem MACHINE_PART
	iftrue UnknownScript_0x188e93
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue_jumpopenedtext PowerPlantManagerIWontForgiveCulpritText
	writetext PowerPlantManagerWhoWouldRuinMyGeneratorText
	waitbutton
	closetext
	setevent EVENT_MET_MANAGER_AT_POWER_PLANT
	clearevent EVENT_CERULEAN_GYM_ROCKET
	setmapscene CERULEAN_GYM, $1
	setscene $1
	end

UnknownScript_0x188e93:
	writetext PowerPlantManagerThatsThePartText
	promptbutton
	takekeyitem MACHINE_PART
	clearevent EVENT_SAFFRON_TRAIN_STATION_POPULATION
	setevent EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
	setevent EVENT_ROUTE_24_ROCKET
	setevent EVENT_RESTORED_POWER_TO_KANTO
	clearevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	setmapscene ROUTE_10_NORTH, $1
	clearevent EVENT_LAWRENCE_ROUTE_10
	writetext PowerPlantManagerTakeThisTMText
	waitbutton
PowerPlantTutorZapCannonScript:
	writetext Text_PowerPlantTutorZapCannon
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_PowerPlantTutorQuestion
	yesorno
	iffalse .TutorRefused
	setval ZAP_CANNON
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_PowerPlantTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_PowerPlantTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_PowerPlantTutorTaught

PowerPlantOfficer1ApproachGymGuide2Movement:
	step_right
	step_right
	step_up
	step_up
	step_end

PowerPlantOfficer1ReturnToPostMovement:
	step_down
	step_down
	step_left
	step_left
	turn_head_down
	step_end

PowerPlantOfficer1AThiefBrokeInText:
	text "A thief broke into"
	line "the Power Plant…"

	para "What is the world"
	line "coming to?"
	done

PowerPlantOfficer1CeruleanShadyCharacterText:
	text "I just got word"
	line "from Cerulean."

	para "It appears that a"
	line "shady character"

	para "has been loitering"
	line "around."
	done

PowerPlantOfficer1CouldIAskForYourCooperationText:
	text "Could I ask for"
	line "your cooperation?"
	done

PowerPlantOfficer1HaveToBeefUpSecurityText:
	text "We'll have to beef"
	line "up our security"
	cont "presence."
	done

PowerPlantGymGuide1SomeoneStoleAPartText:
	text "Someone made off"
	line "with a part that's"

	para "essential for the"
	line "generator."

	para "Without it, the"
	line "new generator's"
	cont "useless!"
	done

PowerPlantGymGuide1GeneratorUpAndRunningText:
	text "The generator's up"
	line "and running. It's"

	para "making electricity"
	line "to spare."
	done

PowerPlantGymGuide2PowerPlantUpAndRunningText:
	text "This Power Plant"
	line "had been abandoned"
	cont "in the past."

	para "We got it back up"
	line "and running to"

	para "provide power to"
	line "the Magnet Train."
	done

PowerPlantGymGuide2GeneratorIsRunningAgainText:
	text "The generator's"
	line "running again!"
	done

PowerPlantOfficer2ManagerHasBeenSadAndFuriousText:
	text "The Power Plant's"
	line "Manager is up"
	cont "ahead."

	para "But since someone"
	line "wrecked the gener-"
	cont "ator, he's been"
	cont "both sad and"
	cont "furious…"
	done

PowerPlantOfficer2ManagerHasBeenCheerfulText:
	text "Since the gener-"
	line "ator's been fixed,"

	para "the Manager has"
	line "been cheerful."
	done

PowerPlantGymGuide4MagnetTrainConsumesElectricityText:
	text "The Magnet Train"
	line "consumes a lot of"
	cont "electricity."

	para "It can't move if"
	line "the new generator"
	cont "isn't operating."
	done

PowerPlantGymGuide4WeCanGetMagnetTrainRunningText:
	text "All right! We can"
	line "finally get the"

	para "Magnet Train"
	line "running again."
	done

PowerPlantManagerWhoWouldRuinMyGeneratorText:
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

PowerPlantManagerIWontForgiveCulpritText:
	text "Manager: I won't"
	line "forgive him!"

	para "The culprit can"
	line "cry and apologize,"

	para "but I'll still"
	line "hammer him!"

	para "Gahahahah!"
	done

PowerPlantManagerThatsThePartText:
	text "Manager: Ah! Yeah!"

	para "That's the missing"
	line "part from my be-"
	cont "loved generator!"
	cont "You found it?"
	done

PowerPlantManagerTakeThisTMText:
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
