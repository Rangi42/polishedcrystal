FastShip1F_MapScriptHeader:
	def_scene_scripts
	scene_script FastShip1FTrigger0
	scene_script FastShip1FTrigger1

	def_callbacks

	def_warp_events
	warp_event 25,  1, FAST_SHIP_1F, -1
	warp_event 27,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 1
	warp_event 23,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 2
	warp_event 19,  8, FAST_SHIP_CABINS_NNW_NNE_NE, 3
	warp_event 15,  8, FAST_SHIP_CABINS_SW_SSW_NW, 1
	warp_event 15, 15, FAST_SHIP_CABINS_SW_SSW_NW, 2
	warp_event 19, 15, FAST_SHIP_CABINS_SW_SSW_NW, 4
	warp_event 23, 15, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 1
	warp_event 27, 15, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 3
	warp_event  3, 15, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, 5
	warp_event  6, 14, FAST_SHIP_B1F, 1
	warp_event 30, 14, FAST_SHIP_B1F, 2

	def_coord_events
	coord_event 24,  6, 2, WorriedGrandpaTriggerLeft
	coord_event 25,  6, 2, WorriedGrandpaTriggerRight

	def_bg_events

	def_object_events
	object_event 25,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FastShip1FSailor1Script, -1
	object_event 19,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_FAST_SHIP_1F_GENTLEMAN
	object_event 14,  7, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FastShip1FSailor2Script, -1
	object_event 22, 17, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FastShip1FSailor3Text, -1

	object_const_def
	const FASTSHIP1F_SAILOR1
	const FASTSHIP1F_GENTLEMAN

FastShip1FTrigger1:
	priorityjump FastShip1FPriorityJump2
FastShip1FTrigger0:
	end

FastShip1FPriorityJump2:
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideMovement
	applymovement PLAYER, FastShip1F_PlayerEntersShipMovement
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorBlocksDoorMovement
	pause 30
	playsound SFX_BOAT
	earthquake 30
	blackoutmod FAST_SHIP_CABINS_SW_SSW_NW
	clearevent EVENT_FAST_SHIP_HAS_ARRIVED
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .SkipGrandpa
	setscene $2
	end

.SkipGrandpa:
	setscene $0
	end

FastShip1FSailor1Script:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftrue .Arrived
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue_jumpopenedtext FastShip1FSailor1Text_ToOlivine
	jumpthisopenedtext

	text "Fast Ship S.S.Aqua"
	line "is en route to"
	cont "Vermilion City."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
	done

.Arrived:
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue ._Olivine
	writetext FastShip1FSailor1Text_InVermilion
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	setmapscene VERMILION_PORT, $1
	warp VERMILION_PORT, 7, 17
	end

._Olivine:
	writetext FastShip1FSailor1Text_InOlivine
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	setmapscene OLIVINE_PORT, $1
	warp OLIVINE_PORT, 7, 23
	end

.LetThePlayerOut:
	checkcode VAR_FACING
	ifequal RIGHT, .YouAreFacingRight
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideMovement
	applymovement PLAYER, FastShip1F_PlayerLeavesShipMovement
	end

.YouAreFacingRight:
	applymovement FASTSHIP1F_SAILOR1, FastShip1F_SailorStepAsideDownMovement
	applymovement PLAYER, FastShip1F_PlayerLeavesShipRightMovement
	end

FastShip1FSailor2Script:
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue_jumptextfaceplayer FastShip1FSailor2Text
	jumptextfaceplayer FastShip1FSailor2Text_FirstTime

WorriedGrandpaTriggerRight:
	moveobject FASTSHIP1F_GENTLEMAN, 20, 6
WorriedGrandpaTriggerLeft:
	appear FASTSHIP1F_GENTLEMAN
	applymovement FASTSHIP1F_GENTLEMAN, FastShip1F_GrandpaRunsInMovement
	playsound SFX_TACKLE
	applymovement PLAYER, FastShip1F_PlayerHitByGrandpaMovement
	applyonemovement FASTSHIP1F_GENTLEMAN, step_right
	showtext FastShip1FGrandpaText
	turnobject PLAYER, RIGHT
	applymovement FASTSHIP1F_GENTLEMAN, FastShip1F_GrandpaRunsOutMovement
	disappear FASTSHIP1F_GENTLEMAN
	setscene $0
	end

FastShip1F_SailorStepAsideMovement:
	slow_step_left
	turn_head_right
	step_end

FastShip1F_SailorBlocksDoorMovement:
	slow_step_right
	turn_head_down
	step_end

FastShip1F_SailorStepAsideDownMovement:
	slow_step_down
	turn_head_up
	step_end

FastShip1F_PlayerEntersShipMovement:
	step_down
	step_down
	turn_head_down
	step_end

FastShip1F_GrandpaRunsInMovement:
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	step_end

FastShip1F_GrandpaRunsOutMovement:
	run_step_down
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	run_step_down
	run_step_down
	run_step_down
	run_step_down
	step_end

FastShip1F_PlayerHitByGrandpaMovement:
	run_step_right
	turn_head_left
	step_end

FastShip1F_PlayerLeavesShipMovement:
	step_up
	step_up
	step_end

FastShip1F_PlayerLeavesShipRightMovement:
	step_right
	step_up
	step_end

FastShip1FSailor1Text_ToOlivine:
	text "Fast Ship S.S.Aqua"
	line "is en route to"
	cont "Olivine City."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
	done

FastShip1FSailor2Text_FirstTime:
	text "Here's your cabin."

	para "If your #mon"
	line "are hurt, take a"
	cont "nap in the bed."

	para "That will heal"
	line "them."
	done

FastShip1FSailor2Text:
	text "Here's your cabin."

	para "You can heal your"
	line "#mon by taking"
	cont "a nap in the bed."

	para "The ship will"
	line "arrive while"
	cont "you're sleeping."
	done

FastShip1FSailor3Text:
	text "The passengers are"
	line "all trainers."

	para "They're all itch-"
	line "ing to battle in"
	cont "their cabins."
	done

FastShip1FGrandpaText:
	text "Whoa! Excuse me."
	line "I was in a hurry!"

	para "My granddaughter"
	line "is missing!"

	para "She's just a wee"
	line "girl. If you see"

	para "her, please let me"
	line "know!"
	done

FastShip1FSailor1Text_InOlivine:
	text "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Olivine City."
	done

FastShip1FSailor1Text_InVermilion:
	text "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Vermilion City."
	done
