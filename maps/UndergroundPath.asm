UndergroundPath_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  2, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, 3
	warp_event  3, 46, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, 3

	def_coord_events

	def_bg_events
	bg_event  3, 14, BGEVENT_ITEM + FULL_RESTORE, EVENT_UNDERGROUND_PATH_HIDDEN_FULL_RESTORE
	bg_event  1, 33, BGEVENT_ITEM + X_SP_ATK, EVENT_UNDERGROUND_PATH_HIDDEN_X_SP_ATK

	def_object_events
	tmhmball_event  4, 21, TM_EXPLOSION, EVENT_UNDERGROUND_PATH_TM_EXPLOSION
