const_value set 2

MountMoonB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MountMoonB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 10
	warp_def $14, $1a, 2, MOUNT_MOON_1F
	warp_def $3, $5, 3, MOUNT_MOON_1F
	warp_def $b, $3, 4, MOUNT_MOON_1F
	warp_def $1f, $f, 1, MOUNT_MOON_B2F
	warp_def $3, $d, 2, MOUNT_MOON_B2F
	warp_def $16, $10, 3, MOUNT_MOON_B2F
	warp_def $d, $f, 4, MOUNT_MOON_B2F
	warp_def $f, $f, 1, ROUTE_4
	warp_def $3, $17, 5, MOUNT_MOON_B2F
	warp_def $5, $17, 1, MOUNT_MOON_SQUARE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
