MagnetTunnelInside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MagnetTunnelInside_MapEventHeader:

.Warps: db 5
	warp_def 6, 2, 1, MAGNET_TUNNEL_WEST
	warp_def 7, 2, 2, MAGNET_TUNNEL_WEST
	warp_def 12, 37, 1, MAGNET_TUNNEL_EAST
	warp_def 13, 37, 2, MAGNET_TUNNEL_EAST
	warp_def 5, 35, 3, MAGNET_TUNNEL_EAST

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 11, SIGNPOST_JUMPTEXT, MagnetTunnelInsideLodestoneText

.PersonEvents: db 0

MagnetTunnelInsideLodestoneText:
	text "The lodestone is"
	line "smooth and warm."

	para "It has a faint"
	line "aura of static."
	done
