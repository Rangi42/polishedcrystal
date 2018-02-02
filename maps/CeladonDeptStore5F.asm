CeladonDeptStore5F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 12,  0, CELADON_DEPT_STORE_4F, 1
	warp_event 15,  0, CELADON_DEPT_STORE_6F, 1
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, CeladonDeptStore5FDirectoryText

	db 5 ; object events
	object_event  7,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_1, -1
	object_event  8,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_2, -1
	object_event 13,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71023, -1
	object_event  3,  3, SPRITE_SAILOR, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71072, -1
	object_event  1,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x710b6, -1

UnknownText_0x71023:
	text "I want to buy some"
	line "items that raise"

	para "#mon stats, but"
	line "I don't have"
	cont "enough money…"
	done

UnknownText_0x71072:
	text "I want PP Up, so I"
	line "can raise the PP"

	para "of moves. But you"
	line "can't buy it…"
	done

UnknownText_0x710b6:
	text "Using items on"
	line "them makes #-"
	cont "mon happy."

	para "They hate certain"
	line "items, though…"
	done

CeladonDeptStore5FDirectoryText:
	text "Bring Out"
	line "#mon Potential"

	para "5F: Drug Store"
	done
