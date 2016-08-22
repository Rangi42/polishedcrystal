const_value set 2
	const MYSTRISTAGE_CYNTHIA

MystriStage_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MystriStage_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $11, $6, 1, SINJOH_RUINS
	warp_def $11, $7, 1, SINJOH_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_COOLTRAINER_F, 5, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
