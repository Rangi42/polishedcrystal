const_value set 2

ShamoutiCoast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiCoast_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $f, $16, 1, FIRE_ISLAND
	warp_def $b, $36, 1, ICE_ISLAND
	warp_def $d, $54, 1, LIGHTNING_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
;	person_event SPRITE_, ?, ?, SPRITEMOVEDATA_, 0, 0, -1, -1, (1 << 3) | PAL_OW_, PERSONTYPE_TRAINER, 0, Trainer, -1
;	person_event SPRITE_, ?, ?, SPRITEMOVEDATA_, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ShamoutiShrineRuins?Script, -1
