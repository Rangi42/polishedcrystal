CeladonMansion2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CeladonMansion2F_MapEventHeader:
	db 4 ; warps
	warp_def 0, 0, 4, CELADON_MANSION_1F
	warp_def 0, 1, 2, CELADON_MANSION_3F
	warp_def 0, 6, 3, CELADON_MANSION_3F
	warp_def 0, 7, 5, CELADON_MANSION_1F

	db 0 ; xy triggers

	db 3 ; signposts
	signpost 3, 0, SIGNPOST_JUMPTEXT, CeladonMansion2FComputerText
	signpost 8, 5, SIGNPOST_UP, CeladonMansion2FSign
	signpost 3, 2, SIGNPOST_JUMPSTD, difficultbookshelf

	db 0 ; person events

CeladonMansion2FSign:
	jumptext CeladonMansion2FSignText

CeladonMansion2FComputerText:
	text "<PLAYER> turned on"
	line "the PC."

	para "…"

	para "Someone was in the"
	line "middle of compos-"
	cont "ing an e-mail."

	para "…I hope you'll"
	line "come visit Kanto."

	para "I think you'll be"
	line "surprised at how"

	para "much things have"
	line "changed here."

	para "You'll also see"
	line "many #mon that"

	para "aren't native to"
	line "Johto."

	para "To the Producer"

	para "…"
	done

CeladonMansion2FSignText:
	text "GAME FREAK"
	line "Meeting Room"
	done
