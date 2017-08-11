VioletMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VioletMart_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 1, VIOLET_CITY
	warp_def $7, $3, 1, VIOLET_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_CLERK, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x68295, -1
	person_event SPRITE_GRANNY, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x682a2, -1
	person_event SPRITE_COOLTRAINER_M, 2, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x68323, -1

ClerkScript_0x68295:
	opentext
	pokemart MARTTYPE_STANDARD, MART_VIOLET
	closetext
	end

UnknownText_0x682a2:
	text "When you first"
	line "catch a #mon,"
	cont "it may be weak."

	para "But it will even-"
	line "tually grow to be"
	cont "strong."

	para "It's important to"
	line "treat #mon with"
	cont "love."
	done

UnknownText_0x68323:
	text "#mon can hold"
	line "items like Potion"
	cont "and Antidote."

	para "But they don't"
	line "appear to know how"

	para "to use man-made"
	line "items."
	done
