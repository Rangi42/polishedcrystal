RedsHouse2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RedsHouse2FPCScript:
	jumptext RedsHouse2FPCText

RedsHouse2FSNESScript:
	jumptext RedsHouse2FSNESText

PokemonJournalProfOakScript:
	setflag ENGINE_READ_PROF_OAK_JOURNAL
	jumptext PokemonJournalProfOakText

RedsHouse2FPCText:
	text "It looks like it"
	line "hasn't been used"
	cont "in a long time…"
	done

RedsHouse2FSNESText:
	text "<PLAYER> played the"
	line "SNES."

	para "Better get going--"
	line "no time to lose!"
	done

PokemonJournalProfOakText:
	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Oak!"

	para "Prof.Oak's grand-"
	line "children, Blue and"

	para "Daisy, reportedly"
	line "live near his lab"
	cont "in Pallet Town."

	para "His cousin Samson"
	line "is rumored to live"
	cont "in far-off Alola."
	done

RedsHouse2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $7, 3, REDS_HOUSE_1F

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 1, 0, SIGNPOST_READ, RedsHouse2FPCScript
	signpost 5, 3, SIGNPOST_READ, RedsHouse2FSNESScript
	signpost 1, 4, SIGNPOST_READ, PokemonJournalProfOakScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalProfOakScript

.PersonEvents:
	db 0
