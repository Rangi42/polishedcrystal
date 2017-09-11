OlivineMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 7, OLIVINE_CITY
	warp_def 7, 3, 7, OLIVINE_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_OLIVINE
	person_event SPRITE_COOLTRAINER_F, 2, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9cad4, -1
	person_event SPRITE_LASS, 6, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9cb16, -1

UnknownText_0x9cad4:
	text "Do your #mon"
	line "already know the"

	para "move for carrying"
	line "people on water?"
	done

UnknownText_0x9cb16:
	text "My Butterfree came"
	line "from my boyfriend"
	cont "overseas."

	para "It carried some"
	line "Mail from him."

	para "Want to know what"
	line "it says?"

	para "Let's see… Nope!"
	line "It's a secret!"
	done
