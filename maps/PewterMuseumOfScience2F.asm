const_value set 2

PewterMuseumOfScience2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PewterMuseumOfScience2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers:
	db 0

.Signposts:
	db 6
	signpost 5, 2, SIGNPOST_READ, ObjectEvent
	signpost 2, 11, SIGNPOST_READ, ObjectEvent
	signpost 1, 0, SIGNPOST_READ, ObjectEvent
	signpost 1, 1, SIGNPOST_READ, ObjectEvent
	signpost 1, 4, SIGNPOST_READ, ObjectEvent
	signpost 1, 5, SIGNPOST_READ, ObjectEvent

.PersonEvents:
	db 4
	person_event SPRITE_SCIENTIST, 5, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_YOUNGSTER, 7, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_LASS, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GRAMPS, 5, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
