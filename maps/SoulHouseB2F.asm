const_value set 2

SoulHouseB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SoulHouseB2F_MapEventHeader:
.Warps:
	db 3
	warp_def $f, $11, 2, SOUL_HOUSE_B1F
	warp_def $f, $3, 3, SOUL_HOUSE_B1F
	warp_def $4, $9, 1, SOUL_HOUSE_B3F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
