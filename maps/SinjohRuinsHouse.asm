const_value set 2
	const SINJOHRUINSHOUSE_POKEFAN_M
	const SINJOHRUINSHOUSE_GRAMPS
	const SINJOHRUINSHOUSE_ABRA

SinjohRuinsHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SinjohRuinsHouseBookshelf:
	jumpstd difficultbookshelf

SinjohRuinsHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, SINJOH_RUINS
	warp_def $7, $3, 2, SINJOH_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 1, 0, SIGNPOST_READ, SinjohRuinsHouseBookshelf
	signpost 1, 1, SIGNPOST_READ, SinjohRuinsHouseBookshelf

.PersonEvents:
	db 3
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GRAMPS, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ABRA, 3, 2, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
