Route32RuinsofAlphGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route32RuinsofAlphGate_MapEventHeader:

.Warps: db 4
	warp_def 4, 0, 10, RUINS_OF_ALPH_OUTSIDE
	warp_def 5, 0, 11, RUINS_OF_ALPH_OUTSIDE
	warp_def 4, 9, 2, ROUTE_32
	warp_def 5, 9, 3, ROUTE_32

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x69a36, -1
	person_event SPRITE_POKEFAN_M, 2, 8, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x69a81, -1
	person_event SPRITE_YOUNGSTER, 6, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x69abd, -1

UnknownText_0x69a36:
	text "Ruins of Alph"

	para "A Look-and-Touch"
	line "Tourist Site"

	para "Try the sliding"
	line "stone panels!"
	done

UnknownText_0x69a81:
	text "You're studying"
	line "the ruins?"

	para "I see a scientist"
	line "in the making."
	done

UnknownText_0x69abd:
	text "There are drawings"
	line "on stone panels."

	para "I tried moving"
	line "them. I wonder"
	cont "what they are."
	done
