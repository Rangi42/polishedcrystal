CeruleanMart_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeruleanMart_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 6, CERULEAN_CITY
	warp_def 7, 3, 6, CERULEAN_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 3 ; person events
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_CERULEAN
	person_event SPRITE_COOLTRAINER_M, 6, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x188acd, -1
	person_event SPRITE_COOLTRAINER_F, 2, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x188b46, -1

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
