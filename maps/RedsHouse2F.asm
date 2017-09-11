RedsHouse2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RedsHouse2F_MapEventHeader:

.Warps: db 1
	warp_def 0, 7, 3, REDS_HOUSE_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 1, 0, SIGNPOST_JUMPTEXT, RedsHouse2FPCText
	signpost 5, 3, SIGNPOST_JUMPTEXT, RedsHouse2FSNESText
	signpost 1, 4, SIGNPOST_READ, PokemonJournalProfOakScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalProfOakScript

.PersonEvents: db 0

PokemonJournalProfOakScript:
	setflag ENGINE_READ_PROF_OAK_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Oak!"

	para "Samuel Oak's grand-"
	line "children, Blue and"

	para "Daisy, live near"
	line "his lab in Pallet"
	cont "Town."

	para "His cousin Samson"
	line "is rumored to live"

	para "in the far-off"
	line "Alola region."
	done

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
