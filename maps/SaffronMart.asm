SaffronMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SaffronMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, SAFFRON_CITY
	warp_def 7, 3, 3, SAFFRON_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_SAFFRON
	person_event SPRITE_COOLTRAINER_M, 2, 7, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18a3cc, -1
	person_event SPRITE_COOLTRAINER_F, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18a3f3, -1

UnknownText_0x18a3cc:
	text "There's a big"
	line "Radio Tower in"
	cont "Lavender."
	done

UnknownText_0x18a3f3:
	text "I want to become"
	line "stronger, but I'm"
	cont "not good yet…"

	para "Could you show me"
	line "how sometime?"
	done
