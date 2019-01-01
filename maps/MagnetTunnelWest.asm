MagnetTunnelWest_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event 12, 15, MAGNET_TUNNEL_INSIDE, 1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	smashrock_event  9, 8
	smashrock_event  7, 5
