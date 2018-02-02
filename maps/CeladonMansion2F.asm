CeladonMansion2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  0,  0, CELADON_MANSION_1F, 4
	warp_event  1,  0, CELADON_MANSION_3F, 2
	warp_event  6,  0, CELADON_MANSION_3F, 3
	warp_event  7,  0, CELADON_MANSION_1F, 5

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  3, SIGNPOST_JUMPTEXT, CeladonMansion2FComputerText
	bg_event  5,  8, SIGNPOST_UP, CeladonMansion2FSign
	bg_event  2,  3, SIGNPOST_JUMPSTD, difficultbookshelf

	db 0 ; object events

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
