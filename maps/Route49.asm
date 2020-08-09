Route49_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  5, VALENCIA_PORT, 1

	def_coord_events

	def_bg_events
	bg_event 31, 11, BGEVENT_JUMPTEXT, Route49SignText

	def_object_events
	object_event  5, 12, SPRITE_LADY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route49LadyText, -1
	object_event 31, 17, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route49YoungsterText, -1
	object_event 15,  8, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSightseermHari, -1
	object_event 12, 16, SPRITE_TAMER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerTamerJordan, -1
	object_event 25, 19, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerAromaLadyPeony, -1
	object_event 25,  7, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGuitaristmGeddy, -1
	itemball_event 21,  6, WHITE_HERB, 1, EVENT_ROUTE_49_WHITE_HERB
	itemball_event 18, 20, CALCIUM, 1, EVENT_ROUTE_49_CALCIUM
	fruittree_event 29, 14, FRUITTREE_ROUTE_49, LUM_BERRY, PAL_NPC_GREEN
	cuttree_event 26, 12, EVENT_ROUTE_49_CUT_TREE_1
	cuttree_event 20, 15, EVENT_ROUTE_49_CUT_TREE_2

Route49LadyText:
	text "Look at the grass"
	line "and trees here!"

	para "Valencia is full"
	line "of unique flora."
	done

Route49YoungsterText:
	text "This landscape"
	line "makes me feel like"

	para "an adventurer in"
	line "the middle of the"
	cont "jungle!"
	done

GenericTrainerSightseermHari:
	generictrainer SIGHTSEERM, HARI, EVENT_BEAT_SIGHTSEERM_HARI, .SeenText, .BeatenText

	text "I've been traveling"
	line "a lot just to meet"

	para "every #mon"
	line "Prof."

	para "Wanna see the pho-"
	line "tos I took?"
	done

.SeenText:
	text "Hey! I came here"
	line "to meet Prof.Ivy!"
	done

.BeatenText:
	text "What? You already"
	line "know her?"
	done

GenericTrainerTamerJordan:
	generictrainer TAMER, JORDAN, EVENT_BEAT_TAMER_JORDAN, .SeenText, .BeatenText

	text "How did you tame"
	line "your #mon so"
	cont "well?"

	para "They're strong,"
	line "but calm at the"
	cont "same time."
	done

.SeenText:
	text "Be careful! #-"
	line "mon here can be"
	cont "really wild!"
	done

.BeatenText:
	text "Whoa! Looks like"
	line "yours are wilder."
	done

GenericTrainerAromaLadyPeony:
	generictrainer AROMA_LADY, PEONY, EVENT_BEAT_AROMA_LADY_PEONY, .SeenText, .BeatenText

	text "My Bellossom loves"
	line "living on this"

	para "peaceful little"
	line "island."
	done

.SeenText:
	text "Do you want to see"
	line "my Bellossom?"
	done

.BeatenText:
	text "Aww… Bellossom"
	line "didn't want to"
	cont "battle…"
	done

GenericTrainerGuitaristmGeddy:
	generictrainer GUITARISTM, GEDDY, EVENT_BEAT_GUITARISTM_GEDDY, .SeenText, .BeatenText

	text "You think that I'm"
	line "playing a guitar?"
	cont "Wrong!"

	para "It's a 6-string"
	line "bass."
	done

.SeenText:
	text "It seems to me I"
	line "could live my life"

	para "a lot better than"
	line "I think I am…"

	para "I guess that's why"
	line "they call me…"

	para "They call me the"
	line "working man!"
	done

.BeatenText:
	text "Good battle!"
	line "I may write a"
	cont "song about it."
	done

Route49SignText:
	text "Route 49"
	line "Valencia Island"
	done
