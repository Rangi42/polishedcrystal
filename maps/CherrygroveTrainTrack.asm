CherrygroveTrainTrack_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  3,  4, BGEVENT_ITEM + PREMIER_BALL, EVENT_CHERRYGROVE_TRAIN_TRACK_HIDDEN_PREMIER_BALL

	def_object_events
	object_event 12,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_30_YOUNGSTER_JOEY
	cuttree_event -6,  5, EVENT_CHERRYGROVE_BAY_CUT_TREE_2
	cuttree_event 11,  5, EVENT_ROUTE_30_CUT_TREE_2
