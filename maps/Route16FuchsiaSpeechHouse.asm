Route16FuchsiaSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, ROUTE_16_NORTHWEST, 1
	warp_event  3,  7, ROUTE_16_NORTHWEST, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, picturebookshelf

	db 2 ; object events
	object_event  2,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x73379, -1
	object_event  5,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route16FuchsiaSpeechHouseLadyText, -1

UnknownText_0x73379:
	text "If you cruise down"
	line "Cycling Road, you"

	para "will end up in"
	line "Fuchsia City."
	done

Route16FuchsiaSpeechHouseLadyText:
	text "The person who"
	line "used to live here"

	para "moved away three"
	line "years ago."

	para "I wonder where"
	line "she went?"
	done
