MagnetTunnelEast_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

MagnetTunnelEast_MapEventHeader:
	db 1 ; warps
	warp_def 7, 8, 2, MAGNET_TUNNEL_INSIDE

	db 0 ; xy triggers

	db 0 ; signposts

	db 4 ; person events
	cuttree_event 11, 19, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	smashrock_event 8, 12
	smashrock_event 4, 13
	smashrock_event 5, 12
