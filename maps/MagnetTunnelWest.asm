MagnetTunnelWest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MagnetTunnelWest_MapEventHeader:

.Warps: db 1
	warp_def 15, 12, 1, MAGNET_TUNNEL_INSIDE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	smashrock_event 8, 9
	smashrock_event 5, 7
