PewterSnoozeSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, PEWTER_CITY, 5
	warp_event  3,  7, PEWTER_CITY, 5

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, picturebookshelf

	db 2 ; object events
	object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a305f, -1
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, PewterSnoozeSpeechHouseGrannyText, -1

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
