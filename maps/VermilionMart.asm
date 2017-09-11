VermilionMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 5, VERMILION_CITY
	warp_def 7, 3, 5, VERMILION_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_VERMILION
	person_event SPRITE_SUPER_NERD, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191f8b, -1
	person_event SPRITE_LADY, 6, 8, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191fca, -1

UnknownText_0x191f8b:
	text "Team Rocket is no"
	line "longer in Kanto."

	para "That alone makes"
	line "me happy."
	done

UnknownText_0x191fca:
	text "I'm thinking about"
	line "going shopping in"
	cont "Saffron."

	para "They sell Luxury"
	line "Balls there."
	done
