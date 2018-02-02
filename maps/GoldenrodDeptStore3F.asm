GoldenrodDeptStore3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_2F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_4F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, GoldenrodDeptStore3FDirectoryText

	db 3 ; object events
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_3F, -1
	object_event 12,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 1, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55dcc, -1
	object_event  2,  5, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55e15, -1

UnknownText_0x55dcc:
	text "I, I, I'm really"
	line "impatient!"

	para "I use X Speed in"
	line "battle to speed up"
	cont "my #mon."
	done

UnknownText_0x55e15:
	text "Hey! When you bat-"
	line "tle, do you use X"
	cont "Spcl.Atk?"

	para "It's awesome. It"
	line "really jacks up"
	cont "Special Attack!"
	done

GoldenrodDeptStore3FDirectoryText:
	text "For Victory"
	line "Seekers"

	para "3F Battle"
	line "   Collection"
	done
