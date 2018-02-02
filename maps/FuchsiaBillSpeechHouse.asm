FuchsiaBillSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, FUCHSIA_CITY, 3
	warp_event  3,  7, FUCHSIA_CITY, 3

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1963c3, -1
	object_event  6,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1963f9, -1

UnknownText_0x1963c3:
	text "My grandpa is at"
	line "my brother Bill's"
	cont "in Goldenrod City."
	done

UnknownText_0x1963f9:
	text "I saw these weird,"
	line "slow #mon on"
	cont "Cycling Road."
	done
