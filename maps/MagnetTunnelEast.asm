MagnetTunnelEast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  5, MAGNET_TUNNEL_INSIDE, 2

	def_coord_events

	def_bg_events

	def_object_events
	cuttree_event 19,  9, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	smashrock_event 12,  6
	smashrock_event 14,  4
	smashrock_event 12,  3
