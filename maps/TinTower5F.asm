TinTower5F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9, 17, TIN_TOWER_6F, 2
	warp_event  0,  6, TIN_TOWER_4F, 1
	warp_event  0, 16, TIN_TOWER_4F, 3
	warp_event 15, 17, TIN_TOWER_4F, 4

	def_coord_events

	def_bg_events
	bg_event 14, 16, BGEVENT_ITEM + FULL_RESTORE, EVENT_TIN_TOWER_5F_HIDDEN_FULL_RESTORE
	bg_event  1, 17, BGEVENT_ITEM + CARBOS, EVENT_TIN_TOWER_5F_HIDDEN_CARBOS

	def_object_events
	itemball_event  7, 11, RARE_CANDY, 1, EVENT_TIN_TOWER_5F_RARE_CANDY
