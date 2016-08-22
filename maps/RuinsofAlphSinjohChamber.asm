const_value set 2

RuinsofAlphSinjohChamber_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RuinsofAlphSinjohChamberSignpost1:
	opentext
	writetext RuinsofAlphSinjohChamberStatueText
	waitbutton
	closetext
	special FadeOutPalettes
	warp MYSTRI_STAGE, $6, $d
	end

RuinsofAlphSinjohChamberSignpost2:
	jumptext RuinsofAlphSinjohChamberStatueText

RuinsofAlphSinjohChamberStatue:
	jumptext RuinsofAlphSinjohChamberStatueText

MovementData_WarpToSinjohRuins:
	step_dig 32
	hide_person
	step_end

RuinsofAlphSinjohChamberStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

RuinsofAlphSinjohChamber_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $3, 12, RUINS_OF_ALPH_OUTSIDE
	warp_def $9, $4, 12, RUINS_OF_ALPH_OUTSIDE

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 2, 3, SIGNPOST_READ, RuinsofAlphSinjohChamberSignpost1
	signpost 2, 3, SIGNPOST_READ, RuinsofAlphSinjohChamberSignpost2
	signpost 3, 2, SIGNPOST_READ, RuinsofAlphSinjohChamberStatue
	signpost 3, 5, SIGNPOST_READ, RuinsofAlphSinjohChamberStatue

.PersonEvents:
	db 0
