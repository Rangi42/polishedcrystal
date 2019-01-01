GoldenrodDeptStore2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_3F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_1F, 3
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, GoldenrodDeptStore2FDirectoryText

	db 5 ; object events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_2F_1, -1
	object_event 13,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x55b65, -1
	object_event  9,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55c25, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55c7b, -1
	object_event  2,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55cb7, -1

ClerkScript_0x55b65:
	checkevent EVENT_GOT_EEVEE
	iftrue .eevee
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_2F_2

.eevee
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_2F_2_EEVEE

UnknownText_0x55c25:
	text "#gear can store"
	line "up to thirty" ; CONTACT_LIST_SIZE
	cont "phone numbers."

	para "But getting too"
	line "many phone calls"
	cont "can be annoying."
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
