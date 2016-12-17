const_value set 2

ShamoutiShrineRuins_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiShrineRuins_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $12, $2, 3, NOISY_FOREST
	warp_def $13, $2, 4, NOISY_FOREST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
