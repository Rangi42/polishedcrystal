WhirlIslandB2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 11,  5, WHIRL_ISLAND_B1F, 7
	warp_event  7, 11, WHIRL_ISLAND_B1F, 8
	warp_event  7, 25, WHIRL_ISLAND_LUGIA_CHAMBER, 1
	warp_event 13, 31, WHIRL_ISLAND_SW, 5

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event 10, 11, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B2F_FULL_RESTORE
	itemball_event  6,  4, MAX_REVIVE, 1, EVENT_WHIRL_ISLAND_B2F_MAX_REVIVE
	itemball_event  5, 12, MAX_ELIXIR, 1, EVENT_WHIRL_ISLAND_B2F_MAX_ELIXIR

