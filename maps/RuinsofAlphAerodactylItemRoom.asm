RuinsofAlphAerodactylItemRoom_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 3, 9, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_event 4, 9, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_event 3, 1, 1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	warp_event 4, 1, 2, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM

	db 0 ; coord events

	db 2 ; bg events
	bg_event 2, 1, SIGNPOST_JUMPTEXT, UnknownText_0x59ac1
	bg_event 5, 1, SIGNPOST_JUMPTEXT, UnknownText_0x59ac1

	db 4 ; object events
	itemball_event 2, 6, RARE_BONE, 1, EVENT_PICKED_UP_RARE_BONE_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 5, 6, ENERGY_ROOT, 1, EVENT_PICKED_UP_ENERGY_ROOT_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 2, 4, REVIVAL_HERB, 1, EVENT_PICKED_UP_REVIVAL_HERB_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 5, 4, SOOTHE_BELL, 1, EVENT_PICKED_UP_SOOTHE_BELL_FROM_AERODACTYL_ITEM_ROOM

UnknownText_0x59ac1:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
