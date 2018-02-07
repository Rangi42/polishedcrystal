RuinsofAlphEntranceChamber_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 5
	warp_event  4,  7, RUINS_OF_ALPH_OUTSIDE, 5
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  2,  3, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText

	db 0 ; object events

RuinsofAlphStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
