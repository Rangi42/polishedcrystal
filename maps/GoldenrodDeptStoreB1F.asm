GoldenrodDeptStoreB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_TILES, UnknownScript_0x7d781
	callback MAPCALLBACK_NEWMAP, UnknownScript_0x7d7ac

	db 3 ; warp events
	warp_event 17,  2, UNDERGROUND_WAREHOUSE, 3
	warp_event  9,  4, GOLDENROD_DEPT_STORE_ELEVATOR, 1
	warp_event 10,  4, GOLDENROD_DEPT_STORE_ELEVATOR, 2

	db 0 ; coord events

	db 0 ; bg events

	db 8 ; object events
	itemball_event 10, 15, ETHER, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ETHER
	itemball_event 14,  2, METAL_COAT, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_METAL_COAT
	itemball_event  6,  3, BURN_HEAL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_BURN_HEAL
	itemball_event 15, 15, ULTRA_BALL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ULTRA_BALL
	object_event  9, 10, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d7cb, -1
	object_event  4,  8, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d82c, -1
	object_event  6, 13, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d875, -1
	object_event  7,  7, SPRITE_MACHOKE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_POKEMON, MACHOKE, UnknownText_0x7d8bb, -1

UnknownScript_0x7d781:
	checkevent EVENT_RECEIVED_CARD_KEY
	iftrue UnknownScript_0x7d78a
	jump UnknownScript_0x7d791

UnknownScript_0x7d78a:
	changeblock 16, 4, $d
	jump UnknownScript_0x7d791

UnknownScript_0x7d791:
	checkevent EVENT_WAREHOUSE_LAYOUT_2
	iftrue .Layout2
	checkevent EVENT_WAREHOUSE_LAYOUT_3
	iftrue .Layout3
	changeblock 10, 8, $d
	return

.Layout2:
	changeblock 4, 10, $d
	return

.Layout3:
	changeblock 10, 12, $d
	return

UnknownScript_0x7d7ac:
	clearevent EVENT_WAREHOUSE_BLOCKED_OFF
	return

UnknownText_0x7d7cb:
	text "Hey, kid! You're"
	line "holding us up!"

	para "Our policy is to"
	line "work behind the"

	para "scenes where no"
	line "one can see us!"
	done

UnknownText_0x7d82c:
	text "I lose my passion"
	line "for work if some-"
	cont "one's watching."

	para "Come on, kid,"
	line "scoot!"
	done

UnknownText_0x7d875:
	text "Oohah! Oohah!"

	para "The stuff on the"
	line "ground's junk."

	para "Take it if you"
	line "want it!"
	done

UnknownText_0x7d8bb:
	text "Machoke: Maaacho!"
	done
