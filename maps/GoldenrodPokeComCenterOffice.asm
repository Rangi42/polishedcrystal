
GoldenrodPokeComCenterOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodPokeComCenterOffice_MapEventHeader:

.Warps: db 2
	warp_def 7, 0, 3, GOLDENROD_POKECOM_CENTER_1F
	warp_def 7, 1, 3, GOLDENROD_POKECOM_CENTER_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 2, 6, SIGNPOST_UP, Computer0Script
	signpost 5, 6, SIGNPOST_UP, Computer1Script
	signpost 2, 3, SIGNPOST_UP, Computer2Script

.PersonEvents: db 3
	person_event SPRITE_SCIENTIST, 4, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x62674, -1
	person_event SPRITE_SCIENTIST, 3, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x626f9, -1
	person_event SPRITE_SCIENTIST, 6, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x62795, -1

Computer0Script:
	jumptext UnknownText_0x627ee

Computer1Script:
	jumptext UnknownText_0x62989

Computer2Script:
	jumptext UnknownText_0x62b26

UnknownText_0x62674:
	text "#Com Center and"
	line "its Wonder Trade"

	para "Hub were built to"
	line "satisfy demand for"

	para "trading with"
	line "people far away."
	done

UnknownText_0x626f9:
	text "When you traded"
	line "with someone"
	cont "in another region"

	para "wirelessly for"
	line "the first time,"

	para "weren't you"
	line "impressed?"

	para "When my first try"
	line "worked, I was so"

	para "amazed that I"
	line "got the shakes!"
	done

UnknownText_0x62795:
	text "They were able to"
	line "build this huge"

	para "facility thanks to"
	line "advances in wire-"
	cont "less technology."
	done

UnknownText_0x627ee:
	text "Network traffic"
	line "from Wonder Trades"

	para "is streaming by"
	line "on the screen."
	done

UnknownText_0x62989:
	text "There's a screen-"
	line "saver endlessly"

	para "running through"
	line "a 3D maze."
	done

UnknownText_0x62b26:
	text "The Administration"
	line "Office received an"
	cont "e-mail. It says…"

	para "…… …… ……"

	para "To the #Com"
	line "Center staff…"

	para "Wireless communi-"
	line "cation has enabled"

	para "#mon trainers"
	line "to interact across"

	para "the nation. Let's"
	line "keep working for"

	para "the day when all"
	line "the trainers in"

	para "the world can link"
	line "without barriers!"

	para "…… …… ……"
	done
