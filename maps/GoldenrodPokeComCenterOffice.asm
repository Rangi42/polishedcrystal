GoldenrodPokeComCenterOffice_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

GoldenrodPokeComCenterOffice_MapEventHeader:
	db 2 ; warps
	warp_def 7, 0, 3, GOLDENROD_POKECOM_CENTER_1F
	warp_def 7, 1, 3, GOLDENROD_POKECOM_CENTER_1F

	db 0 ; xy triggers

	db 4 ; signposts
	signpost 2, 3, SIGNPOST_JUMPTEXT, RangiComputerText
	signpost 2, 6, SIGNPOST_JUMPTEXT, LunaComputerText
	signpost 5, 6, SIGNPOST_UP, AizawaComputerScript
	signpost 2, 4, SIGNPOST_READ, RangiKeyboardScript

	db 3 ; person events
	person_event SPRITE_SCIENTIST_F, 4, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminRangiText, -1
	person_event SPRITE_COOLTRAINER_F, 3, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminLunaText, -1
	person_event SPRITE_PHARMACIST, 6, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminAizawaText, -1

const_value set 1
	const GOLDENRODPOKECOMCENTEROFFICE_RANGI

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

AizawaComputerScript:
	thistext

	text "A program called"
	line "Polished Map is"
	cont "displaying a"

	para "half-drawn trop-"
	line "ical island."
	done

RangiKeyboardScript:
	spriteface GOLDENRODPOKECOMCENTEROFFICE_RANGI, UP
	showemote EMOTE_SHOCK, GOLDENRODPOKECOMCENTEROFFICE_RANGI, 10
	thistext

	text "Rangi: Hey! If you"
	line "want to hack the"
	cont "game, use your"
	cont "own computer!"
	done
