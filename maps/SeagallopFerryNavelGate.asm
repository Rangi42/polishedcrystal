SeagallopFerryNavelGate_MapScriptHeader:

.MapTriggers: db 2
	dw SeagallopFerryNavelGateTrigger0
	dw SeagallopFerryNavelGateTrigger1

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, SeagallopFerryNavelGateVisited

SeagallopFerryNavelGate_MapEventHeader:

.Warps: db 1
	warp_def 0, 6, 1, NAVEL_ROCK_OUTSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_SAILOR, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryNavelGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY

const_value set 1
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
	dotrigger $0
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
	spriteface SEAGALLOPFERRYNAVELGATE_SAILOR, DOWN
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
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $1
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
