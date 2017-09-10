GoldenrodDeptStore2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodDeptStore2F_MapEventHeader:

.Warps: db 3
	warp_def 0, 12, 1, GOLDENROD_DEPT_STORE_3F
	warp_def 0, 15, 3, GOLDENROD_DEPT_STORE_1F
	warp_def 0, 2, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore2FDirectoryText

.PersonEvents: db 5
	person_event SPRITE_CLERK, 5, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_2F_1, -1
	person_event SPRITE_CLERK, 6, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x55b65, -1
	person_event SPRITE_YOUNGSTER, 6, 9, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55c25, -1
	person_event SPRITE_COOLTRAINER_F, 2, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55c7b, -1
	person_event SPRITE_GENTLEMAN, 6, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55cb7, -1

ClerkScript_0x55b65:
	checkevent EVENT_GOT_EEVEE
	iftrue .eevee
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_2F_2

.eevee
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_2F_2_EEVEE

UnknownText_0x55c25:
	text "#gear can store"
	line "up to twenty"
	cont "phone numbers."

	para "It's hard to de-"
	line "cide which numbers"
	cont "to keep."
	done

UnknownText_0x55c7b:
	text "I got my Abra at"
	line "the Game Corner."

	para "Now it's my best"
	line "partner."
	done

UnknownText_0x55cb7:
	text "This Dept.Store"
	line "makes me realize"

	para "that Goldenrod is"
	line "a big city."

	para "The selection here"
	line "is unmatched any-"
	cont "where else."
	done

GoldenrodDeptStore2FDirectoryText:
	text "Your Travel"
	line "Companion"

	para "2F Trainer's"
	line "   Market"
	done
