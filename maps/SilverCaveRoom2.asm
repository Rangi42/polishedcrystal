SilverCaveRoom2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 31, SILVER_CAVE_ROOM_1, 2
	warp_event 11,  5, SILVER_CAVE_ROOM_3, 1
	warp_event 13, 21, SILVER_CAVE_ITEM_ROOMS, 1
	warp_event 23,  3, SILVER_CAVE_ITEM_ROOMS, 2

	def_coord_events

	def_bg_events
	bg_event 14, 31, BGEVENT_ITEM + MAX_POTION, EVENT_SILVER_CAVE_ROOM_2_HIDDEN_MAX_POTION

	def_object_events
	itemball_event 24, 10, CALCIUM, 1, EVENT_SILVER_CAVE_ROOM_2_CALCIUM
	itemball_event 22, 24, ULTRA_BALL, 1, EVENT_SILVER_CAVE_ROOM_2_ULTRA_BALL
	itemball_event  4, 20, PP_UP, 1, EVENT_SILVER_CAVE_ROOM_2_PP_UP
