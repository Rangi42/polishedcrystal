EcruteakHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, EcruteakHouseInitializeSages

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 3
	warp_event  5, 17, ECRUTEAK_CITY, 3
	warp_event  5,  3, ECRUTEAK_HOUSE, 4
	warp_event 17, 15, ECRUTEAK_HOUSE, 3
	warp_event 17,  3, WISE_TRIOS_ROOM, 3

	def_coord_events
	coord_event  4,  7, 0, EcruteakHouse_XYTrigger1
	coord_event  5,  7, 0, EcruteakHouse_XYTrigger2

	def_bg_events

	def_object_events
	object_event  4,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_RANG_CLEAR_BELL_1
	object_event  5,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_RANG_CLEAR_BELL_2
	object_event  6,  9, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceWanderingSageScript, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	object_event  3, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakTinTowerEntranceGrampsText, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE

	object_const_def
	const ECRUTEAKHOUSE_SAGE1
	const ECRUTEAKHOUSE_SAGE2

EcruteakHouseInitializeSages:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue .DontBlockTower
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .DontBlockTower
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .BlockTower
	return

.BlockTower:
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_RANG_CLEAR_BELL_2
	setevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	checkkeyitem CLEAR_BELL
	iftrue .NoClearBell
	setscene $0
.NoClearBell:
	return

.DontBlockTower:
	clearevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	return

EcruteakHouse_XYTrigger1:
	checkevent EVENT_RANG_CLEAR_BELL_2
	iftrue EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE2, EcruteakTinTowerEntranceSageBlocksLeftMovement
	moveobject ECRUTEAKHOUSE_SAGE1, 4, 6
	appear ECRUTEAKHOUSE_SAGE1
	pause 5
	disappear ECRUTEAKHOUSE_SAGE2
	end

EcruteakHouse_XYTrigger2:
	checkevent EVENT_RANG_CLEAR_BELL_1
	iftrue EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE1, EcruteakTinTowerEntranceSageBlocksRightMovement
	moveobject ECRUTEAKHOUSE_SAGE2, 5, 6
	appear ECRUTEAKHOUSE_SAGE2
	pause 5
	disappear ECRUTEAKHOUSE_SAGE1
	end

EcruteakHouse_XYTrigger_DontMove:
	end

EcruteakTinTowerEntranceSageScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .CheckForClearBell
	checkflag ENGINE_FOGBADGE
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_GotFogBadge
	jumpopenedtext EcruteakTinTowerEntranceSageText

.CheckForClearBell:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_PleaseDoGoOn
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_HeardClearBell
	checkkeyitem CLEAR_BELL
	iftrue .RingClearBell
	jumpopenedtext EcruteakTinTowerEntranceSageText_NoClearBell

.RingClearBell:
	writetext EcruteakTinTowerEntranceSageText_HearsClearBell
	waitbutton
	closetext
	setscene $1
	setevent EVENT_RANG_CLEAR_BELL_2
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

EcruteakTinTowerEntranceWanderingSageScript:
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue_jumptextfaceplayer EcruteakTinTowerEntranceWanderingSageText_GotClearBell
	jumptextfaceplayer EcruteakTinTowerEntranceWanderingSageText

EcruteakTinTowerEntranceSageBlocksLeftMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	turn_head_down
	step_end

EcruteakTinTowerEntranceSageBlocksRightMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	turn_head_down
	step_end

EcruteakTinTowerEntranceSageText:
	text "Bell Tower is off"
	line "limits to anyone"

	para "without Ecruteak"
	line "Gym's Badge."

	para "Sorry, but you'll"
	line "have to leave."
	done

EcruteakTinTowerEntranceSageText_GotFogBadge:
	text "Bell Tower is off"
	line "limits to anyone"

	para "without Ecruteak"
	line "Gym's Badge."

	para "Ah!"

	para "Ecruteak's Gym"
	line "Badge! Please, go"
	cont "right through."
	done

EcruteakTinTowerEntranceSageText_NoClearBell:
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "…What soothes the"
	line "soul…"

	para "The Wise Trio say"
	line "things that are so"

	para "very difficult to"
	line "understand…"
	done

EcruteakTinTowerEntranceSageText_HearsClearBell:
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "………………"

	para "Ah!"

	para "The sound of that"
	line "Clear Bell!"

	para "It… It's sublime!"

	para "I've never heard"
	line "so beautiful a"
	cont "sound before!"

	para "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "Bell Tower."

	para "Please, do go on."
	done

EcruteakTinTowerEntranceSageText_PleaseDoGoOn:
	text "Please, do go on."
	done

EcruteakTinTowerEntranceSageText_HeardClearBell:
	text "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "Bell Tower."

	para "Please, do go on."
	done

EcruteakTinTowerEntranceWanderingSageText:
	text "The Bell Tower"
	line "ahead is a nine-"

	para "tier tower of"
	line "divine beauty."

	para "It soothes the"
	line "soul of all who"
	cont "see it."
	done

EcruteakTinTowerEntranceWanderingSageText_GotClearBell:
	text "The Bell Tower"
	line "shook! A #mon"

	para "must have returned"
	line "to the top!"
	done

EcruteakTinTowerEntranceGrampsText:
	text "Two towers…"
	line "Two #mon…"

	para "But when one"
	line "burned down, both"

	para "#mon flew away,"
	line "never to return."
	done
