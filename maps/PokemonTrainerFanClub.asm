PokemonTrainerFanClub_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PokemonTrainerFanClub_MapEventHeader:

.Warps: db 2
	warp_def 9, 4, 16, SAFFRON_CITY
	warp_def 9, 5, 16, SAFFRON_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 0, SIGNPOST_READ, PokemonJournalBrunoScript
	signpost 1, 1, SIGNPOST_READ, PokemonJournalBrunoScript

.PersonEvents: db 0

PokemonJournalBrunoScript:
	setflag ENGINE_READ_BROCK_JOURNAL
	jumptext PokemonJournalBrunoText

PokemonJournalBrunoText:
	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Bruno!"

	para "Bruno apparently"
	line "joined the Elite"

	para "Four out of his"
	line "burning ambition"

	para "to battle the"
	line "best trainers."
	done
