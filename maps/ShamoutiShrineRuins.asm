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
	db 1
	warp_def $0, $0, 2, NOISY_FOREST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
