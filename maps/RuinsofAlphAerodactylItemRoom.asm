RuinsofAlphAerodactylItemRoom_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 4 ; warps
	warp_def 9, 3, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_def 9, 4, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_def 1, 3, 1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	warp_def 1, 4, 2, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 1, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59ac1
	signpost 1, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59ac1

	db 4 ; person events
	itemball_event 6, 2, RARE_BONE, 1, EVENT_PICKED_UP_RARE_BONE_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 6, 5, ENERGY_ROOT, 1, EVENT_PICKED_UP_ENERGY_ROOT_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 4, 2, REVIVAL_HERB, 1, EVENT_PICKED_UP_REVIVAL_HERB_FROM_AERODACTYL_ITEM_ROOM
	itemball_event 4, 5, SOOTHE_BELL, 1, EVENT_PICKED_UP_SOOTHE_BELL_FROM_AERODACTYL_ITEM_ROOM

UnknownText_0x59ac1:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
