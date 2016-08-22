const_value set 2
	const EMBEDDEDTOWER_STEVEN

EmbeddedTower_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EmbeddedTower_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $17, $a, 6, ROUTE_47
	warp_def $17, $b, 6, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_COOLTRAINER_M, 9, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
