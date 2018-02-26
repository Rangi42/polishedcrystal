GoldenrodPokeComCenterOffice_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  0,  7, GOLDENROD_POKECOM_CENTER_1F, 3
	warp_event  1,  7, GOLDENROD_POKECOM_CENTER_1F, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event  3,  2, SIGNPOST_JUMPTEXT, RangiComputerText
	bg_event  6,  2, SIGNPOST_JUMPTEXT, LunaComputerText
	bg_event  6,  5, SIGNPOST_UP, AizawaComputerScript
	bg_event  4,  2, SIGNPOST_READ, RangiKeyboardScript

	db 3 ; object events
	object_event  4,  4, SPRITE_SCIENTIST_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminRangiText, -1
	object_event  7,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminLunaText, -1
	object_event  7,  6, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, AdminAizawaText, -1

	const_def 1 ; object constants
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
	turnobject GOLDENRODPOKECOMCENTEROFFICE_RANGI, UP
	showemote EMOTE_SHOCK, GOLDENRODPOKECOMCENTEROFFICE_RANGI, 10
	thistext

	text "Rangi: Hey! If you"
	line "want to hack the"
	cont "game, use your"
	cont "own computer!"
	done
