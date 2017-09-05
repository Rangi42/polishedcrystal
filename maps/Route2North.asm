Route2North_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route2North_MapEventHeader:

.Warps: db 6
	warp_def 19, 15, 1, ROUTE_2_NUGGET_SPEECH_HOUSE
	warp_def 35, 16, 1, ROUTE_2_GATE
	warp_def 35, 17, 2, ROUTE_2_GATE
	warp_def 9, 12, 3, DIGLETTS_CAVE
	warp_def 11, 1, 3, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def 11, 2, 4, VIRIDIAN_FOREST_PEWTER_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 11, SIGNPOST_JUMPTEXT, UnknownText_0x1ac49f

.PersonEvents: db 6
	person_event SPRITE_BUG_MANIAC, 6, 6, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBug_maniacEd, -1
	itemball_event 4, 19, CARBOS, 1, EVENT_ROUTE_2_CARBOS
	fruittree_event 13, 7, FRUITTREE_ROUTE_2, LUM_BERRY
	cuttree_event 10, 5, EVENT_ROUTE_2_CUT_TREE_1
	cuttree_event 22, 15, EVENT_ROUTE_2_CUT_TREE_2
	person_event SPRITE_COOLTRAINER_M, 10, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route2NorthCooltrainermText, EVENT_VERMILION_CITY_SNORLAX

TrainerBug_maniacEd:
	trainer EVENT_BEAT_BUG_MANIAC_ED, BUG_MANIAC, ED, Bug_maniacEdSeenText, Bug_maniacEdBeatenText, 0, Bug_maniacEdScript

Bug_maniacEdScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac3cf

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
