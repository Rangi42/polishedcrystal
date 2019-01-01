MagnetTunnelEast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  8,  7, MAGNET_TUNNEL_INSIDE, 2

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	cuttree_event 19, 11, EVENT_MAGNET_TUNNEL_EAST_CUT_TREE
	smashrock_event 12, 8
	smashrock_event 13, 4
	smashrock_event 12, 5
