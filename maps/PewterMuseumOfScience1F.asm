const_value set 2

PewterMuseumOfScience1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PewterMuseumOfScience1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $7, $a, 6, PEWTER_CITY
	warp_def $7, $b, 6, PEWTER_CITY
	warp_def $7, $10, 7, PEWTER_CITY
	warp_def $7, $11, 7, PEWTER_CITY
	warp_def $7, $7, 1, PEWTER_MUSEUM_OF_SCIENCE_2F

.XYTriggers:
	db 0

.Signposts:
	db 9
	signpost 4, 11, SIGNPOST_READ, ObjectEvent
	signpost 3, 2, SIGNPOST_READ, ObjectEvent
	signpost 6, 2, SIGNPOST_READ, ObjectEvent
	signpost 1, 12, SIGNPOST_READ, ObjectEvent
	signpost 1, 13, SIGNPOST_READ, ObjectEvent
	signpost 1, 14, SIGNPOST_READ, ObjectEvent
	signpost 1, 15, SIGNPOST_READ, ObjectEvent
	signpost 1, 16, SIGNPOST_READ, ObjectEvent
	signpost 1, 17, SIGNPOST_READ, ObjectEvent

.PersonEvents:
	db 4
	person_event SPRITE_RECEPTIONIST, 4, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_SCIENTIST, 2, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_SCIENTIST, 3, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GRAMPS, 4, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
