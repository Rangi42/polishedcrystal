RuinsOfAlphAerodactylItemRoom_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsofAlphStatueText

	def_object_events
	itemball_event  2,  6, RARE_BONE, 1, EVENT_PICKED_UP_RARE_BONE_FROM_AERODACTYL_ITEM_ROOM
	itemball_event  5,  6, ENERGY_ROOT, 1, EVENT_PICKED_UP_ENERGY_ROOT_FROM_AERODACTYL_ITEM_ROOM
	itemball_event  2,  4, REVIVAL_HERB, 1, EVENT_PICKED_UP_REVIVAL_HERB_FROM_AERODACTYL_ITEM_ROOM
	itemball_event  5,  4, SOOTHE_BELL, 1, EVENT_PICKED_UP_SOOTHE_BELL_FROM_AERODACTYL_ITEM_ROOM
