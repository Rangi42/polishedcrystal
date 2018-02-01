PewterSnoozeSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 5, PEWTER_CITY
	warp_def 7, 3, 5, PEWTER_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 7, SIGNPOST_JUMPSTD, picturebookshelf

	db 2 ; person events
	person_event SPRITE_GRAMPS, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a305f, -1
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, PewterSnoozeSpeechHouseGrannyText, -1

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
