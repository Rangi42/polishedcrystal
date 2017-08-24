GoldenrodDeptStore3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodDeptStore3F_MapEventHeader:

.Warps: db 3
	warp_def 0, 12, 1, GOLDENROD_DEPT_STORE_2F
	warp_def 0, 15, 2, GOLDENROD_DEPT_STORE_4F
	warp_def 0, 2, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore3FDirectoryText

.PersonEvents: db 3
	person_event SPRITE_CLERK, 1, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_3F, -1
	person_event SPRITE_SUPER_NERD, 5, 12, SPRITEMOVEDATA_SPINRANDOM_FAST, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55dcc, -1
	person_event SPRITE_ROCKER, 5, 2, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55e15, -1

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
