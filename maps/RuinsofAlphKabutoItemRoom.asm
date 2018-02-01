RuinsofAlphKabutoItemRoom_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 3, 9, 5, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_event 4, 9, 5, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_event 3, 1, 1, RUINS_OF_ALPH_KABUTO_WORD_ROOM
	warp_event 4, 1, 2, RUINS_OF_ALPH_KABUTO_WORD_ROOM

	db 0 ; coord events

	db 2 ; bg events
	bg_event 2, 1, SIGNPOST_JUMPTEXT, UnknownText_0x599ad
	bg_event 5, 1, SIGNPOST_JUMPTEXT, UnknownText_0x599ad

	db 4 ; object events
	itemball_event 2, 6, SITRUS_BERRY, 1, EVENT_PICKED_UP_SITRUS_BERRY_FROM_KABUTO_ITEM_ROOM
	itemball_event 5, 6, LUM_BERRY, 1, EVENT_PICKED_UP_LUM_BERRY_FROM_KABUTO_ITEM_ROOM
	itemball_event 2, 4, HEAL_POWDER, 1, EVENT_PICKED_UP_HEAL_POWDER_FROM_KABUTO_ITEM_ROOM
	itemball_event 5, 4, ENERGYPOWDER, 1, EVENT_PICKED_UP_ENERGYPOWDER_FROM_KABUTO_ITEM_ROOM

UnknownText_0x599ad:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
