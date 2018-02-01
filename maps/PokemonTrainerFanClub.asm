PokemonTrainerFanClub_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 9, 4, 16, SAFFRON_CITY
	warp_def 9, 5, 16, SAFFRON_CITY

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 1, 0, SIGNPOST_READ, PokemonJournalBrunoScript
	signpost 1, 1, SIGNPOST_READ, PokemonJournalBrunoScript

	db 0 ; person events

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
