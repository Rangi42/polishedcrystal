
GoldenrodPokeComCenterOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodPokeComCenterOffice_MapEventHeader:

.Warps: db 2
	warp_def 7, 0, 3, GOLDENROD_POKECOM_CENTER_1F
	warp_def 7, 1, 3, GOLDENROD_POKECOM_CENTER_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 2, 3, SIGNPOST_JUMPTEXT, RangiComputerText
	signpost 2, 6, SIGNPOST_JUMPTEXT, LunaComputerText
	signpost 5, 6, SIGNPOST_JUMPTEXT, AizawaComputerText

.PersonEvents: db 3
	person_event SPRITE_SCIENTIST_F, 4, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminRangiText, -1
	person_event SPRITE_COOLTRAINER_F, 3, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminLunaText, -1
	person_event SPRITE_PHARMACIST, 6, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminAizawaText, -1

AdminRangiText:
	text "Rangi: I hope"
	line "you're enjoying"

	para "your journey"
	line "through this game!"

	para "We had trouble"
	line "fitting all the"
	cont "data in for it."

	para "There was barely"
	line "even enough room"
	cont "for my sprite!"
	done

AdminLunaText:
	text "Luna: When you"
	line "Wonder Traded"

	para "with someone in"
	line "another region"

	para "for the first"
	line "time, weren't you"
	cont "impressed?"

	para "I built the orig-"
	line "inal system right"
	cont "here in Goldenrod!"
	done

AdminAizawaText:
	text "Aizawa: Dialog,"
	line "map designs,"
	cont "character sprites,"
	cont "trainer teams…"

	para "Game Freak over"
	line "in Kanto is lucky"

	para "to have a whole"
	line "team for this!"
	done

RangiComputerText:
	text "There's a screen-"
	line "saver endlessly"

	para "running through"
	line "a 3D maze."
	done

LunaComputerText:
	text "Network traffic"
	line "from Wonder Trades"

	para "is streaming by"
	line "on the screen."
	done

AizawaComputerText:
	text "A program called"
	line "Polished Map is"
	cont "displaying a"

	para "half-drawn trop-"
	line "ical island."
	done
