PewterMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, PEWTER_CITY, 3
	warp_event  3,  7, PEWTER_CITY, 3

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_PEWTER
	object_event  9,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a2dd8, -1
	object_event  6,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a2e3a, -1

UnknownText_0x1a2dd8:
	text "Hi! Check out my"
	line "Gyarados!"

	para "I raised it from a"
	line "Magikarp. I can't"

	para "believe how strong"
	line "it has become."
	done

UnknownText_0x1a2e3a:
	text "There once was a"
	line "weird old man who"
	cont "sold Magikarp."

	para "He was saying the"
	line "Magikarp from the"

	para "Lake of Rage were"
	line "excellent."
	done
