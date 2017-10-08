RuinsofAlphSinjohChamber_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RuinsofAlphSinjohChamber_MapEventHeader:

.Warps: db 2
	warp_def 9, 5, 12, RUINS_OF_ALPH_OUTSIDE
	warp_def 9, 4, 12, RUINS_OF_ALPH_OUTSIDE

.XYTriggers: db 0

.Signposts: db 3
	signpost 2, 5, SIGNPOST_UP, RuinsofAlphSinjohChamberSignpost
	signpost 3, 4, SIGNPOST_JUMPTEXT, RuinsofAlphSinjohChamberStatueText
	signpost 3, 6, SIGNPOST_JUMPTEXT, RuinsofAlphSinjohChamberStatueText

.PersonEvents: db 4
	person_event SPRITE_PAPER, 1, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MYSTRI_UNOWN_W
	person_event SPRITE_GAMECUBE, 1, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MYSTRI_UNOWN_A
	person_event SPRITE_BOOK, 5, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MYSTRI_UNOWN_R
	person_event SPRITE_POKEDEX, 5, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MYSTRI_UNOWN_P

const_value set 1
	const RUINSOFALPHSINJOHCHAMBER_UNOWN_W
	const RUINSOFALPHSINJOHCHAMBER_UNOWN_A
	const RUINSOFALPHSINJOHCHAMBER_UNOWN_R
	const RUINSOFALPHSINJOHCHAMBER_UNOWN_P

RuinsofAlphSinjohChamberSignpost:
	unowntypeface
	showtext RuinsofAlphSinjohChamberMystriText
	restoretypeface
	showtext RuinsofAlphSinjohChamberSurpriseText
	special Special_FadeOutMusic
	pause 30
	playsound SFX_INTRO_UNOWN_3
	appear RUINSOFALPHSINJOHCHAMBER_UNOWN_W
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_W, LEFT
	waitsfx
	pause 7
	playsound SFX_INTRO_UNOWN_2
	appear RUINSOFALPHSINJOHCHAMBER_UNOWN_A
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_A, LEFT
	waitsfx
	pause 7
	playsound SFX_INTRO_UNOWN_1
	appear RUINSOFALPHSINJOHCHAMBER_UNOWN_R
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_R, LEFT
	waitsfx
	pause 7
	playsound SFX_INTRO_UNOWN_2
	appear RUINSOFALPHSINJOHCHAMBER_UNOWN_P
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_P, LEFT
	waitsfx
	pause 7
	; Call assembly so the fourth sound will play
	callasm .PlayUnownSound3 ; playsound SFX_INTRO_UNOWN_3
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_W, UP
	pause 10
	callasm .PlayUnownSound2 ; playsound SFX_INTRO_UNOWN_2
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_A, UP
	pause 10
	callasm .PlayUnownSound1 ; playsound SFX_INTRO_UNOWN_1
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_R, UP
	pause 10
	callasm .PlayUnownSound2 ; playsound SFX_INTRO_UNOWN_2
	spriteface RUINSOFALPHSINJOHCHAMBER_UNOWN_P, UP
	waitsfx
	pause 30
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_WARP_TO
	applymovement PLAYER, MovementData_WarpToSinjohRuins
	waitsfx
	special FadeOutPalettes
	disappear RUINSOFALPHSINJOHCHAMBER_UNOWN_W
	disappear RUINSOFALPHSINJOHCHAMBER_UNOWN_A
	disappear RUINSOFALPHSINJOHCHAMBER_UNOWN_R
	disappear RUINSOFALPHSINJOHCHAMBER_UNOWN_P
	checkevent EVENT_LISTENED_TO_CYNTHIA_INTRO
	iftrue .HeardIntro
	domaptrigger MYSTRI_STAGE, $1
	setevent EVENT_MYSTRI_STAGE_CYNTHIA
	setevent EVENT_MYSTRI_STAGE_EGG
.HeardIntro
	warp MYSTRI_STAGE, 6, 13
	end

.PlayUnownSound1:
	call SFXChannelsOff
	ld de, SFX_INTRO_UNOWN_1
	jp PlaySFX

.PlayUnownSound2:
	call SFXChannelsOff
	ld de, SFX_INTRO_UNOWN_2
	jp PlaySFX

.PlayUnownSound3:
	call SFXChannelsOff
	ld de, SFX_INTRO_UNOWN_3
	jp PlaySFX

MovementData_WarpToSinjohRuins:
	step_dig 32
	hide_person
	step_end

RuinsofAlphSinjohChamberMystriText:
	text "The lead enters"
	line "the Mystri Stage"
	cont "at last."
	done

RuinsofAlphSinjohChamberSurpriseText
	text "…!"
	done

RuinsofAlphSinjohChamberStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
