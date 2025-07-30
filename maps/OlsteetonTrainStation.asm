OlsteetonTrainStation_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 12, OLSTEETON, 15
	warp_event 17, 13, OLSTEETON, 15
	; warp_event  6,  5, SAFFRON_TRAIN_STATION, 4
	; warp_event 11,  5, SAFFRON_TRAIN_STATION, 3

	def_coord_events
	; coord_event 11,  6, 0, Script_ArriveFromSaffron

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlsteetonTrainStationOfficerScript, -1
	object_event 11, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTrainStationGentlemanText, EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	object_event  6, 12, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTrainStationCooltrainerText, -1

	object_const_def
	const OlsteetonTRAINSTATION_OFFICER

OlsteetonTrainStationOfficerScript:
	faceplayer
	opentext
	; checkevent EVENT_RESTORED_POWER_TO_KANTO
	; iftruefwd .MagnetTrainToSaffron
	jumpopenedtext OlsteetonTrainStationOfficerTheTrainHasntComeInText

; .MagnetTrainToSaffron:
; 	writetext OlsteetonTrainStationOfficerAreYouComingAboardText
; 	yesorno
; 	iffalse_jumpopenedtext OlsteetonTrainStationOfficerHopeToSeeYouAgainText
; 	checkkeyitem PASS
; 	iffalse_jumpopenedtext OlsteetonTrainStationOfficerYouDontHaveARailPassText
; 	writetext OlsteetonTrainStationOfficerRightThisWayText
; 	waitbutton
; 	closetext
; 	applymovement OlsteetonTRAINSTATION_OFFICER, OlsteetonTrainStationOfficerApproachTrainDoorMovement
; 	applymovement PLAYER, OlsteetonTrainStationPlayerApproachAndEnterTrainMovement
; 	setval $0
; 	special Special_MagnetTrain
; 	warpcheck
; 	newloadmap MAPSETUP_TRAIN
; 	applyonemovement PLAYER, turn_head_down
; 	wait 36
; 	end

; Script_ArriveFromSaffron:
; 	applymovement OlsteetonTRAINSTATION_OFFICER, OlsteetonTrainStationOfficerApproachTrainDoorMovement
; 	applymovement PLAYER, OlsteetonTrainStationPlayerLeaveTrainAndEnterStationMovement
; 	applymovement OlsteetonTRAINSTATION_OFFICER, OlsteetonTrainStationOfficerReturnToBoardingGateMovement
; 	jumptext OlsteetonTrainStationOfficerArrivedInGoldenrodText


; OlsteetonTrainStationOfficerApproachTrainDoorMovement:
; 	step_up
; 	step_up
; 	step_right
; 	turn_head_left
; 	step_end

; OlsteetonTrainStationOfficerReturnToBoardingGateMovement:
; 	step_left
; 	step_down
; 	step_down
; 	step_end

; OlsteetonTrainStationPlayerApproachAndEnterTrainMovement:
; 	step_up
; 	step_up
; 	step_up
; 	step_left
; 	step_left
; 	step_left
; 	step_up
; 	step_up
; 	step_end

; OlsteetonTrainStationPlayerLeaveTrainAndEnterStationMovement:
; 	step_left
; 	step_left
; 	step_down
; 	step_down
; 	step_down
; 	step_down
; 	turn_head_up
; 	step_end

OlsteetonTrainStationOfficerTheTrainHasntComeInText:
	text "The train hasn't"
	line "come in…"

	para "I know! I'll carry"
	line "the passengers on"
	cont "my back!"

	para "That won't work."
	done

OlsteetonTrainStationCooltrainerText:
	text "-sigh-  "
	line "..."

	para "I just really "
	line "like trains."
	done

OlsteetonTrainStationOfficerAreYouComingAboardText:
	text "We'll soon depart"
	line "for Saffron."

	para "Are you coming"
	line "aboard?"
	done

OlsteetonTrainStationOfficerRightThisWayText:
	text "May I see your"
	line "rail pass, please?"

	para "OK. Right this"
	line "way, please."
	done

OlsteetonTrainStationOfficerYouDontHaveARailPassText:
	text "Sorry. You don't"
	line "have a rail pass."
	done

OlsteetonTrainStationOfficerHopeToSeeYouAgainText:
	text "We hope to see you"
	line "again!"
	done

OlsteetonTrainStationOfficerArrivedInGoldenrodText:
	text "We have arrived in"
	line "Goldenrod."

	para "We hope to see you"
	line "again."
	done

OlsteetonTrainStationGentlemanText:
	text "I'm the President."

	para "My dream was to"
	line "build a train that"

	para "is faster than any"
	line "#mon."

	para "It really brings"
	line "Johto much closer"
	cont "to Kanto."
	done

OlsteetonTrainStationCooltrainerfText1:
	text "The Magnet Train"
	line "is like, zoooom,"
	cont "byun! Shuuu!"

	para "At least when"
	line "it's running…"
	done

OlsteetonTrainStationCooltrainerfText2:
	text "The Magnet Train"
	line "is like, zoooom,"
	cont "byun! Shuuu!"

	para "It's so cool!"
	done
