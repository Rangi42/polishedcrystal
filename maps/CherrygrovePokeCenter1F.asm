CherrygrovePokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, CHERRYGROVE_CITY, 2
	warp_event  6,  7, CHERRYGROVE_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalRedScript

	db 5 ; object events
	pc_nurse_event  5, 1
	object_event  1,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, CherrygrovePokeCenter1FTeacherScript, -1
	object_event  8,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FFisherText, -1
	object_event 11,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FGentlemanText, -1
	object_event  9,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FLadyText, -1

PokemonJournalRedScript:
	setflag ENGINE_READ_RED_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "<PK><MN> Trainer Red!"

	para "Red is said to"
	line "have defeated his"

	para "rival Blue for the"
	line "title of #mon"

	para "League Champion in"
	line "record time."
	done

CherrygrovePokeCenter1FTeacherScript:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "The Communication"
	line "Center upstairs"
	cont "was just built."

	para "But they're still"
	line "finishing it up."
	done

.Text2:
	text "The Communication"
	line "Center upstairs"
	cont "was just built."

	para "I traded #mon"
	line "there already!"
	done

CherrygrovePokeCenter1FFisherText:
	text "It's great. I can"
	line "store any number"

	para "of #mon, and"
	line "it's all free."
	done

CherrygrovePokeCenter1FGentlemanText:
	text "That PC is free"
	line "for any trainer"
	cont "to use."
	done

CherrygrovePokeCenter1FLadyText:
	text "#mon Journal"
	line "has such fascin-"
	cont "ating stories!"

	para "I come to #mon"
	line "Centers for the"

	para "latest issues, but"
	line "they're not the"

	para "only place with"
	line "a subscription."
	done
