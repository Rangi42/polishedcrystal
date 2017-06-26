const_value set 2
	const ROUTE2NORTH_BUG_MANIAC
	const ROUTE2NORTH_POKE_BALL
	const ROUTE2NORTH_FRUIT_TREE
	const ROUTE2NORTH_CUT_TREE1
	const ROUTE2NORTH_CUT_TREE2
	const ROUTE2NORTH_COOLTRAINER_M

Route2North_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerBug_maniacEd:
	trainer EVENT_BEAT_BUG_MANIAC_ED, BUG_MANIAC, ED, Bug_maniacEdSeenText, Bug_maniacEdBeatenText, 0, Bug_maniacEdScript

Bug_maniacEdScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ac3cf
	waitbutton
	closetext
	end

Route2NorthCooltrainermScript:
	jumptextfaceplayer Route2NorthCooltrainermText

Route2NorthCutTree:
	jumpstd cuttree

MapRoute2Signpost1Script:
	jumptext UnknownText_0x1ac49f

Route2NorthCarbos:
	itemball CARBOS

FruitTreeScript_0x1ac306:
	fruittree FRUITTREE_ROUTE_2

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

Route2NorthCooltrainermText:
	text "Diglett's Cave is"
	line "just a dead end."

	para "The Vermilion City"
	line "exit is blocked"

	para "by a sleeping"
	line "Snorlax."
	done

UnknownText_0x1ac49f:
	text "Diglett's Cave"
	done

Route2North_MapEventHeader:
.Warps:
	db 6
	warp_def $13, $f, 1, ROUTE_2_NUGGET_SPEECH_HOUSE
	warp_def $23, $10, 1, ROUTE_2_GATE
	warp_def $23, $11, 2, ROUTE_2_GATE
	warp_def $9, $c, 3, DIGLETTS_CAVE
	warp_def $b, $1, 3, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $b, $2, 4, VIRIDIAN_FOREST_PEWTER_GATE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 11, SIGNPOST_READ, MapRoute2Signpost1Script

.PersonEvents:
	db 6
	person_event SPRITE_BUG_MANIAC, 6, 6, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacEd, -1
	person_event SPRITE_BALL_CUT_FRUIT, 4, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route2NorthCarbos, EVENT_ROUTE_2_CARBOS
	person_event SPRITE_BALL_CUT_FRUIT, 13, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1ac306, -1
	person_event SPRITE_BALL_CUT_FRUIT, 10, 5, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2NorthCutTree, EVENT_ROUTE_2_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 22, 15, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2NorthCutTree, EVENT_ROUTE_2_CUT_TREE_2
	person_event SPRITE_COOLTRAINER_M, 10, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route2NorthCooltrainermScript, EVENT_VERMILION_CITY_SNORLAX
