CherrygroveMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CherrygroveMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, CHERRYGROVE_CITY
	warp_def 7, 3, 1, CHERRYGROVE_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_CLERK, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x19680a, -1
	person_event SPRITE_COOLTRAINER_M, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19681d, -1
	person_event SPRITE_YOUNGSTER, 5, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1968a0, -1

ClerkScript_0x19680a:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .AfterDex
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE

.AfterDex:
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE_DEX

CooltrainerMScript_0x19681d:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .AfterDex
	jumptextfaceplayer UnknownText_0x196834

.AfterDex:
	jumptextfaceplayer UnknownText_0x196873

UnknownText_0x196834:
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
