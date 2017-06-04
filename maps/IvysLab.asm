const_value set 2
	const IVYSLAB_IVY
	const IVYSLAB_COOLTRAINER_F

IvysLab_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ProfIvyScript:
	faceplayer
	opentext
	writetext .Text
	waitbutton
	closetext
	end

.Text:
	text "TODO"
	done

IvysLabHopeScript:
	jumptextfaceplayer .Text

.Text:
	text "Hope: TODO"
	done

IvysLabHealingMachine:
	opentext
	writetext .Text
	yesorno
	iftrue .HealParty
	closetext
	end

.HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	closetext
	end

.Text:
	text "Would you like to"
	line "heal your #mon?"
	done

IvysLabWindow:
	jumptext .Text

.Text:
	text "The window's open."

	para "An ocean breeze"
	line "is blowing in."
	done

PokemonJournalProfIvyScript:
	setflag ENGINE_READ_PROF_IVY_JOURNAL
	jumptext .Text

.Text:
	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Ivy!"

	para "Philena Ivy worked"
	line "with Brock of Pew-"
	cont "ter City to study"

	para "a shiny Onix's"
	line "crystalline body."
	done

IvysLabBookshelf:
	jumpstd difficultbookshelf

IvysLab_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 1, VALENCIA_ISLAND
	warp_def $b, $5, 1, VALENCIA_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 14
	signpost 1, 2, SIGNPOST_READ, IvysLabHealingMachine
	signpost 0, 5, SIGNPOST_READ, IvysLabWindow
	signpost 1, 6, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 7, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 8, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 9, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 0, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 1, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 2, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 3, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 6, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 7, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 8, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 9, SIGNPOST_READ, IvysLabBookshelf

.PersonEvents:
	db 2
	person_event SPRITE_IVY, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ProfIvyScript, -1
	person_event SPRITE_COOLTRAINER_F, 9, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, IvysLabHopeScript, -1
