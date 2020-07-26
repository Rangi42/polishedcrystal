TinTower7F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  9, TIN_TOWER_6F, 1
	warp_event  8, 15, TIN_TOWER_8F, 1
	warp_event 10,  7, TIN_TOWER_7F, 4
	warp_event  6,  3, TIN_TOWER_7F, 3
	warp_event  4,  9, TIN_TOWER_9F, 5

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event 14,  1, MAX_REVIVE, 1, EVENT_TIN_TOWER_7F_MAX_REVIVE

