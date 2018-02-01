BluesHouse2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 1 ; warps
	warp_def 0, 7, 3, BLUES_HOUSE_1F

	db 0 ; xy triggers

	db 4 ; signposts
	signpost 1, 0, SIGNPOST_JUMPTEXT, BluesHouse2FPCText
	signpost 5, 3, SIGNPOST_JUMPTEXT, BluesHouse2FSNESText
	signpost 1, 4, SIGNPOST_READ, PokemonJournalProfOakScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalProfOakScript

	db 0 ; person events

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
