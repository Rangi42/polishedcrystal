const_value set 2
	const ROUTE2_BUG_MANIAC1
	const ROUTE2_BUG_MANIAC2
	const ROUTE2_BUG_MANIAC3
	const ROUTE2_POKE_BALL1
	const ROUTE2_POKE_BALL2
	const ROUTE2_CUT_TREE1
	const ROUTE2_CUT_TREE2
	const ROUTE2_CUT_TREE3
	const ROUTE2_CUT_TREE4
	const ROUTE2_CUT_TREE5
	const ROUTE2_FRUIT_TREE

Route2_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerBug_maniacRob:
	trainer EVENT_BEAT_BUG_MANIAC_ROB, BUG_MANIAC, ROB, Bug_maniacRobSeenText, Bug_maniacRobBeatenText, 0, Bug_maniacRobScript

Bug_maniacRobScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ac34d
	waitbutton
	closetext
	end

TrainerBug_maniacEd:
	trainer EVENT_BEAT_BUG_MANIAC_ED, BUG_MANIAC, ED, Bug_maniacEdSeenText, Bug_maniacEdBeatenText, 0, Bug_maniacEdScript

Bug_maniacEdScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ac3cf
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

Route2CutTree:
	jumpstd cuttree

Route2Sign:
	jumptext Route2SignText

MapRoute2Signpost1Script:
	jumptext UnknownText_0x1ac49f

Route2Carbos:
	itemball CARBOS

Route2Elixer:
	itemball ELIXER

FruitTreeScript_0x1ac306:
	fruittree FRUITTREE_ROUTE_2

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

Bug_maniacEdSeenText:
	text "If you walk in"
	line "tall grass wearing"

	para "shorts, do you get"
	line "nicks and cuts?"
	done

Bug_maniacEdBeatenText:
	text "Ouch, ouch, ouch!"
	done

UnknownText_0x1ac3cf:
	text "They'll really"
	line "sting when you"
	cont "take a bath."
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

UnknownText_0x1ac49f:
	text "Diglett's Cave"
	done

Route2_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $13, $f, 1, ROUTE_2_NUGGET_SPEECH_HOUSE
	warp_def $27, $f, 3, ROUTE_2_GATE
	warp_def $23, $10, 1, ROUTE_2_GATE
	warp_def $23, $11, 2, ROUTE_2_GATE
	warp_def $9, $c, 3, DIGLETTS_CAVE
	warp_def $2b, $5, 3, VIRIDIAN_FOREST_VIRIDIAN_GATE
	warp_def $b, $1, 3, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $b, $2, 4, VIRIDIAN_FOREST_PEWTER_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 65, 5, SIGNPOST_READ, Route2Sign
	signpost 11, 11, SIGNPOST_READ, MapRoute2Signpost1Script

.PersonEvents:
	db 11
	person_event SPRITE_BUG_MANIAC, 59, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBug_maniacRob, -1
	person_event SPRITE_BUG_MANIAC, 6, 6, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacEd, -1
	person_event SPRITE_BUG_MANIAC, 52, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacDoug, -1
	person_event SPRITE_BALL_CUT_FRUIT, 4, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route2Carbos, EVENT_ROUTE_2_CARBOS
	person_event SPRITE_BALL_CUT_FRUIT, 66, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route2Elixer, EVENT_ROUTE_2_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 10, 5, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2CutTree, EVENT_ROUTE_2_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 22, 15, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2CutTree, EVENT_ROUTE_2_CUT_TREE_2
	person_event SPRITE_BALL_CUT_FRUIT, 52, 11, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2CutTree, EVENT_ROUTE_2_CUT_TREE_3
	person_event SPRITE_BALL_CUT_FRUIT, 60, 12, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2CutTree, EVENT_ROUTE_2_CUT_TREE_4
	person_event SPRITE_BALL_CUT_FRUIT, 66, 12, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2CutTree, EVENT_ROUTE_2_CUT_TREE_5
	person_event SPRITE_BALL_CUT_FRUIT, 13, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1ac306, -1
