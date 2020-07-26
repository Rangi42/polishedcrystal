TinTower3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8, 14, TIN_TOWER_2F, 1
	warp_event 14,  2, TIN_TOWER_4F, 2

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event  1, 14, FULL_HEAL, 1, EVENT_TIN_TOWER_3F_FULL_HEAL

