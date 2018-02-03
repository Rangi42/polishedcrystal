CherrygroveMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CHERRYGROVE_CITY, 1
	warp_event  3,  7, CHERRYGROVE_CITY, 1

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x19680a, -1
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19681d, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1968a0, -1

ClerkScript_0x19680a:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .AfterDex
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE

.AfterDex:
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE_DEX

CooltrainerMScript_0x19681d:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer UnknownText_0x196873
	thistextfaceplayer

	text "They're fresh out"
	line "of # Balls!"

	para "When will they get"
	line "more of them?"
	done

UnknownText_0x196873:
	text "# Balls are in"
	line "stock! Now I can"
	cont "catch #mon!"
	done

UnknownText_0x1968a0:
	text "When I was walking"
	line "in the grass, a"

	para "bug #mon poi-"
	line "soned my #mon!"

	para "I just kept going,"
	line "and my #mon"
	cont "barely recovered."

	para "You should keep an"
	line "Antidote with you."
	done
