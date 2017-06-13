const_value set 2
	const CHERRYGROVEPOKECENTER1F_NURSE
	const CHERRYGROVEPOKECENTER1F_FISHER
	const CHERRYGROVEPOKECENTER1F_GENTLEMAN
	const CHERRYGROVEPOKECENTER1F_TEACHER
	const CHERRYGROVEPOKECENTER1F_LADY

CherrygrovePokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x19696d:
	jumpstd pokecenternurse

FisherScript_0x196970:
	jumptextfaceplayer UnknownText_0x19698a

GentlemanScript_0x196973:
	jumptextfaceplayer UnknownText_0x1969c8

TeacherScript_0x196976:
	faceplayer
	opentext
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue UnknownScript_0x196984
	writetext UnknownText_0x1969f1
	waitbutton
	closetext
	end

UnknownScript_0x196984:
	writetext UnknownText_0x196a46
	waitbutton
	closetext
	end

CherrygrovePokeCenter1FLadyScript:
	jumptextfaceplayer CherrygrovePokeCenter1FLadyText

PokemonJournalRedScript:
	setflag ENGINE_READ_RED_JOURNAL
	jumptext PokemonJournalRedText

UnknownText_0x19698a:
	text "It's great. I can"
	line "store any number"

	para "of #mon, and"
	line "it's all free."
	done

UnknownText_0x1969c8:
	text "That PC is free"
	line "for any trainer"
	cont "to use."
	done

UnknownText_0x1969f1:
	text "The Communication"
	line "Center upstairs"
	cont "was just built."

	para "But they're still"
	line "finishing it up."
	done

UnknownText_0x196a46:
	text "The Communication"
	line "Center upstairs"
	cont "was just built."

	para "I traded #mon"
	line "there already!"
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

PokemonJournalRedText:
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

CherrygrovePokeCenter1F_MapEventHeader:
.Warps:
	db 3
	warp_def $7, $5, 2, CHERRYGROVE_CITY
	warp_def $7, $6, 2, CHERRYGROVE_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalRedScript

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x19696d, -1
	person_event SPRITE_FISHER, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x196970, -1
	person_event SPRITE_GENTLEMAN, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x196973, -1
	person_event SPRITE_TEACHER, 6, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, TeacherScript_0x196976, -1
	person_event SPRITE_LADY, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CherrygrovePokeCenter1FLadyScript, -1
