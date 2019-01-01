GoldenrodMagnetTrainStation_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  8, 17, GOLDENROD_CITY, 5
	warp_event  9, 17, GOLDENROD_CITY, 5
	warp_event  6,  5, SAFFRON_TRAIN_STATION, 4
	warp_event 11,  5, SAFFRON_TRAIN_STATION, 3

	db 1 ; coord events
	coord_event 11,  6, 0, Script_ArriveFromSaffron

	db 0 ; bg events

	db 3 ; object events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OfficerScript_0x550ec, -1
	object_event 11, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x552a3, EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	object_event  6, 12, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GoldenrodMagnetTrainStationCooltrainerfScript, -1

	const_def 1 ; object constants
	const GOLDENRODMAGNETTRAINSTATION_OFFICER

OfficerScript_0x550ec:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .MagnetTrainToSaffron
	jumpopenedtext UnknownText_0x55160

.MagnetTrainToSaffron:
	writetext UnknownText_0x551b7
	yesorno
	iffalse_jumpopenedtext UnknownText_0x5524f
	checkitem PASS
	iffalse_jumpopenedtext UnknownText_0x5522c
	writetext UnknownText_0x551ed
	waitbutton
	closetext
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, MovementData_0x55146
	applymovement PLAYER, MovementData_0x5514f
	writebyte $0
	special Special_MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applyonemovement PLAYER, turn_head_down
	wait 36
	end

Script_ArriveFromSaffron:
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, MovementData_0x55146
	applymovement PLAYER, MovementData_0x55158
	applymovement GOLDENRODMAGNETTRAINSTATION_OFFICER, MovementData_0x5514b
	jumptext UnknownText_0x5526a

GoldenrodMagnetTrainStationCooltrainerfScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .PowerRestored
	jumptextfaceplayer GoldenrodMagnetTrainStationCooltrainerfText1

.PowerRestored
	jumptextfaceplayer GoldenrodMagnetTrainStationCooltrainerfText2

MovementData_0x55146:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

MovementData_0x5514b:
	step_left
	step_down
	step_down
	step_end

MovementData_0x5514f:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x55158:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	turn_head_up
	step_end

UnknownText_0x55160:
	text "The train hasn't"
	line "come in…"

	para "I know! I'll carry"
	line "the passengers on"
	cont "my back!"

	para "That won't work."
	done

UnknownText_0x551b7:
	text "We'll soon depart"
	line "for Saffron."

	para "Are you coming"
	line "aboard?"
	done

UnknownText_0x551ed:
	text "May I see your"
	line "rail pass, please?"

	para "OK. Right this"
	line "way, please."
	done

UnknownText_0x5522c:
	text "Sorry. You don't"
	line "have a rail pass."
	done

UnknownText_0x5524f:
	text "We hope to see you"
	line "again!"
	done

UnknownText_0x5526a:
	text "We have arrived in"
	line "Goldenrod."

	para "We hope to see you"
	line "again."
	done

UnknownText_0x552a3:
	text "I'm the President."

	para "My dream was to"
	line "build a train that"

	para "is faster than any"
	line "#mon."

	para "It really brings"
	line "Johto much closer"
	cont "to Kanto."
	done

GoldenrodMagnetTrainStationCooltrainerfText1:
	text "The Magnet Train"
	line "is like, zoooom,"
	cont "byun! Shuuu!"

	para "At least when"
	line "it's running…"
	done

GoldenrodMagnetTrainStationCooltrainerfText2:
	text "The Magnet Train"
	line "is like, zoooom,"
	cont "byun! Shuuu!"

	para "It's so cool!"
	done
