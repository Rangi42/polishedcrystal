VictoryRoad1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 11, 21, ROUTE_23, 3
	warp_event  3,  3, VICTORY_ROAD_2F, 2

	def_coord_events

	def_bg_events
	bg_event  5, 19, BGEVENT_ITEM + FULL_HEAL, EVENT_VICTORY_ROAD_1F_HIDDEN_FULL_HEAL

	def_object_events
	object_event 12,  6, SPRITE_VETERAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerVeteranmMatt, -1
	itemball_event 14,  2, MAX_REVIVE, 1, EVENT_VICTORY_ROAD_1F_MAX_REVIVE
	itemball_event 17,  2, FULL_HEAL, 1, EVENT_VICTORY_ROAD_1F_FULL_HEAL

GenericTrainerVeteranmMatt:
	generictrainer VETERANM, MATT, EVENT_BEAT_VETERANM_MATT, VeteranmMattSeenText, VeteranmMattBeatenText

	text "I concede, you're"
	line "better than me!"
	done

VeteranmMattSeenText:
	text "I can see you're"
	line "good! Let me see"
	cont "exactly how good!"
	done

VeteranmMattBeatenText:
	text "I had a chance…"
	done

