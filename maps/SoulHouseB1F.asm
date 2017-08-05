SoulHouseB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SoulHouseB1F_MapEventHeader:

.Warps: db 3
	warp_def $5, $11, 3, SOUL_HOUSE
	warp_def $f, $11, 1, SOUL_HOUSE_B2F
	warp_def $f, $3, 2, SOUL_HOUSE_B2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0
