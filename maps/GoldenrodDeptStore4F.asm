GoldenrodDeptStore4F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_5F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_3F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, GoldenrodDeptStore4FDirectoryText

	db 4 ; object events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_4F, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x55ef7, -1
	object_event 11,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55f08, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55f52, -1

GameboyKidScript_0x55ef7:
	showtextfaceplayer UnknownText_0x55f74
	turnobject LAST_TALKED, DOWN
	end

UnknownText_0x55f08:
	text "Hey. I love strong"
	line "#mon."

	para "I feed them Pro-"
	line "tein to crank up"
	cont "their Attack."
	done

UnknownText_0x55f52:
	text "Iron adds to your"
	line "#mon's Defense."
	done

UnknownText_0x55f74:
	text "Some #mon"
	line "evolve only"

	para "when they hold"
	line "a certain item."

	para "I know of four:"
	line "Poliwhirl, Onix,"

	para "Slowpoke and, um,"
	line "Scyther."

	para "I heard there are"
	line "others too."
	done

GoldenrodDeptStore4FDirectoryText:
	text "Let Us Pump Up"
	line "Your #mon!"

	para "4F Medicine Box"
	done
