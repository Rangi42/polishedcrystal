QuietCaveB2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 21,  3, QUIET_CAVE_B1F, 6
	warp_event 17, 25, QUIET_CAVE_B1F, 7
	warp_event 23, 33, QUIET_CAVE_B1F, 8
	warp_event 29,  3, QUIET_CAVE_B1F, 9
	warp_event 10, 31, QUIET_CAVE_B3F, 1
	warp_event 33,  5, QUIET_CAVE_B3F, 2

	def_coord_events

	def_bg_events
	bg_event 16, 11, BGEVENT_ITEM + CALCIUM, EVENT_QUIET_CAVE_B2F_HIDDEN_CALCIUM

	def_object_events
	itemball_event 10,  3, DUSK_BALL, 1, EVENT_QUIET_CAVE_B2F_DUSK_BALL
	itemball_event  9, 23, RAZOR_CLAW, 1, EVENT_QUIET_CAVE_B2F_RAZOR_CLAW
	itemball_event 19, 11, SAFE_GOGGLES, 1, EVENT_QUIET_CAVE_B2F_SAFE_GOGGLES
