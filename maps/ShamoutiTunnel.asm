const_value set 0

ShamoutiTunnel_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiTunnel_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $0, 3, SHAMOUTI_ISLAND
	warp_def $0, $0, 2, SHAMOUTI_WEST_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
