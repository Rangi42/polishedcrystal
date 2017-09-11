CinnabarPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CinnabarPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 1, CINNABAR_ISLAND
	warp_def 7, 6, 1, CINNABAR_ISLAND
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalBlaineScript

.PersonEvents: db 3
	pc_nurse_event 1, 5
	person_event SPRITE_COOLTRAINER_F, 5, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CinnabarPokeCenter1FCooltrainerfText, -1
	person_event SPRITE_FISHER, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CinnabarPokeCenter1FFisherText, -1

PokemonJournalBlaineScript:
	setflag ENGINE_READ_BLAINE_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Blaine!"

	para "Blaine is said to"
	line "only remove his"

	para "shades when he is"
	line "thinking up new"
	cont "riddles."
	done

CinnabarPokeCenter1FCooltrainerfText:
	text "Cinnabar Gym's"
	line "Blaine apparently"

	para "lives alone in the"
	line "Seafoam Islands"
	cont "cave…"
	done

CinnabarPokeCenter1FFisherText:
	text "It's been a year"
	line "since the volcano"
	cont "erupted."
	done
