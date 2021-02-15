SaffronTrainStation_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 6
	warp_event  9, 17, SAFFRON_CITY, 6
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, 0, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationGymGuideScript, -1
	object_event  6, 11, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronMagnetTrainStationTeacherText, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event  6, 10, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronMagnetTrainStationLassText, EVENT_SAFFRON_TRAIN_STATION_POPULATION

	object_const_def
	const SAFFRONTRAINSTATION_OFFICER

SaffronMagnetTrainStationOfficerScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumptextfaceplayer SaffronMagnetTrainStationOfficerTrainIsntOperatingText
	faceplayer
	opentext
	writetext SaffronMagnetTrainStationOfficerAreYouComingOnBoardText
	yesorno
	iffalse_jumpopenedtext SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText
	checkkeyitem PASS
	iffalse_jumpopenedtext SaffronMagnetTrainStationOfficerYouDontHaveAPassText
	writetext SaffronMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext
	applymovement SAFFRONTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement
	writebyte $1
	special Special_MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applyonemovement PLAYER, turn_head_down
	wait 36
	end

Script_ArriveFromGoldenrod:
	applymovement SAFFRONTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement SAFFRONTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement
	jumptext SaffronMagnetTrainStationOfficerArrivedInSaffronText

SaffronMagnetTrainStationGymGuideScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart
	jumptextfaceplayer SaffronMagnetTrainStationGymGuideText

SaffronMagnetTrainStationOfficerApproachTrainDoorMovement:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step_left
	step_down
	step_down
	step_end

SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	turn_head_up
	step_end

SaffronMagnetTrainStationOfficerTrainIsntOperatingText:
	text "I'm sorry, but the"
	line "Magnet Train isn't"
	cont "operating now."
	done

SaffronMagnetTrainStationOfficerAreYouComingOnBoardText:
	text "We'll soon depart"
	line "for Goldenrod."

	para "Are you coming on"
	line "board?"
	done

SaffronMagnetTrainStationOfficerRightThisWayText:
	text "May I see your"
	line "rail pass, please?"

	para "OK. Right this"
	line "way, please."
	done

SaffronMagnetTrainStationOfficerYouDontHaveAPassText:
	text "Sorry, but you"
	line "don't have a pass."
	done

SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText:
	text "We hope to see you"
	line "again."
	done

SaffronMagnetTrainStationOfficerArrivedInSaffronText:
	text "We have arrived in"
	line "Saffron."

	para "We hope to see you"
	line "again."
	done

SaffronMagnetTrainStationGymGuideText:
	text "The Magnet Train"
	line "is a super modern"

	para "rail liner that"
	line "uses electricity"

	para "and magnets to"
	line "attain incredible"
	cont "speed."

	para "However, if there"
	line "isn't any elec-"
	cont "tricity…"
	done

SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart:
	text "Whew…"

	para "How many times"
	line "have I gone back"

	para "and forth between"
	line "Kanto and Johto?"
	done

SaffronMagnetTrainStationTeacherText:
	text "Before the Magnet"
	line "Train Station was"

	para "built, there was a"
	line "house there."

	para "A little girl"
	line "named Copycat used"
	cont "to live there."
	done

SaffronMagnetTrainStationLassText:
	text "Hi. Do you have a"
	line "rail pass? I have"

	para "one. All the peo-"
	line "ple in Saffron who"

	para "ride the Magnet"
	line "Train have passes."
	done
