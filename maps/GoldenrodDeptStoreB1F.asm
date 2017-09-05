GoldenrodDeptStoreB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_TILES, UnknownScript_0x7d781
	dbw MAPCALLBACK_NEWMAP, UnknownScript_0x7d7ac

GoldenrodDeptStoreB1F_MapEventHeader:

.Warps: db 3
	warp_def 2, 17, 3, UNDERGROUND_WAREHOUSE
	warp_def 4, 9, 1, GOLDENROD_DEPT_STORE_ELEVATOR
	warp_def 4, 10, 2, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 8
	itemball_event 15, 10, ETHER, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ETHER
	itemball_event 2, 14, METAL_COAT, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_METAL_COAT
	itemball_event 3, 6, BURN_HEAL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_BURN_HEAL
	itemball_event 15, 15, ULTRA_BALL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ULTRA_BALL
	person_event SPRITE_BLACK_BELT, 10, 9, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d7cb, -1
	person_event SPRITE_BLACK_BELT, 8, 4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d82c, -1
	person_event SPRITE_BLACK_BELT, 13, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7d875, -1
	person_event SPRITE_MACHOKE, 7, 7, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, MACHOKE, UnknownText_0x7d8bb, -1

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
