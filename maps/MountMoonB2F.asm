const_value set 2

MountMoonB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MountMoonB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $18, $a, 4, MOUNT_MOON_B1F
	warp_def $7, $15, 5, MOUNT_MOON_B1F
	warp_def $f, $11, 6, MOUNT_MOON_B1F
	warp_def $9, $3, 7, MOUNT_MOON_B1F
	warp_def $15, $12, 9, MOUNT_MOON_B1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
