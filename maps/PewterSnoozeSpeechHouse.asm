const_value set 2
	const PEWTERSNOOZESPEECHHOUSE_GRAMPS
	const PEWTERSNOOZESPEECHHOUSE_GRANNY

PewterSnoozeSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GrampsScript_0x1a3059:
	jumptextfaceplayer UnknownText_0x1a305f

PewterSnoozeSpeechHouseGrannyScript:
	jumptextfaceplayer PewterSnoozeSpeechHouseGrannyText

PewterSnoozeSpeechHouseBookshelf:
	jumpstd picturebookshelf

UnknownText_0x1a305f:
	text "I like snoozing"
	line "with the radio on…"
	cont "…Zzzz…"
	done

PewterSnoozeSpeechHouseGrannyText:
	text "Brock is the old-"
	line "est of ten kids."

	para "I don't know how"
	line "his parents coped!"
	done

PewterSnoozeSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 5, PEWTER_CITY
	warp_def $7, $3, 5, PEWTER_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_READ, PewterSnoozeSpeechHouseBookshelf

.PersonEvents:
	db 2
	person_event SPRITE_GRAMPS, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a3059, -1
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PewterSnoozeSpeechHouseGrannyScript, -1
