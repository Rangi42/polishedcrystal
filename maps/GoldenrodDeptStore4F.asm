GoldenrodDeptStore4F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodDeptStore4F_MapEventHeader:

.Warps: db 3
	warp_def $0, $c, 1, GOLDENROD_DEPT_STORE_5F
	warp_def $0, $f, 2, GOLDENROD_DEPT_STORE_3F
	warp_def $0, $2, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 2
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore4FDirectoryText
	signpost 0, 3, SIGNPOST_JUMPSTD, elevatorbutton

.PersonEvents: db 4
	person_event SPRITE_CLERK, 5, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_MART, 0, MARTTYPE_STANDARD, MART_GOLDENROD_4F, -1
	person_event SPRITE_GAMEBOY_KID, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x55ef7, -1
	person_event SPRITE_COOLTRAINER_M, 7, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x55f08, -1
	person_event SPRITE_BUG_CATCHER, 2, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x55f52, -1

GameboyKidScript_0x55ef7:
	showtextfaceplayer UnknownText_0x55f74
	spriteface LAST_TALKED, DOWN
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
