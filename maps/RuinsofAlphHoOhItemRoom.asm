RuinsofAlphHoOhItemRoom_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RuinsofAlphHoOhItemRoom_MapEventHeader:

.Warps: db 4
	warp_def 9, 3, 5, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def 9, 4, 5, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def 1, 3, 1, RUINS_OF_ALPH_HO_OH_WORD_ROOM
	warp_def 1, 4, 2, RUINS_OF_ALPH_HO_OH_WORD_ROOM

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59923
	signpost 1, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59923

.PersonEvents: db 4
	itemball_event 6, 2, SUN_STONE, 1, EVENT_PICKED_UP_SUN_STONE_FROM_HO_OH_ITEM_ROOM
	itemball_event 6, 5, MOON_STONE, 1, EVENT_PICKED_UP_MOON_STONE_FROM_HO_OH_ITEM_ROOM
	itemball_event 4, 2, LIFE_ORB, 1, EVENT_PICKED_UP_LIFE_ORB_FROM_HO_OH_ITEM_ROOM
	itemball_event 4, 5, CHARCOAL, 1, EVENT_PICKED_UP_CHARCOAL_FROM_HO_OH_ITEM_ROOM

UnknownText_0x59923:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
