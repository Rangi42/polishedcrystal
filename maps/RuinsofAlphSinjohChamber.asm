const_value set 2

RuinsofAlphSinjohChamber_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RuinsofAlphSinjohChamberSignpost:
	opentext
	writetext RuinsofAlphSinjohChamberMystriText
	waitbutton
	closetext
	special Special_FadeOutMusic
	pause 30
	playsound SFX_INTRO_UNOWN_3
	waitsfx
	playsound SFX_INTRO_UNOWN_2
	waitsfx
	playsound SFX_INTRO_UNOWN_1
	waitsfx
	playsound SFX_INTRO_UNOWN_2
	waitsfx
	; Call assembly so the fourth sound will play
	callasm PlayUnownSound3 ; playsound SFX_INTRO_UNOWN_3
	pause 10
	callasm PlayUnownSound2 ; playsound SFX_INTRO_UNOWN_2
	pause 10
	callasm PlayUnownSound1 ; playsound SFX_INTRO_UNOWN_1
	pause 10
	callasm PlayUnownSound2 ; playsound SFX_INTRO_UNOWN_2
	waitsfx
	pause 30
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_WARP_TO
	applymovement PLAYER, MovementData_WarpToSinjohRuins
	waitsfx
	special FadeOutPalettes
	warp MYSTRI_STAGE, $6, $d
	end

RuinsofAlphSinjohChamberStatue:
	jumptext RuinsofAlphSinjohChamberStatueText

MovementData_WarpToSinjohRuins:
	step_dig 32
	hide_person
	step_end

RuinsofAlphSinjohChamberMystriText:
	text "It's a panel with"
	line "strange writing."

	para "Wait… the text"
	line "is starting to"
	cont "make sense?"

	para "<``>The lead enters"
	line "the Mystri Stage"
	cont "at last.<''>"

	para "…!"
	done

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
	db 3
	signpost 2, 3, SIGNPOST_READ, RuinsofAlphSinjohChamberSignpost
	signpost 3, 2, SIGNPOST_READ, RuinsofAlphSinjohChamberStatue
	signpost 3, 4, SIGNPOST_READ, RuinsofAlphSinjohChamberStatue

.PersonEvents:
	db 0

PlayUnownSound1:
	call SFXChannelsOff
	ld d, 0
	ld e, SFX_INTRO_UNOWN_1
	call PlaySFX
	ret

PlayUnownSound2:
	call SFXChannelsOff
	ld d, 0
	ld e, SFX_INTRO_UNOWN_2
	call PlaySFX
	ret

PlayUnownSound3:
	call SFXChannelsOff
	ld d, 0
	ld e, SFX_INTRO_UNOWN_3
	call PlaySFX
	ret