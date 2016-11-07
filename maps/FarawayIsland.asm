const_value set 2
	const FARAWAYISLAND_SAILOR
	const FARAWAYISLAND_LAWRENCE

FarawayIsland_MapScriptHeader:
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
	priorityjump FarawayIsland_PlayerArrives
	end

FarawayIsland_PlayerArrives:
	applymovement FARAWAYISLAND_SAILOR, FarawayIslandSailorArrive1MovementData
	applymovement PLAYER, FarawayIslandPlayerArriveMovementData
	opentext
	writetext SeagallopFerryFarawayIslandRefusedText
	waitbutton
	closetext
	applymovement FARAWAYISLAND_SAILOR, FarawayIslandSailorArrive2MovementData
	dotrigger $0
	end

FarawayIslandSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryFarawayToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
	writetext SeagallopFerryFarawayToVermilionText
	waitbutton
	closetext
	spriteface FARAWAYISLAND_SAILOR, DOWN
	pause 10
	applymovement FARAWAYISLAND_SAILOR, FarawayIslandSailorDepartMovementData
	playsound SFX_EXIT_BUILDING
	disappear FARAWAYISLAND_SAILOR
	waitsfx
	applymovement PLAYER, FarawayIslandPlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear FARAWAYISLAND_SAILOR
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $1
	warp SEAGALLOP_FERRY_VERMILION_GATE, $6, $5
	end

.RefuseFerry
	writetext SeagallopFerryFarawayIslandRefusedText
	waitbutton
	closetext
	end

FarawayIslandSign:
	jumptext FarawayIslandSignText

FarawayIslandSailorDepartMovementData:
	turn_head_down
	step_end

FarawayIslandPlayerDepartMovementData:
	step_down
	step_end

FarawayIslandPlayerArriveMovementData:
	step_up
	step_up
	turn_head_down
	step_end

FarawayIslandSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

FarawayIslandSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryFarawayToVermilionQuestionText:
	text "Ready to head back"
	line "to Vermilion City?"
	done

SeagallopFerryFarawayToVermilionText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryFarawayIslandRefusedText:
	text "I'll be waiting"
	line "right here."
	done

FarawayIslandSignText:
	text "The writing is"
	line "fading as if it"

	para "was written a long"
	line "time ago…"

	para "<``>…ber, 6th day"

	para "If any human…sets"
	line "foot here…"
	cont "again…et it be a"
	cont "kindhearted pers…"

	para "…ith that hope,"
	line "I depar…"

	para "…ji<''>"
	done

FarawayIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $8, $16, 1, FARAWAY_JUNGLE
	warp_def $8, $17, 2, FARAWAY_JUNGLE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 34, 4, SIGNPOST_READ, FarawayIslandSign

.PersonEvents:
	db 2
	person_event SPRITE_SAILOR, 42, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FarawayIslandSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	person_event SPRITE_LAWRENCE, 37, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
