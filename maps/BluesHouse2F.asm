BluesHouse2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BluesHouse2F_MapEventHeader:

.Warps: db 1
	warp_def 0, 7, 3, BLUES_HOUSE_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 1, 0, SIGNPOST_JUMPTEXT, BluesHouse2FPCText
	signpost 5, 3, SIGNPOST_JUMPTEXT, BluesHouse2FSNESText
	signpost 1, 4, SIGNPOST_READ, PokemonJournalProfOakScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalProfOakScript

.PersonEvents: db 0

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
