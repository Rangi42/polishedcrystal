ViridianMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VIRIDIAN_CITY, 4
	warp_event  3,  7, VIRIDIAN_CITY, 4

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_VIRIDIAN
	object_event  7,  2, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b5f4, -1
	object_event  1,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b61a, -1

UnknownText_0x9b5f4:
	text "The Gym Leader"
	line "here is totally"
	cont "cool."

	para "He's the only one"
	line "without a type"
	cont "specialty."

	para "He likes to keep"
	line "people guessing."
	done

UnknownText_0x9b61a:
	text "Have you been to"
	line "Cinnabar?"

	para "It's an island way"
	line "south of here."
	done
