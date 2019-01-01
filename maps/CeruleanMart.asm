CeruleanMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 6
	warp_event  3,  7, CERULEAN_CITY, 6

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_CERULEAN
	object_event  1,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x188acd, -1
	object_event  7,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x188b46, -1

UnknownText_0x188acd:
	text "You'll run into"
	line "many trainers on"

	para "the way to Ceru-"
	line "lean Cape."

	para "They want to see"
	line "how they stack"

	para "up against other"
	line "trainers."
	done

UnknownText_0x188b46:
	text "Misty is about the"
	line "only person in"

	para "town who can beat"
	line "the trainers at"
	cont "Cerulean Cape."
	done
