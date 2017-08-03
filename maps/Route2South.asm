Route2South_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route2South_MapEventHeader:

.Warps: db 2
	warp_def $3, $f, 3, ROUTE_2_GATE
	warp_def $7, $5, 3, VIRIDIAN_FOREST_VIRIDIAN_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 29, 5, SIGNPOST_READ, Route2Sign

.PersonEvents: db 7
	person_event SPRITE_BUG_MANIAC, 23, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBug_maniacRob, -1
	person_event SPRITE_BUG_MANIAC, 16, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacDoug, -1
	person_event SPRITE_BALL_CUT_FRUIT, 30, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route2SouthElixer, EVENT_ROUTE_2_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 16, 11, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2SouthCutTree, EVENT_ROUTE_2_CUT_TREE_3
	person_event SPRITE_BALL_CUT_FRUIT, 24, 12, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2SouthCutTree, EVENT_ROUTE_2_CUT_TREE_4
	person_event SPRITE_BALL_CUT_FRUIT, 30, 12, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2SouthCutTree, EVENT_ROUTE_2_CUT_TREE_5
	person_event SPRITE_BALL_CUT_FRUIT, 23, 23, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_16_WEST_CUT_TREE_1

TrainerBug_maniacRob:
	trainer EVENT_BEAT_BUG_MANIAC_ROB, BUG_MANIAC, ROB, Bug_maniacRobSeenText, Bug_maniacRobBeatenText, 0, Bug_maniacRobScript

Bug_maniacRobScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ac34d
	waitbutton
	closetext
	end

TrainerBug_maniacDoug:
	trainer EVENT_BEAT_BUG_MANIAC_DOUG, BUG_MANIAC, DOUG, Bug_maniacDougSeenText, Bug_maniacDougBeatenText, 0, Bug_maniacDougScript

Bug_maniacDougScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ac423
	waitbutton
	closetext
	end

Route2SouthCutTree:
	jumpstd cuttree

Route2Sign:
	jumptext Route2SignText

Route2SouthElixer:
	itemball ELIXER

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
