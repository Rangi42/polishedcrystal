TinTower9F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10,  3, TIN_TOWER_8F, 2
	warp_event  0,  5, TIN_TOWER_8F, 3
	warp_event 10,  7, TIN_TOWER_8F, 4
	warp_event  5,  9, TIN_TOWER_10F, 1
	warp_event 14,  7, TIN_TOWER_7F, 5
	warp_event  4, 13, TIN_TOWER_8F, 5
	warp_event  6, 13, TIN_TOWER_8F, 6

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event  7,  1, HP_UP, 1, EVENT_TIN_TOWER_9F_HP_UP

