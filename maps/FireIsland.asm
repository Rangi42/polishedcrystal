FireIsland_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 29, SHAMOUTI_COAST, 1
	warp_event 19, 29, FIRE_ISLAND_ROOF, 1
	warp_event  7,  5, FIRE_ISLAND, 4
	warp_event 21,  5, FIRE_ISLAND, 3
	warp_event  7,  9, FIRE_ISLAND, 6
	warp_event 21,  9, FIRE_ISLAND, 5
	warp_event  2, 16, FIRE_ISLAND, 8
	warp_event 16, 16, FIRE_ISLAND, 7
	warp_event  9, 19, FIRE_ISLAND, 10
	warp_event 23, 19, FIRE_ISLAND, 9
	warp_event  3, 23, FIRE_ISLAND, 12
	warp_event 17, 23, FIRE_ISLAND, 11
	warp_event 20, 27, FIRE_ISLAND, 14
	warp_event  6, 27, FIRE_ISLAND, 13 ; hole

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event  2, 19, HEAT_ROCK, 1, EVENT_FIRE_ISLAND_HEAT_ROCK

