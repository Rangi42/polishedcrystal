const_value set 2
	const BATTLETOWEROUTSIDE_STANDING_YOUNGSTER
	const BATTLETOWEROUTSIDE_BEAUTY
	const BATTLETOWEROUTSIDE_SAILOR
	const BATTLETOWEROUTSIDE_LASS

BattleTowerOutside_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 2

	; callbacks
	dbw MAPCALLBACK_TILES, .Callback1
	dbw MAPCALLBACK_OBJECTS, .Callback2

.Callback1:
	return

.Callback2:
	clearevent EVENT_BATTLE_TOWER_OUTSIDE_SAILOR
	return

.Trigger0:
	priorityjump BattleTowerOutsideStepDownScript
	end

.Trigger1:
	end

BattleTowerOutsideStepDownScript:
	checkcode VAR_YCOORD
	if_not_equal $9, .Done
	checkcode VAR_XCOORD
	if_equal $8, .Down
	if_equal $9, .Down
	jump .Done
.Down
	applymovement PLAYER, BattleTowerOutsideStepDownMovementData
.Done
	dotrigger $1
	end

BattleTowerOutsidePanUpScript1:
	playsound SFX_EXIT_BUILDING
	applymovement PLAYER, BattleTowerOutsideHidePlayerMovementData
	waitsfx
	applymovement PLAYER, BattleTowerOutsidePanUpMovementData
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	dotrigger $0
	warpfacing UP, BATTLE_TOWER_1F, $a, $d
	end

BattleTowerOutsidePanUpScript2:
	playsound SFX_EXIT_BUILDING
	applymovement PLAYER, BattleTowerOutsideHidePlayerMovementData
	waitsfx
	applymovement PLAYER, BattleTowerOutsidePanUpMovementData
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	dotrigger $0
	warpfacing UP, BATTLE_TOWER_1F, $b, $d
	end

BattleTowerOutsideYoungsterScript:
	jumptextfaceplayer BattleTowerOutsideYoungsterText

BattleTowerOutsideBeautyScript:
	jumptextfaceplayer BattleTowerOutsideBeautyText

BattleTowerOutsideSailorScript:
	jumptextfaceplayer BattleTowerOutsideSailorText

MapBattleTowerOutsideSignpost0Script:
	jumptext BattleTowerOutsideText_UltimateChallenge

BattleTowerOutsideStepDownMovementData:
	step_down
	step_end

BattleTowerOutsideHidePlayerMovementData:
	hide_person
	step_end

BattleTowerOutsidePanUpMovementData:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

BattleTowerOutsideYoungsterText:
	text "Wow, the Battle"
	line "Tower is huge!"

	para "There must be many"
	line "kinds of #mon"
	cont "in there!"
	done

BattleTowerOutsideBeautyText:
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

BattleTowerOutsideText_BattleTower:
	text "Battle Tower"
	done

BattleTowerOutsideText_UltimateChallenge:
	text "Battle Tower"

	para "Take the Ultimate"
	line "Trainer Challenge!"
	done

BattleTowerOutsideText_DoorsClosed:
	text "The Battle Tower's"
	line "doors are closed…"
	done

BattleTowerOutsideText_DoorsOpen:
	text "It's open!"
	done

BattleTowerOutside_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $15, $8, 3, ROUTE_40_BATTLE_TOWER_GATE
	warp_def $15, $9, 4, ROUTE_40_BATTLE_TOWER_GATE
	warp_def $9, $8, 1, BATTLE_TOWER_1F ; hole
	warp_def $9, $9, 2, BATTLE_TOWER_1F ; hole

.XYTriggers:
	db 2
	xy_trigger 1, $9, $8, $0, BattleTowerOutsidePanUpScript1, $0, $0
	xy_trigger 1, $9, $9, $0, BattleTowerOutsidePanUpScript2, $0, $0

.Signposts:
	db 1
	signpost 10, 10, SIGNPOST_READ, MapBattleTowerOutsideSignpost0Script

.PersonEvents:
	db 4
	person_event SPRITE_STANDING_YOUNGSTER, 12, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BattleTowerOutsideYoungsterScript, -1
	person_event SPRITE_BEAUTY, 11, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BattleTowerOutsideBeautyScript, -1
	person_event SPRITE_SAILOR, 18, 12, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTowerOutsideSailorScript, EVENT_BATTLE_TOWER_OUTSIDE_SAILOR
	person_event SPRITE_LASS, 24, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
