BluesHouse2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  7,  0, BLUES_HOUSE_1F, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPTEXT, BluesHouse2FPCText
	bg_event  3,  5, SIGNPOST_JUMPTEXT, BluesHouse2FSNESText
	bg_event  4,  1, SIGNPOST_READ, PokemonJournalProfOakScript
	bg_event  5,  1, SIGNPOST_READ, PokemonJournalProfOakScript

	db 0 ; object events

BluesHouse2FPCText:
	text "There's a program"
	line "simulating a bat-"
	cont "tle between a"

	para "Blastoise and a"
	line "Dragonite."
	done

BluesHouse2FSNESText:
	text "<PLAYER> played the"
	line "SNES."

	para "Better get going--"
	line "no time to lose!"
	done
