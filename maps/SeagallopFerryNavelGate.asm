SeagallopFerryNavelGate_MapScriptHeader:
	db 2 ; scene scripts
	scene_script SeagallopFerryNavelGateTrigger0
	scene_script SeagallopFerryNavelGateTrigger1

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, SeagallopFerryNavelGateVisited

	db 1 ; warp events
	warp_event  6,  0, NAVEL_ROCK_OUTSIDE, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  6,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryNavelGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY

	const_def 1 ; object constants
	const SEAGALLOPFERRYNAVELGATE_SAILOR

SeagallopFerryNavelGateTrigger1:
	priorityjump SeagallopFerryNavelGate_PlayerArrives
SeagallopFerryNavelGateTrigger0:
	end

SeagallopFerryNavelGateVisited:
	setevent EVENT_VISITED_NAVEL_ROCK
	return

SeagallopFerryNavelGate_PlayerArrives:
	applymovement SEAGALLOPFERRYNAVELGATE_SAILOR, SeagallopFerryNavelGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryNavelGatePlayerArriveMovementData
	showtext SeagallopFerryNavelRockRefusedText
	applymovement SEAGALLOPFERRYNAVELGATE_SAILOR, SeagallopFerryNavelGateSailorArrive2MovementData
	setscene $0
	end

SeagallopFerryNavelGateSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryNavelToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
	writetext SeagallopFerryNavelToVermilionText
	waitbutton
	closetext
	turnobject SEAGALLOPFERRYNAVELGATE_SAILOR, DOWN
	pause 10
	applyonemovement SEAGALLOPFERRYNAVELGATE_SAILOR, step_down
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYNAVELGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryNavelGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYNAVELGATE_SAILOR
	setmapscene SEAGALLOP_FERRY_VERMILION_GATE, $1
	warp SEAGALLOP_FERRY_VERMILION_GATE, 6, 5
	end

.RefuseFerry
	jumpopenedtext SeagallopFerryNavelRockRefusedText

SeagallopFerryNavelGatePlayerDepartMovementData:
	step_down
	step_down
	step_end

SeagallopFerryNavelGatePlayerArriveMovementData:
	step_up
	step_up
	step_up
	turn_head_down
	step_end

SeagallopFerryNavelGateSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

SeagallopFerryNavelGateSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryNavelToVermilionQuestionText:
	text "Ready to head back"
	line "to Vermilion City?"
	done

SeagallopFerryNavelToVermilionText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryNavelRockRefusedText:
	text "I'll be waiting"
	line "right here."
	done
