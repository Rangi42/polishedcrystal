RuinsofAlphHoOhItemRoom_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  3,  9, RUINS_OF_ALPH_HO_OH_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_HO_OH_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_HO_OH_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_HO_OH_WORD_ROOM, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  2,  1, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  1, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText

	db 4 ; object events
	itemball_event  2,  6, SUN_STONE, 1, EVENT_PICKED_UP_SUN_STONE_FROM_HO_OH_ITEM_ROOM
	itemball_event  5,  6, MOON_STONE, 1, EVENT_PICKED_UP_MOON_STONE_FROM_HO_OH_ITEM_ROOM
	itemball_event  2,  4, LIFE_ORB, 1, EVENT_PICKED_UP_LIFE_ORB_FROM_HO_OH_ITEM_ROOM
	itemball_event  5,  4, CHARCOAL, 1, EVENT_PICKED_UP_CHARCOAL_FROM_HO_OH_ITEM_ROOM
