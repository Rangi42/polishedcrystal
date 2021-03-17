SilverCaveRoom1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9, 33, SILVER_CAVE_OUTSIDE, 2
	warp_event 15,  1, SILVER_CAVE_ROOM_2, 1

	def_coord_events

	def_bg_events
	bg_event 16, 23, BGEVENT_ITEM + DIRE_HIT, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT
	bg_event 17, 12, BGEVENT_ITEM + ULTRA_BALL, EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL

	def_object_events
	itemball_event  4,  9, MAX_ELIXIR, 1, EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXIR
	itemball_event 15, 29, PROTEIN, 1, EVENT_SILVER_CAVE_ROOM_1_PROTEIN
	itemball_event  5, 30, ESCAPE_ROPE, 1, EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE
	itemball_event  7, 18, ULTRA_BALL, 1, EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL
