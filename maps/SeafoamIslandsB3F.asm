SeafoamIslandsB3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 37,  7, SEAFOAM_ISLANDS_B2F, 5
	warp_event 25,  9, SEAFOAM_ISLANDS_B2F, 6
	warp_event 35, 13, SEAFOAM_ISLANDS_B2F, 7
	warp_event  3, 13, SEAFOAM_ISLANDS_B2F, 8
	warp_event  3,  3, SEAFOAM_ISLANDS_B4F, 1
	warp_event  7, 13, SEAFOAM_ISLANDS_B4F, 2
	warp_event 21,  9, SEAFOAM_ISLANDS_B4F, 3
	warp_event 29,  3, SEAFOAM_ISLANDS_B4F, 4
	warp_event 31, 15, SEAFOAM_ISLANDS_B4F, 5
	warp_event 37, 15, SEAFOAM_ISLANDS_B4F, 6

	def_coord_events

	def_bg_events
	bg_event 27, 17, BGEVENT_ITEM + MAX_REVIVE, EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_MAX_REVIVE
	bg_event  7,  5, BGEVENT_ITEM + RARE_CANDY, EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_RARE_CANDY

	def_object_events
	itemball_event 15, 15, REVIVE, 1, EVENT_SEAFOAM_ISLANDS_B3F_REVIVE
	itemball_event 17,  6, BIG_PEARL, 1, EVENT_SEAFOAM_ISLANDS_B3F_BIG_PEARL
	strengthboulder_event 28, 7
