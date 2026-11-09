SinjohRuins_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  5, MYSTRI_STAGE, 1
	warp_event 13, 17, SINJOH_RUINS_HOUSE, 1
	warp_event  8, 18, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_JUMPTEXT, SinjohRuinsSignpostText
	bg_event  8, 17, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_SINJOH_RUINS

	def_object_events

SinjohRuinsSignpostText:
	text "The Sinjoh Ruins"
	done
