RuinsofAlphKabutoItemRoom_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

RuinsofAlphKabutoItemRoom_MapEventHeader:
	db 4 ; warps
	warp_def 9, 3, 5, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_def 9, 4, 5, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_def 1, 3, 1, RUINS_OF_ALPH_KABUTO_WORD_ROOM
	warp_def 1, 4, 2, RUINS_OF_ALPH_KABUTO_WORD_ROOM

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 1, 2, SIGNPOST_JUMPTEXT, UnknownText_0x599ad
	signpost 1, 5, SIGNPOST_JUMPTEXT, UnknownText_0x599ad

	db 4 ; person events
	itemball_event 6, 2, SITRUS_BERRY, 1, EVENT_PICKED_UP_SITRUS_BERRY_FROM_KABUTO_ITEM_ROOM
	itemball_event 6, 5, LUM_BERRY, 1, EVENT_PICKED_UP_LUM_BERRY_FROM_KABUTO_ITEM_ROOM
	itemball_event 4, 2, HEAL_POWDER, 1, EVENT_PICKED_UP_HEAL_POWDER_FROM_KABUTO_ITEM_ROOM
	itemball_event 4, 5, ENERGYPOWDER, 1, EVENT_PICKED_UP_ENERGYPOWDER_FROM_KABUTO_ITEM_ROOM

UnknownText_0x599ad:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
