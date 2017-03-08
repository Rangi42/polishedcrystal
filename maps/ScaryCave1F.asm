const_value set 2

ScaryCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ScaryCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $1f, $21, 1, URAGA_CHANNEL_EAST
	warp_def $1f, $b, 1, URAGA_CHANNEL_WEST
	warp_def $1e, $14, 1, SCARY_CAVE_B1F
	warp_def $a, $22, 2, SCARY_CAVE_B1F
	warp_def $1, $9, 1, SCARY_CAVE_SHIPWRECK

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
