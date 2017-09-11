CherrygrovePokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CherrygrovePokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 2, CHERRYGROVE_CITY
	warp_def 7, 6, 2, CHERRYGROVE_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalRedScript

.PersonEvents: db 5
	pc_nurse_event 1, 5
	person_event SPRITE_TEACHER, 6, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CherrygrovePokeCenter1FTeacherScript, -1
	person_event SPRITE_FISHER, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FFisherText, -1
	person_event SPRITE_GENTLEMAN, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FGentlemanText, -1
	person_event SPRITE_LADY, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FLadyText, -1

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
