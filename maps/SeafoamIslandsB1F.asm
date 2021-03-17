SeafoamIslandsB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 35, 15, SEAFOAM_ISLANDS_1F, 3
	warp_event  3,  3, SEAFOAM_ISLANDS_1F, 5
	warp_event 27, 15, SEAFOAM_ISLANDS_B2F, 1
	warp_event 18,  5, SEAFOAM_ISLANDS_B2F, 2
	warp_event 15, 11, SEAFOAM_ISLANDS_B2F, 3
	warp_event  7, 15, SEAFOAM_ISLANDS_B2F, 4

	def_coord_events

	def_bg_events
	bg_event 20, 11, BGEVENT_ITEM + ICE_HEAL, EVENT_SEAFOAM_ISLANDS_B1F_HIDDEN_ICE_HEAL

	def_object_events
	itemball_event 20,  3, GRIP_CLAW, 1, EVENT_SEAFOAM_ISLANDS_B1F_GRIP_CLAW
	itemball_event 24,  5, ICE_HEAL, 1, EVENT_SEAFOAM_ISLANDS_B1F_ICE_HEAL
	strengthboulder_event 30, 9
	strengthboulder_event 31, 9
	strengthboulder_event 32, 10
	strengthboulder_event 12, 8
	strengthboulder_event  7, 11
	strengthboulder_event 13, 15
