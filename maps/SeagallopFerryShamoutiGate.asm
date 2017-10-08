SeagallopFerryShamoutiGate_MapScriptHeader:

.MapTriggers: db 2
	dw SeagallopFerryShamoutiGateTrigger0
	dw SeagallopFerryShamoutiGateTrigger1

.MapCallbacks: db 0

SeagallopFerryShamoutiGate_MapEventHeader:

.Warps: db 1
	warp_def 0, 6, 1, BEAUTIFUL_BEACH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_SAILOR, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryShamoutiGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	person_event SPRITE_TWIN, 1, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, SeagallopFerryShamoutiGateTwinText, -1

const_value set 1
	const SEAGALLOPFERRYSHAMOUTIGATE_SAILOR

SeagallopFerryShamoutiGateTrigger1:
	priorityjump SeagallopFerryShamoutiGate_PlayerArrives
SeagallopFerryShamoutiGateTrigger0:
	end

SeagallopFerryShamoutiGate_PlayerArrives:
	setflag ENGINE_SEEN_SHAMOUTI_ISLAND
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryShamoutiGatePlayerArriveMovementData
	showtext SeagallopFerryShamoutiIslandRefusedText
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive2MovementData
	dotrigger $0
	end

SeagallopFerryShamoutiGateSailorScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalse .OnlyVermilion
	writetext SeagallopFerryShamoutiWhichIslandText
	loadmenudata VermilionValenciaMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .ToVermilion
	if_equal $2, .ToValencia
	jump .RefuseFerry

.OnlyVermilion
	writetext SeagallopFerryShamoutiToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
.ToVermilion
	scall SeagallopFerryShamoutiDepartureScript
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $1
	warp SEAGALLOP_FERRY_VERMILION_GATE, 6, 5
	end

.ToValencia:
	scall SeagallopFerryShamoutiDepartureScript
	warp VALENCIA_PORT, 11, 5
	end

.RefuseFerry
	jumpopenedtext SeagallopFerryShamoutiIslandRefusedText

SeagallopFerryShamoutiDepartureScript:
	writetext SeagallopFerryShamoutiDepartureText
	waitbutton
	closetext
	spriteface SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, DOWN
	pause 10
	applyonemovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, step_down
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYSHAMOUTIGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryShamoutiGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYSHAMOUTIGATE_SAILOR
	end

VermilionValenciaMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 18 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Vermilion City@"
	db "Valencia Island@"
	db "Cancel@"

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

SeagallopFerryShamoutiWhichIslandText:
	text "Welcome back!"
	line "Where to now?"
	done

SeagallopFerryShamoutiToVermilionQuestionText:
	text "Ready to head back"
	line "to Vermilion City?"
	done

SeagallopFerryShamoutiDepartureText:
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
