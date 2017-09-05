RuinsofAlphEntranceChamber_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RuinsofAlphEntranceChamber_MapEventHeader:

.Warps: db 3
	warp_def 7, 3, 5, RUINS_OF_ALPH_OUTSIDE
	warp_def 7, 4, 5, RUINS_OF_ALPH_OUTSIDE
	warp_def 3, 4, 1, RUINS_OF_ALPH_INNER_CHAMBER

.XYTriggers: db 0

.Signposts: db 1
	signpost 3, 2, SIGNPOST_JUMPTEXT, RuinsofAlphEntranceChamberStatueText

.PersonEvents: db 0

RuinsofAlphEntranceChamberStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
