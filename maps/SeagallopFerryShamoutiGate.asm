const_value set 2
	const SEAGALLOPFERRYSHAMOUTIGATE_SAILOR
	const SEAGALLOPFERRYSHAMOUTIGATE_TWIN

SeagallopFerryShamoutiGate_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger0, 0
	dw .Trigger1, 0

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	priorityjump SeagallopFerryShamoutiGate_PlayerArrives
	end

SeagallopFerryShamoutiGate_PlayerArrives:
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryShamoutiGatePlayerArriveMovementData
	opentext
	writetext SeagallopFerryShamoutiIslandRefusedText
	waitbutton
	closetext
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive2MovementData
	dotrigger $0
	end

SeagallopFerryShamoutiGateSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryShamoutiToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
	writetext SeagallopFerryShamoutiToVermilionText
	waitbutton
	closetext
	spriteface SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, DOWN
	pause 10
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorDepartMovementData
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYSHAMOUTIGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryShamoutiGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYSHAMOUTIGATE_SAILOR
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $1
	warp SEAGALLOP_FERRY_VERMILION_GATE, $6, $5
	end

.RefuseFerry
	writetext SeagallopFerryShamoutiIslandRefusedText
	waitbutton
	closetext
	end

SeagallopFerryShamoutiGateTwinScript:
	jumptextfaceplayer SeagallopFerryShamoutiGateTwinText

SeagallopFerryShamoutiGateSailorDepartMovementData:
	step_down
	step_end

SeagallopFerryShamoutiGatePlayerDepartMovementData:
	step_down
	step_down
	step_end

SeagallopFerryShamoutiGatePlayerArriveMovementData:
	step_up
	step_up
	step_up
	turn_head_down
	step_end

SeagallopFerryShamoutiGateSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

SeagallopFerryShamoutiGateSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryShamoutiToVermilionQuestionText:
	text "Ready to head back"
	line "to Vermilion City?"
	done

SeagallopFerryShamoutiToVermilionText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryShamoutiIslandRefusedText:
	text "I'll be waiting"
	line "right here."
	done

SeagallopFerryShamoutiGateTwinText:
	text "I'm here to greet"
	line "the tourists."

	para "Have a nice stay!"
	done

SeagallopFerryShamoutiGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $6, 1, BEAUTIFUL_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_SAILOR, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryShamoutiGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	person_event SPRITE_TWIN, 1, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryShamoutiGateTwinScript, -1
