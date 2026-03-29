SilverCaveItemRooms_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 21, 11, SILVER_CAVE_ROOM_2, 3
	warp_event  5,  7, SILVER_CAVE_ROOM_2, 4

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event 14, 11, MAX_REVIVE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	itemball_event 13,  3, FULL_RESTORE, 1, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE

