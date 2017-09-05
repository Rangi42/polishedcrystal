CeladonDeptStore5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonDeptStore5F_MapEventHeader:

.Warps: db 3
	warp_def 0, 12, 1, CELADON_DEPT_STORE_4F
	warp_def 0, 15, 1, CELADON_DEPT_STORE_6F
	warp_def 0, 2, 1, CELADON_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, CeladonDeptStore5FDirectoryText

.PersonEvents: db 5
	person_event SPRITE_CLERK, 5, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_1, -1
	person_event SPRITE_CLERK, 5, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_2, -1
	person_event SPRITE_GENTLEMAN, 5, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71023, -1
	person_event SPRITE_SAILOR, 3, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71072, -1
	person_event SPRITE_TEACHER, 7, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x710b6, -1

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
