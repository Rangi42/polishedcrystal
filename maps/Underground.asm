Underground_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  2, ROUTE_5_UNDERGROUND_ENTRANCE, 3
	warp_event  3, 32, ROUTE_6_UNDERGROUND_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  3,  9, BGEVENT_ITEM + FULL_RESTORE, EVENT_UNDERGROUND_HIDDEN_FULL_RESTORE
	bg_event  1, 21, BGEVENT_ITEM + X_SPCL_ATK, EVENT_UNDERGROUND_HIDDEN_X_SPCL_ATK

	def_object_events
	tmhmball_event  4, 15, TM_EXPLOSION, EVENT_UNDERGROUND_TM_EXPLOSION
