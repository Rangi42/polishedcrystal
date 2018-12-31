Route49_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route49_MapEventHeader:

.Warps: db 1
	warp_def 5, 7, 1, VALENCIA_PORT

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 31, SIGNPOST_JUMPTEXT, Route49SignText

.PersonEvents: db 11
	person_event SPRITE_LADY, 12, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route49LadyText, -1
	person_event SPRITE_YOUNGSTER, 17, 31, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route49YoungsterText, -1
	person_event SPRITE_SIGHTSEER_M, 8, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerSightseermHari, -1
	person_event SPRITE_COOLTRAINER_M, 16, 12, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerTamerJordan, -1
	person_event SPRITE_LADY, 19, 25, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerAromaLadyPeony, -1
	person_event SPRITE_ROCKER, 7, 25, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGuitaristmGeddy, -1
	itemball_event 6, 21, WHITE_HERB, 1, EVENT_ROUTE_49_WHITE_HERB
	itemball_event 20, 18, CALCIUM, 1, EVENT_ROUTE_49_CALCIUM
	fruittree_event 14, 29, FRUITTREE_ROUTE_49, LUM_BERRY
	cuttree_event 12, 26, EVENT_ROUTE_49_CUT_TREE_1
	cuttree_event 15, 20, EVENT_ROUTE_49_CUT_TREE_2

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

TrainerSightseermHari:
	trainer EVENT_BEAT_SIGHTSEERM_HARI, SIGHTSEERM, HARI, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hey! I came here"
	line "to meet Prof.Ivy!"
	done

.BeatenText:
	text "What? You already"
	line "know her?"
	done

.AfterText:
	text "I've been traveling"
	line "a lot just to meet"

	para "every #mon"
	line "Prof."

	para "Wanna see the pho-"
	line "tos I took?"
	done

TrainerTamerJordan:
	trainer EVENT_BEAT_TAMER_JORDAN, TAMER, JORDAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Be careful! #-"
	line "mon here can be"
	cont "really wild!"
	done

.BeatenText:
	text "Whoa! Looks like"
	line "yours are wilder."
	done

.AfterText:
	text "How did you tame"
	line "your #mon so"
	cont "well?"

	para "They're strong,"
	line "but calm at the"
	cont "same time."
	done

TrainerAromaLadyPeony:
	trainer EVENT_BEAT_AROMA_LADY_PEONY, AROMA_LADY, PEONY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Do you want to see"
	line "my Bellossom?"
	done

.BeatenText:
	text "Aww… Bellossom"
	line "didn't want to"
	cont "battle…"
	done

.AfterText:
	text "My Bellossom loves"
	line "living on this"

	para "peaceful little"
	line "island."
	done

TrainerGuitaristmGeddy:
	trainer EVENT_BEAT_GUITARISTM_GEDDY, GUITARISTM, GEDDY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "You think that I'm"
	line "playing a guitar?"
	cont "Wrong!"

	para "It's a 6-string"
	line "bass."
	done

Route49SignText:
	text "Route 49"
	line "Valencia Island"
	done
