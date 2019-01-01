PokemonTrainerFanClub_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4,  9, SAFFRON_CITY, 16
	warp_event  5,  9, SAFFRON_CITY, 16

	db 0 ; coord events

	db 2 ; bg events
	bg_event  0,  1, SIGNPOST_READ, PokemonJournalBrunoScript
	bg_event  1,  1, SIGNPOST_READ, PokemonJournalBrunoScript

	db 0 ; object events

PokemonJournalBrunoScript:
	setflag ENGINE_READ_BROCK_JOURNAL
	thistext

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
