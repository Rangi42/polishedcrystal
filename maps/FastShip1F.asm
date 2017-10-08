FastShip1F_MapScriptHeader:

.MapTriggers: db 2
	dw FastShip1FTrigger0
	dw FastShip1FTrigger1

.MapCallbacks: db 0

FastShip1F_MapEventHeader:

.Warps: db 12
	warp_def 1, 25, -1, FAST_SHIP_1F
	warp_def 8, 27, 1, FAST_SHIP_CABINS_NNW_NNE_NE
	warp_def 8, 23, 2, FAST_SHIP_CABINS_NNW_NNE_NE
	warp_def 8, 19, 3, FAST_SHIP_CABINS_NNW_NNE_NE
	warp_def 8, 15, 1, FAST_SHIP_CABINS_SW_SSW_NW
	warp_def 15, 15, 2, FAST_SHIP_CABINS_SW_SSW_NW
	warp_def 15, 19, 4, FAST_SHIP_CABINS_SW_SSW_NW
	warp_def 15, 23, 1, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	warp_def 15, 27, 3, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	warp_def 15, 3, 5, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	warp_def 14, 6, 1, FAST_SHIP_B1F
	warp_def 14, 30, 2, FAST_SHIP_B1F

.XYTriggers: db 2
	xy_trigger 2, 6, 24, WorriedGrandpaTriggerLeft
	xy_trigger 2, 6, 25, WorriedGrandpaTriggerRight

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_SAILOR, 2, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x75160, -1
	person_event SPRITE_GENTLEMAN, 6, 19, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_FAST_SHIP_1F_GENTLEMAN
	person_event SPRITE_SAILOR, 7, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x751d0, -1
	person_event SPRITE_SAILOR, 17, 22, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x753c0, -1

const_value set 1
	const FASTSHIP1F_SAILOR1
	const FASTSHIP1F_GENTLEMAN

FastShip1FTrigger1:
	priorityjump FastShip1FPriorityJump2
FastShip1FTrigger0:
	end

FastShip1FPriorityJump2:
	applymovement FASTSHIP1F_SAILOR1, MovementData_0x7520e
	applymovement PLAYER, MovementData_0x75217
	applymovement FASTSHIP1F_SAILOR1, MovementData_0x75211
	pause 30
	playsound SFX_BOAT
	earthquake 30
	blackoutmod FAST_SHIP_CABINS_SW_SSW_NW
	clearevent EVENT_FAST_SHIP_HAS_ARRIVED
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .SkipGrandpa
	dotrigger $2
	end

.SkipGrandpa:
	dotrigger $0
	end

SailorScript_0x75160:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftrue .Arrived
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue .Olivine
	jumpopenedtext UnknownText_0x7523b

.Olivine:
	jumpopenedtext UnknownText_0x7529b

.Arrived:
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue ._Olivine
	writetext UnknownText_0x754be
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	domaptrigger VERMILION_PORT, $1
	warp VERMILION_PORT, 7, 17
	end

._Olivine:
	writetext UnknownText_0x7548d
	waitbutton
	closetext
	scall .LetThePlayerOut
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	domaptrigger OLIVINE_PORT, $1
	warp OLIVINE_PORT, 7, 23
	end

.LetThePlayerOut:
	checkcode VAR_FACING
	if_equal RIGHT, .YouAreFacingRight
	applymovement FASTSHIP1F_SAILOR1, MovementData_0x7520e
	applymovement PLAYER, MovementData_0x75235
	end

.YouAreFacingRight:
	applymovement FASTSHIP1F_SAILOR1, MovementData_0x75214
	applymovement PLAYER, MovementData_0x75238
	end

SailorScript_0x751d0:
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue_jumptextfaceplayer UnknownText_0x7534f
	jumptextfaceplayer UnknownText_0x752f9

WorriedGrandpaTriggerRight:
	moveperson FASTSHIP1F_GENTLEMAN, 20, 6
WorriedGrandpaTriggerLeft:
	appear FASTSHIP1F_GENTLEMAN
	applymovement FASTSHIP1F_GENTLEMAN, MovementData_0x7521b
	playsound SFX_TACKLE
	applymovement PLAYER, MovementData_0x7522e
	applyonemovement FASTSHIP1F_GENTLEMAN, step_right
	showtext UnknownText_0x75412
	spriteface PLAYER, RIGHT
	applymovement FASTSHIP1F_GENTLEMAN, MovementData_0x75222
	disappear FASTSHIP1F_GENTLEMAN
	dotrigger $0
	end

MovementData_0x7520e:
	slow_step_left
	turn_head_right
	step_end

MovementData_0x75211:
	slow_step_right
	turn_head_down
	step_end

MovementData_0x75214:
	slow_step_down
	turn_head_up
	step_end

MovementData_0x75217:
	step_down
	step_down
	turn_head_down
	step_end

MovementData_0x7521b:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

MovementData_0x75222:
	big_step_down
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	step_end

MovementData_0x7522e:
	big_step_right
	turn_head_left
	step_end

MovementData_0x75235:
	step_up
	step_up
	step_end

MovementData_0x75238:
	step_right
	step_up
	step_end

UnknownText_0x7523b:
	text "Fast Ship S.S.Aqua"
	line "is en route to"
	cont "Vermilion City."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
	done

UnknownText_0x7529b:
	text "Fast Ship S.S.Aqua"
	line "is en route to"
	cont "Olivine City."

	para "We will make an"
	line "announcement when"
	cont "we arrive."
	done

UnknownText_0x752f9:
	text "Here's your cabin."

	para "If your #mon"
	line "are hurt, take a"
	cont "nap in the bed."

	para "That will heal"
	line "them."
	done

UnknownText_0x7534f:
	text "Here's your cabin."

	para "You can heal your"
	line "#mon by taking"
	cont "a nap in the bed."

	para "The ship will"
	line "arrive while"
	cont "you're sleeping."
	done

UnknownText_0x753c0:
	text "The passengers are"
	line "all trainers."

	para "They're all itch-"
	line "ing to battle in"
	cont "their cabins."
	done

UnknownText_0x75412:
	text "Whoa! Excuse me."
	line "I was in a hurry!"

	para "My granddaughter"
	line "is missing!"

	para "She's just a wee"
	line "girl. If you see"

	para "her, please let me"
	line "know!"
	done

UnknownText_0x7548d:
	text "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Olivine City."
	done

UnknownText_0x754be:
	text "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Vermilion City."
	done
