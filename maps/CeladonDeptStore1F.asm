CeladonDeptStore1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  7,  7, CELADON_CITY, 1
	warp_event  8,  7, CELADON_CITY, 1
	warp_event 15,  0, CELADON_DEPT_STORE_2F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, CeladonDeptStore1FDirectoryText

	db 3 ; object events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x709ef, -1
	object_event 11,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x70a35, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x70aa9, -1

UnknownText_0x709ef:
	text "Hello! Welcome to"
	line "Celadon Dept."
	cont "Store!"

	para "The directory is"
	line "on the wall."
	done

UnknownText_0x70a35:
	text "This Dept.Store is"
	line "part of the same"

	para "chain as the one"
	line "in Goldenrod City."

	para "They were both"
	line "renovated at the"
	cont "same time."
	done

UnknownText_0x70aa9:
	text "This is my first"
	line "time here."

	para "It's so big…"

	para "I'm afraid I'll"
	line "get lost."
	done

CeladonDeptStore1FDirectoryText:
	text "1F: Service"
	line "    Counter"

	para "2F: Trainer's"
	line "    Market"

	para "3F: Tech Shop"

	para "4F: Wiseman Gifts"

	para "5F: Drug Store"

	para "6F: Rooftop"
	line "    Atrium"
	done
