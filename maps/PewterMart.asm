PewterMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PewterMart_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 3, PEWTER_CITY
	warp_def $7, $3, 3, PEWTER_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_CLERK, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_MART, 0, MARTTYPE_STANDARD, MART_PEWTER, -1
	person_event SPRITE_YOUNGSTER, 2, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1a2dd8, -1
	person_event SPRITE_SUPER_NERD, 6, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1a2e3a, -1

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
