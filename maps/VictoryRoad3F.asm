VictoryRoad3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  5, VICTORY_ROAD_2F, 3
	warp_event 15, 11, VICTORY_ROAD_2F, 4
	warp_event 19, 13, VICTORY_ROAD_2F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11,  8, SPRITE_VETERAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerVeteranmRemy, -1
	itemball_event 16, 13, RAZOR_FANG, 1, EVENT_VICTORY_ROAD_3F_RAZOR_FANG

GenericTrainerVeteranmRemy:
	generictrainer VETERANM, REMY, EVENT_BEAT_VETERANM_REMY, VeteranmRemySeenText, VeteranmRemyBeatenText

	text "I can beat you"
	line "when it comes to"

	para "knowledge about"
	line "#mon!"
	done

VeteranmRemySeenText:
	text "If you can get"
	line "through here, you"

	para "can challenge the"
	line "Elite Four!"
	done

VeteranmRemyBeatenText:
	text "No!"
	line "Inconceivable!"
	done

