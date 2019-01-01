SaffronTrainStation_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  8, 17, SAFFRON_CITY, 6
	warp_event  9, 17, SAFFRON_CITY, 6
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	db 1 ; coord events
	coord_event 11,  6, 0, Script_ArriveFromGoldenrod

	db 0 ; bg events

	db 4 ; object events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OfficerScript_0x18a81e, -1
	object_event 10, 14, SPRITE_GYM_GUY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GymGuyScript_0x18a875, -1
	object_event  6, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18aaab, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event  6, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18ab20, EVENT_SAFFRON_TRAIN_STATION_POPULATION

	const_def 1 ; object constants
	const SAFFRONTRAINSTATION_OFFICER

OfficerScript_0x18a81e:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumptextfaceplayer UnknownText_0x18a8a9
	faceplayer
	opentext
	writetext UnknownText_0x18a8dd
	yesorno
	iffalse_jumpopenedtext UnknownText_0x18a978
	checkitem PASS
	iffalse_jumpopenedtext UnknownText_0x18a956
	writetext UnknownText_0x18a917
	waitbutton
	closetext
	applymovement SAFFRONTRAINSTATION_OFFICER, MovementData_0x18a88f
	applymovement PLAYER, MovementData_0x18a898
	writebyte $1
	special Special_MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applyonemovement PLAYER, turn_head_down
	wait 36
	end

Script_ArriveFromGoldenrod:
	applymovement SAFFRONTRAINSTATION_OFFICER, MovementData_0x18a88f
	applymovement PLAYER, MovementData_0x18a8a1
	applymovement SAFFRONTRAINSTATION_OFFICER, MovementData_0x18a894
	jumptext UnknownText_0x18a993

GymGuyScript_0x18a875:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x18aa61
	jumptextfaceplayer UnknownText_0x18a9ca

MovementData_0x18a88f:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

MovementData_0x18a894:
	step_left
	step_down
	step_down
	step_end

MovementData_0x18a898:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x18a8a1:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	turn_head_up
	step_end

UnknownText_0x18a8a9:
	text "I'm sorry, but the"
	line "Magnet Train isn't"
	cont "operating now."
	done

UnknownText_0x18a8dd:
	text "We'll soon depart"
	line "for Goldenrod."

	para "Are you coming on"
	line "board?"
	done

UnknownText_0x18a917:
	text "May I see your"
	line "rail pass, please?"

	para "OK. Right this"
	line "way, please."
	done

UnknownText_0x18a956:
	text "Sorry, but you"
	line "don't have a pass."
	done

UnknownText_0x18a978:
	text "We hope to see you"
	line "again."
	done

UnknownText_0x18a993:
	text "We have arrived in"
	line "Saffron."

	para "We hope to see you"
	line "again."
	done

UnknownText_0x18a9ca:
	text "The Magnet Train"
	line "is a super-modern"

	para "rail liner that"
	line "uses electricity"

	para "and magnets to"
	line "attain incredible"
	cont "speed."

	para "However, if there"
	line "isn't any elec-"
	cont "tricity…"
	done

UnknownText_0x18aa61:
	text "Whew…"

	para "How many times"
	line "have I gone back"

	para "and forth between"
	line "Kanto and Johto?"
	done

UnknownText_0x18aaab:
	text "Before the Magnet"
	line "Train Station was"

	para "built, there was a"
	line "house there."

	para "A little girl"
	line "named Copycat used"
	cont "to live there."
	done

UnknownText_0x18ab20:
	text "Hi. Do you have a"
	line "rail pass? I have"

	para "one. All the peo-"
	line "ple in Saffron who"

	para "ride the Magnet"
	line "Train have passes."
	done
