RuinsofAlphEntranceChamber_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

RuinsofAlphEntranceChamber_MapEventHeader:
	db 3 ; warps
	warp_def 7, 3, 5, RUINS_OF_ALPH_OUTSIDE
	warp_def 7, 4, 5, RUINS_OF_ALPH_OUTSIDE
	warp_def 3, 4, 1, RUINS_OF_ALPH_INNER_CHAMBER

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 3, 2, SIGNPOST_JUMPTEXT, RuinsofAlphEntranceChamberStatueText

	db 0 ; person events

RuinsofAlphEntranceChamberStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
