SeagallopFerryShamoutiGate_MapScriptHeader:
	def_scene_scripts
	scene_script SeagallopFerryShamoutiGateAskEnterScene, SCENE_SEAGALLOPFERRYSHAMOUTIGATE_ASK_ENTER
	scene_script SeagallopFerryShamoutiGateLeaveScene, SCENE_SEAGALLOPFERRYSHAMOUTIGATE_LEAVE

	def_callbacks

	def_warp_events
	warp_event  6,  0, BEAUTIFUL_BEACH, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SeagallopFerryShamoutiGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  4,  1, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SeagallopFerryShamoutiGateTwinText, -1

	object_const_def
	const SEAGALLOPFERRYSHAMOUTIGATE_SAILOR

SeagallopFerryShamoutiGateLeaveScene:
	sdefer SeagallopFerryShamoutiGate_PlayerArrives
SeagallopFerryShamoutiGateAskEnterScene:
	end

SeagallopFerryShamoutiGate_PlayerArrives:
	setflag ENGINE_SEEN_SHAMOUTI_ISLAND
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryShamoutiGatePlayerArriveMovementData
	showtext SeagallopFerryShamoutiIslandRefusedText
	applymovement SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, SeagallopFerryShamoutiGateSailorArrive2MovementData
	setscene SCENE_SEAGALLOPFERRYSHAMOUTIGATE_ASK_ENTER
	end

SeagallopFerryShamoutiGateSailorScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalsefwd .OnlyVermilion
	writetext SeagallopFerryShamoutiWhichIslandText
	loadmenu VermilionValenciaMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .ToVermilion
	ifequalfwd $2, .ToValencia
	sjumpfwd .RefuseFerry

.OnlyVermilion
	writetext SeagallopFerryShamoutiToVermilionQuestionText
	yesorno
	iffalsefwd .RefuseFerry
.ToVermilion
	scall SeagallopFerryShamoutiDepartureScript
	setmapscene SEAGALLOP_FERRY_VERMILION_GATE, SCENE_SEAGALLOPFERRYVERMILIONGATE_LEAVE
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
	turnobject SEAGALLOPFERRYSHAMOUTIGATE_SAILOR, DOWN
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
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 18, 11
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
