const_value set 2
	const SEAGALLOPFERRYFARAWAYGATE_SAILOR

SeagallopFerryFarawayGate_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw .Trigger0, 0

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump SeagallopFerryFarawayGate_PlayerArrives
	end

SeagallopFerryFarawayGate_PlayerArrives:
	applymovement SEAGALLOPFERRYFARAWAYGATE_SAILOR, SeagallopFerryFarawayGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryFarawayGatePlayerArriveMovementData
	opentext
	writetext SeagallopFerryFarawayIslandRefusedText
	waitbutton
	closetext
	applymovement SEAGALLOPFERRYFARAWAYGATE_SAILOR, SeagallopFerryFarawayGateSailorArrive2MovementData
	dotrigger $1
	end

SeagallopFerryFarawayGateSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryFarawayToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
	writetext SeagallopFerryFarawayToVermilionText
	waitbutton
	closetext
	spriteface SEAGALLOPFERRYFARAWAYGATE_SAILOR, DOWN
	pause 10
	applymovement SEAGALLOPFERRYFARAWAYGATE_SAILOR, SeagallopFerryFarawayGateSailorDepartMovementData
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYFARAWAYGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryFarawayGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYFARAWAYGATE_SAILOR
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $0
	warp SEAGALLOP_FERRY_VERMILION_GATE, $6, $5
	end

.RefuseFerry
	writetext SeagallopFerryFarawayIslandRefusedText
	waitbutton
	closetext
	end

SeagallopFerryFarawayGateSailorDepartMovementData:
	step_down
	step_end

SeagallopFerryFarawayGatePlayerDepartMovementData:
	step_down
	step_down
	step_end

SeagallopFerryFarawayGatePlayerArriveMovementData:
	step_up
	step_up
	step_up
	step_end

SeagallopFerryFarawayGateSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

SeagallopFerryFarawayGateSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryFarawayToVermilionQuestionText:
	text "Want to return to"
	line "Vermilion City?"
	done

SeagallopFerryFarawayToVermilionText:
	text "Set course for"
	line "Vermilion City!"
	done

SeagallopFerryFarawayIslandRefusedText:
	text "I'll wait for you"
	line "here."
	done

SeagallopFerryFarawayGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $6, 1, FARAWAY_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_SAILOR, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryFarawayGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
