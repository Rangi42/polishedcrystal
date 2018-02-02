OlivineMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_OLIVINE
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9cad4, -1
	object_event  1,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9cb16, -1

UnknownText_0x9cad4:
	text "Do your #mon"
	line "already know the"

	para "move for carrying"
	line "people on water?"
	done

UnknownText_0x9cb16:
	text "My Butterfree came"
	line "from my boyfriend"
	cont "overseas."

	para "It carried some"
	line "Mail from him."

	para "Want to know what"
	line "it says?"

	para "Let's see… Nope!"
	line "It's a secret!"
	done
