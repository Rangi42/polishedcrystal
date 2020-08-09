RuinsOfAlphOmanyteItemRoom_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OMANYTE_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_OMANYTE_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsofAlphStatueText

	def_object_events
	itemball_event  2,  6, PEARL_STRING, 1, EVENT_PICKED_UP_PEARL_STRING_FROM_OMANYTE_ITEM_ROOM
	itemball_event  5,  6, BIG_PEARL, 1, EVENT_PICKED_UP_BIG_PEARL_FROM_OMANYTE_ITEM_ROOM
	itemball_event  2,  4, STARDUST, 1, EVENT_PICKED_UP_STARDUST_FROM_OMANYTE_ITEM_ROOM
	itemball_event  5,  4, STAR_PIECE, 1, EVENT_PICKED_UP_STAR_PIECE_FROM_OMANYTE_ITEM_ROOM
