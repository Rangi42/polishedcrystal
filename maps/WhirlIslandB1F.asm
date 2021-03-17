WhirlIslandB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  5, WHIRL_ISLAND_NW, 2
	warp_event 35,  3, WHIRL_ISLAND_NE, 2
	warp_event 29,  9, WHIRL_ISLAND_NE, 3
	warp_event  9, 31, WHIRL_ISLAND_SW, 3
	warp_event 23, 31, WHIRL_ISLAND_SW, 2
	warp_event 31, 29, WHIRL_ISLAND_SE, 2
	warp_event 25, 21, WHIRL_ISLAND_B2F, 1
	warp_event 13, 27, WHIRL_ISLAND_B2F, 2
	warp_event 17, 21, WHIRL_ISLAND_CAVE, 1

	def_coord_events

	def_bg_events
	bg_event 30,  4, BGEVENT_ITEM + RARE_CANDY, EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY
	bg_event 36, 18, BGEVENT_ITEM + ULTRA_BALL, EVENT_WHIRL_ISLAND_B1F_HIDDEN_ULTRA_BALL
	bg_event  2, 23, BGEVENT_ITEM + FULL_RESTORE, EVENT_WHIRL_ISLAND_B1F_HIDDEN_FULL_RESTORE

	def_object_events
	itemball_event  7, 13, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B1F_FULL_RESTORE
	itemball_event  2, 18, CARBOS, 1, EVENT_WHIRL_ISLAND_B1F_CARBOS
	itemball_event 33, 23, CALCIUM, 1, EVENT_WHIRL_ISLAND_B1F_CALCIUM
	itemball_event 17,  8, BIG_NUGGET, 1, EVENT_WHIRL_ISLAND_B1F_BIG_NUGGET
	itemball_event 19, 26, ESCAPE_ROPE, 1, EVENT_WHIRL_ISLAND_B1F_ESCAPE_ROPE
	strengthboulder_event 23, 26
