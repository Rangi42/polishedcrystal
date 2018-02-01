Route2South_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 15, 3, 3, ROUTE_2_GATE
	warp_event 5, 7, 3, VIRIDIAN_FOREST_VIRIDIAN_GATE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 5, 29, SIGNPOST_JUMPTEXT, Route2SignText

	db 7 ; object events
	object_event 10, 23, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBug_maniacRob, -1
	object_event 0, 16, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacDoug, -1
	itemball_event 14, 30, ELIXER, 1, EVENT_ROUTE_2_ELIXER
	cuttree_event 11, 16, EVENT_ROUTE_2_CUT_TREE_3
	cuttree_event 12, 24, EVENT_ROUTE_2_CUT_TREE_4
	cuttree_event 12, 30, EVENT_ROUTE_2_CUT_TREE_5
	object_event 23, 23, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_16_WEST_CUT_TREE_1

TrainerBug_maniacRob:
	trainer BUG_MANIAC, ROB, EVENT_BEAT_BUG_MANIAC_ROB, Bug_maniacRobSeenText, Bug_maniacRobBeatenText, 0, Bug_maniacRobScript

Bug_maniacRobScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac34d

TrainerBug_maniacDoug:
	trainer BUG_MANIAC, DOUG, EVENT_BEAT_BUG_MANIAC_DOUG, Bug_maniacDougSeenText, Bug_maniacDougBeatenText, 0, Bug_maniacDougScript

Bug_maniacDougScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac423

Bug_maniacRobSeenText:
	text "My bug #mon are"
	line "tough. Prepare to"
	cont "lose!"
	done

Bug_maniacRobBeatenText:
	text "I was whipped…"
	done

UnknownText_0x1ac34d:
	text "I'm going to look"
	line "for stronger bug"
	cont "#mon."
	done

Bug_maniacDougSeenText:
	text "Why don't girls"
	line "like bug #mon?"
	done

Bug_maniacDougBeatenText:
	text "No good!"
	done

UnknownText_0x1ac423:
	text "Bug #mon squish"
	line "like plush toys"

	para "when you squeeze"
	line "their bellies."

	para "I love how they"
	line "feel!"
	done

Route2SignText:
	text "Route 2"

	para "Viridian City -"
	line "Pewter City"
	done
