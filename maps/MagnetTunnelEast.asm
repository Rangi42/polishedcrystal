MagnetTunnelEast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  7, MAGNET_TUNNEL_INSIDE, 2

	def_coord_events

	def_bg_events

	def_object_events
	cuttree_event 19, 11, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	smashrock_event 12, 8
	smashrock_event 13, 4
	smashrock_event 12, 5
