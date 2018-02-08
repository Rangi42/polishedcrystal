BattleTowerOutside_MapScriptHeader:
	db 1 ; scene scripts
	scene_script BattleTowerOutsideStepDownTrigger

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  8, 21, ROUTE_40_BATTLE_TOWER_GATE, 3
	warp_event  9, 21, ROUTE_40_BATTLE_TOWER_GATE, 4
	warp_event  8,  9, BATTLE_TOWER_1F, 1 ; hole
	warp_event  9,  9, BATTLE_TOWER_1F, 2 ; hole

	db 2 ; coord events
	coord_event  8,  9, 1, BattleTowerOutsidePanUpTrigger1
	coord_event  9,  9, 1, BattleTowerOutsidePanUpTrigger2

	db 1 ; bg events
	bg_event 10, 10, SIGNPOST_JUMPTEXT, BattleTowerOutsideSignText

	db 6 ; object events
	object_event  6, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, BattleTowerOutsideYoungsterScript, -1
	object_event 13, 11, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, BattleTowerOutsideBeautyScript, -1
	object_event 12, 18, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTowerOutsideSailorText, EVENT_BATTLE_TOWER_CLOSED
	object_event 12, 24, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  8,  9, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BattleTowerOutsideDoorsClosedText, EVENT_BATTLE_TOWER_OPEN
	object_event  9,  9, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BattleTowerOutsideDoorsClosedText, EVENT_BATTLE_TOWER_OPEN

BattleTowerOutsideStepDownTrigger:
	priorityjump .Script
	end

.Script:
	checkcode VAR_YCOORD
	ifnotequal $9, .Done
	checkcode VAR_XCOORD
	ifequal $8, .Down
	ifnotequal $9, .Done
.Down
	applyonemovement PLAYER, step_down
.Done
	setscene $1
	end

BattleTowerOutsidePanUpTrigger1:
	scall BattleTowerOutsidePanUpHelperScript
	warpfacing UP, BATTLE_TOWER_1F, 10, 13
	end

BattleTowerOutsidePanUpTrigger2:
	scall BattleTowerOutsidePanUpHelperScript
	warpfacing UP, BATTLE_TOWER_1F, 11, 13
	end

BattleTowerOutsidePanUpHelperScript:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_person
	waitsfx
	applymovement PLAYER, .PanUpMovement
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	setscene $0
	end

.PanUpMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

BattleTowerOutsideSignText:
	text "Battle Tower"

	para "Take the Ultimate"
	line "Trainer Challenge!"
	done

BattleTowerOutsideYoungsterScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	thistextfaceplayer

	text "Wow, the Battle"
	line "Tower is huge! My"

	para "neck is tired from"
	line "looking up at it."
	done

.OpenText:
	text "Wow, the Battle"
	line "Tower is huge!"

	para "There must be many"
	line "kinds of #mon"
	cont "in there!"
	done

BattleTowerOutsideBeautyScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	thistextfaceplayer

	text "What on earth do"
	line "they do here?"

	para "If the name says"
	line "anything, I guess"

	para "it must be for"
	line "#mon battles."
	done

.OpenText:
	text "You can use only"
	line "three #mon."

	para "It's so hard to"
	line "decide which three"

	para "should go into"
	line "battle…"
	done

BattleTowerOutsideSailorText:
	text "Hehehe, I snuck"
	line "out from work."

	para "I can't bail out"
	line "until I've won!"

	para "I have to win it"
	line "all. That I must!"
	done

BattleTowerOutsideDoorsClosedText:
	text "The Battle Tower's"
	line "doors are closed…"
	done
