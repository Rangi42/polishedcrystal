MagnetTunnelEast_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MagnetTunnelEast_MapEventHeader:

.Warps: db 1
	warp_def 7, 8, 2, MAGNET_TUNNEL_INSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	cuttree_event 11, 19, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	smashrock_event 8, 12
	smashrock_event 4, 13
	smashrock_event 5, 12
