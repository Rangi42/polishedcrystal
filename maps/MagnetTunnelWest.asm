MagnetTunnelWest_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

MagnetTunnelWest_MapEventHeader:
	db 1 ; warps
	warp_def 15, 12, 1, MAGNET_TUNNEL_INSIDE

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	smashrock_event 8, 9
	smashrock_event 5, 7
