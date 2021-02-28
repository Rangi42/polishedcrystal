	const_def
	const INCOMPATIBLE
	const SLIGHTLY_COMPATIBLE
	const MODERATELY_COMPATIBLE
	const HIGHLY_COMPATIBLE

	const_def
	const BREEDGEN_MALE
	const BREEDGEN_FEMALE
	const BREEDGEN_GENDERLESS
	const BREEDGEN_DITTO

CheckBreedmonCompatibility:
	call .CheckBreedingGroupCompatibility
	ld c, INCOMPATIBLE
	jp nc, .done
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	ld a, [wBreedMon1Gender]
	ld [wTempMonGender], a
	call .SetGenderData
	ld b, a
	ld a, [wBreedMon2Species]
	ld [wCurPartySpecies], a
	ld a, [wBreedMon2Gender]
	ld [wTempMonGender], a
	call .SetGenderData
	cp b
	ld c, INCOMPATIBLE
	jr z, .done ; both are same gender, both are dittos or both are genderless
	; Check for Ditto
	or b
	bit BREEDGEN_DITTO, a
	jr nz, .breed_ok
	; Check for genderless
	bit BREEDGEN_GENDERLESS, a
	jr nz, .done ; Any mon being genderless is incompatible with non-Ditto

.breed_ok
	ld a, [wBreedMon2Species]
	ld b, a
	ld a, [wBreedMon1Species]
	cp b
	ld c, HIGHLY_COMPATIBLE
	jr z, .compare_ids
	ld c, MODERATELY_COMPATIBLE
.compare_ids
	; Speed up
	ld a, [wBreedMon1ID]
	ld b, a
	ld a, [wBreedMon2ID]
	cp b
	jr nz, .done
	ld a, [wBreedMon1ID + 1]
	ld b, a
	ld a, [wBreedMon2ID + 1]
	cp b
	jr nz, .done
	dec c ; SLIGHTLY_COMPATIBLE

.done
	ld a, c
	ld [wd265], a
	ret

.CheckBreedingGroupCompatibility:
; If either mon is in the No Eggs group,
; they are not compatible.
	ld a, [wBreedMon2Species]
	ld [wCurSpecies], a
	ld a, [wBreedMon2Form]
	and BASEMON_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseEggGroups]
	cp NO_EGGS * $11
	jr z, .Incompatible

	ld a, [wBreedMon1Species]
	ld [wCurSpecies], a
	ld a, [wBreedMon1Form]
	and BASEMON_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseEggGroups]
	cp NO_EGGS * $11
	jr z, .Incompatible

; Ditto is automatically compatible with everything.
; If not Ditto, load the breeding groups into b/c and d/e.
	ld a, [wBreedMon2Species]
	cp DITTO
	jr z, .Compatible
	ld [wCurSpecies], a
	ld a, [wBreedMon2Form]
	and BASEMON_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseEggGroups]
	push af
	and $f
	ld b, a
	pop af
	and $f0
	swap a
	ld c, a

	ld a, [wBreedMon1Species]
	cp DITTO
	jr z, .Compatible
	ld [wCurSpecies], a
	ld a, [wBreedMon1Form]
	and BASEMON_MASK
	ld [wCurForm], a
	push bc
	call GetBaseData
	pop bc
	ld a, [wBaseEggGroups]
	push af
	and $f
	ld d, a
	pop af
	and $f0
	swap a
	ld e, a

	ld a, d
	cp b
	jr z, .Compatible
	cp c
	jr z, .Compatible

	ld a, e
	cp b
	jr z, .Compatible
	cp c
	jr z, .Compatible

.Incompatible:
	and a
	ret

.Compatible:
	scf
	ret

.SetGenderData:
	ld a, [wCurPartySpecies]
	cp DITTO
	ld a, 1 << BREEDGEN_DITTO
	ret z
	ld a, TEMPMON
	ld [wMonType], a
	push bc
	farcall GetGender
	pop bc
	ld a, 1 << BREEDGEN_GENDERLESS
	ret c
	ld a, 1 << BREEDGEN_FEMALE
	ret z
	srl a ; 1 << BREEDGEN_MALE
	ret

DoEggStep::
	; Check if Flame Body/Magma Armor applies
	ld de, wPartySpecies
	ld hl, wPartyMon1Ability
.ability_loop
	ld a, [de]
	inc de
	inc a
	jr z, .no_ability_bonus
	push hl
	push de
	ld de, wPartyMon1IsEgg - wPartyMon1Ability
	add hl, de
	bit MON_IS_EGG_F, [hl]
	pop de
	pop hl
	jr nz, .ability_next
	ld c, a
	push de
	push hl
	call GetAbility
	pop hl
	pop de
	ld a, b
	ld c, 1
	cp FLAME_BODY
	jr z, .ability_ok
	cp MAGMA_ARMOR
	jr z, .ability_ok
.ability_next
	call .nextpartymon
	jr .ability_loop
.no_ability_bonus
	ld c, 0
.ability_ok
	ld de, wPartySpecies
	ld hl, wPartyMon1Happiness ; Egg cycles when not hatched
.loop
	ld a, [de]
	inc de
	inc a
	jr z, .done
	push hl
	push de
	ld de, wPartyMon1IsEgg - wPartyMon1Happiness
	add hl, de
	bit MON_IS_EGG_F, [hl]
	pop de
	pop hl
	jr z, .next
	dec [hl]
	jr z, .hatch
	ld a, c
	and a
	jr z, .next
	dec [hl]
	jr nz, .next
.hatch
	ld a, 1
	and a
.done
	ld c, 0 ; TODO: check if this is needed (was done earlier)
	ret

.next
	call .nextpartymon
	jr .loop
.nextpartymon
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	ret

OverworldHatchEgg::
	call RefreshScreen
	call LoadStandardMenuHeader
	call HatchEggs
	call ExitAllMenus
	call RestartMapMusic
	jp CloseText

HatchEggs:
	ld de, wPartySpecies
	ld hl, wPartyMon1Happiness
	xor a
	ld [wCurPartyMon], a

.loop
	ld a, [de]
	inc de
	inc a
	ret z

	push de
	push hl
	push de
	ld de, wPartyMon1IsEgg - wPartyMon1Happiness
	add hl, de
	bit MON_IS_EGG_F, [hl]
	pop de
	pop hl
	push hl
	jp z, .next
	ld a, [hl]
	and a
	jp nz, .next
	ld [hl], $78

	push de

	farcall SetEggMonCaughtData
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	ld [wCurPartySpecies], a
	dec a
	call SetSeenAndCaughtMon

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1IsEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and $ff - IS_EGG_MASK
	ld [hl], a

	ld a, [wCurPartySpecies]
	cp TOGEPI
	jr nz, .nottogepi
	eventflagset EVENT_TOGEPI_HATCHED
.nottogepi

	pop de

	ld a, [wCurPartySpecies]
	dec de
	ld [de], a
	ld [wd265], a
	ld [wCurSpecies], a
	call GetPokemonName

	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and BASEMON_MASK
	ld [wCurForm], a

	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	pop hl
	push hl
	ld bc, MON_STATUS
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	pop hl
	push hl
	ld bc, MON_EVS - 1
	add hl, bc
	ld b, FALSE
	predef CalcPkmnStats
	pop bc
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_HP
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ld hl, MON_ID
	add hl, bc
	ld a, [wPlayerID]
	ld [hli], a
	ld a, [wPlayerID + 1]
	ld [hl], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wPlayerName
	rst CopyBytes
	ld hl, .Text_HatchEgg
	call PrintText
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	push de

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .alwaysnickname
	ld hl, .Text_NicknameHatchling
	call PrintText
	call YesNoBox
	pop de
	jr c, .nonickname
	jr .yesnickname

.alwaysnickname
	pop de
.yesnickname
	xor a
	ld [wMonType], a
	push de
	predef CopyPkmnToTempMon
	pop de
	push de
	ld b, $0 ; pokemon
	farcall NamingScreen
	pop hl
	ld de, wStringBuffer1
	call InitName
	jr .next

.nonickname
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

.next
	ld hl, wCurPartyMon
	inc [hl]
	pop hl
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	jp .loop

.Text_HatchEgg:
	; Huh? @ @
	text_jump Text_BreedHuh
	start_asm
	ld hl, wVramState
	res 0, [hl]
	push hl
	push de
	push bc
	ld a, [wCurPartySpecies]
	push af
	call EggHatch_AnimationSequence
	ld hl, .ClearTextbox
	call PrintText
	pop af
	ld [wCurPartySpecies], a
	pop bc
	pop de
	pop hl
	ld hl, .CameOutOfItsEgg
	ret

.ClearTextbox:
	;
	text_jump ClearText
	text_end

.CameOutOfItsEgg:
	; came out of its EGG!@ @
	text_jump _BreedEggHatchText
	text_end

.Text_NicknameHatchling:
	; Give a nickname to @ ?
	text_jump _BreedAskNicknameText
	text_end

GetMotherAddr:
	ld a, [wBreedMotherOrNonDitto]
	and a
	ret z
	jr SwitchParentAddr

GetFatherAddr:
	ld a, [wBreedMotherOrNonDitto]
	and a
	ret nz
SwitchParentAddr:
	push bc
	ld bc, wBreedMon2 - wBreedMon1
	add hl, bc
	pop bc
	ret

InitEggMoves:
; Order of move inheritance in VII:
; * Default moves at level 1
; * Inherited level up moves (both parents must know it)
; * Egg moves from father
; * Egg moves from mother
; Further inheritances shift previous moves out, meaning that the list is in a
; reversed inheritance priority

	; Default level 1 moves
	ld de, wEggMonMoves
	xor a
	ld [wBuffer1], a
	; c = species
	ld a, [wEggMonSpecies]
	ld c, a
	; b = form
	ld a, [wEggMonForm]
	and BASEMON_MASK
	ld b, a
	predef FillMoves

	; Inherited level up moves
	ld de, wBreedMon1Moves
	ld b, NUM_MOVES
.level_up_loop
	ld a, [de]
	inc de
	and a
	jr z, .level_up_done
	ld c, a
	ld hl, wBreedMon2Moves
	push de
	ld d, NUM_MOVES
.level_up_loop_inner
	ld a, [hli]
	cp c
	jr z, .got_level_up_move
	and a
	jr z, .level_up_done_inner
	dec d
	jr nz, .level_up_loop_inner
.level_up_done_inner
	pop de
	dec b
	jr nz, .level_up_loop
	jr .level_up_done

.got_level_up_move
	ld d, c
	push hl
	push bc
	call InheritLevelMove
	pop bc
	pop hl
	jr .level_up_done_inner

.level_up_done
	; Egg moves from father
	ld hl, wBreedMon1Moves
	call GetFatherAddr
	call .GetEggMoves

	; Egg moves from mother
	ld hl, wBreedMon1Moves
	call GetMotherAddr
	call .GetEggMoves

	; Done, fill PP
	ld hl, wEggMonMoves
	ld de, wEggMonPP
	predef_jump FillPP

.GetEggMoves:
	ld b, NUM_MOVES
.egg_move_loop
	ld a, [hli]
	and a
	ret z
	ld d, a
	push hl
	push bc
	call InheritEggMove
	pop bc
	pop hl
	dec b
	jr nz, .egg_move_loop
	ret

InheritLevelMove:
; If move d is part of the level up moveset, inherit that move
	; c = species
	ld a, [wEggMonSpecies]
	ld c, a
	; b = form
	ld a, [wEggMonForm]
	and BASEMON_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
.loop
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	and a
	jr nz, .loop
.loop2
	ld a, BANK(EvosAttacks)
	call GetFarByte
	and a
	ret z
	inc hl
	ld a, BANK(EvosAttacks)
	call GetFarByte
	cp d
	jr z, InheritMove
	inc hl
	jr .loop2

InheritEggMove:
; If move d is an egg move, inherit that move
	; c = species
	ld a, [wEggMonSpecies]
	ld c, a
	; b = form
	ld a, [wEggMonForm]
	and BASEMON_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EggMovePointers
	add hl, bc
	add hl, bc
	ld a, BANK(EggMovePointers)
	call GetFarHalfword
.loop
	ld a, BANK(EggMoves)
	call GetFarByte
	inc a
	ret z
	dec a
	cp d
	jr z, InheritMove
	inc hl
	jr .loop

InheritMove:
	ld hl, wEggMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .got_move_byte
	cp d
	ret z
	dec b
	jr nz, .loop

	; shift moves
	push de
	ld bc, 3
	ld hl, wEggMonMoves + 1
	ld de, wEggMonMoves
	rst CopyBytes
	pop de
.got_move_byte
	dec hl
	ld [hl], d
	ret

GetEggFrontpic:
	push de
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	predef GetVariant
	ld a, EGG
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef_jump GetFrontpic

GetHatchlingFrontpic:
	push de
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	predef GetVariant
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef_jump FrontpicPredef

Hatch_UpdateFrontpicBGMapCenter:
	push af
	call WaitTop
	push hl
	push bc
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	pop bc
	pop hl
	ld a, b
	ldh [hBGMapAddress + 1], a
	ld a, c
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	pop af
	call Hatch_LoadFrontpicPal
	call SetPalettes
	jp ApplyAttrAndTilemapInVBlank

EggHatch_DoAnimFrame:
	push hl
	push de
	push bc
	farcall PlaySpriteAnimations
	call DelayFrame
	jp PopBCDEHL

EggHatch_AnimationSequence:
	ld a, [wd265]
	ld [wJumptableIndex], a
	ld a, [wCurSpecies]
	push af
	ld de, MUSIC_NONE
	call PlayMusic
	farcall BlankScreen
	call DisableLCD
	ld a, " "
	ld bc, vBGMap1 - vBGMap0
	hlbgcoord 0, 0
	rst ByteFill
	ld hl, EggHatchGFX
	ld de, vTiles0 tile $00
	ld bc, $20
	ld a, BANK(EggHatchGFX)
	call FarCopyBytes
	call ClearSpriteAnims
	ld de, vTiles2 tile $00
	ld a, [wJumptableIndex]
	call GetHatchlingFrontpic
	ld de, vTiles2 tile $31
	call GetEggFrontpic
	ld de, MUSIC_EVOLUTION
	call PlayMusic
	call EnableLCD
	hlcoord 7, 4
	lb bc, HIGH(vBGMap0), $31 ; Egg tiles start at c
	ld a, EGG
	call Hatch_UpdateFrontpicBGMapCenter
	ld c, 80
	call DelayFrames
	xor a
	ld [wFrameCounter], a
	ldh a, [hSCX]
	ld b, a
.outerloop
	ld hl, wFrameCounter
	ld a, [hl]
	inc [hl]
	cp 8
	jr nc, .done
	ld e, [hl]
.loop
; wobble e times
	ld a, 2
	ldh [hSCX], a
	ld a, -2
	ld [wGlobalAnimXOffset], a
	call EggHatch_DoAnimFrame
	ld c, 2
	call DelayFrames
	ld a, -2
	ldh [hSCX], a
	ld a, 2
	ld [wGlobalAnimXOffset], a
	call EggHatch_DoAnimFrame
	ld c, 2
	call DelayFrames
	dec e
	jr nz, .loop
	ld c, 16
	call DelayFrames
	call EggHatch_CrackShell
	jr .outerloop

.done
	ld de, SFX_EGG_HATCH
	call PlaySFX
	xor a
	ldh [hSCX], a
	ld [wGlobalAnimXOffset], a
	call ClearSprites
	call Hatch_InitShellFragments
	hlcoord 6, 3
	lb bc, HIGH(vBGMap0), $00 ; Hatchling tiles start at c
	ld a, [wJumptableIndex]
	call Hatch_UpdateFrontpicBGMapCenter
	call Hatch_ShellFragmentLoop
	call WaitSFX
	ld a, [wJumptableIndex]
	ld [wCurPartySpecies], a
	hlcoord 6, 3
	lb de, $0, ANIM_MON_HATCH
	predef AnimateFrontpic
	pop af
	ld [wCurSpecies], a
	ret

Hatch_LoadFrontpicPal:
	ld [wPlayerHPPal], a
	ld c, FALSE
	ld a, CGB_EVOLUTION
	jp GetCGBLayout

EggHatch_CrackShell:
	ld a, [wFrameCounter]
	dec a
	and $7
	cp $7
	ret z
	srl a
	ret nc
	swap a
	srl a
	add 9 * 8 + 4
	ld d, a
	ld e, 11 * 8
	ld a, SPRITE_ANIM_INDEX_EGG_CRACK
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0
	ld de, SFX_EGG_CRACK
	jp PlaySFX

EggHatchGFX:
INCBIN "gfx/evo/egg_hatch.2bpp"

Hatch_InitShellFragments:
	call ClearSpriteAnims
	ld hl, .SpriteData
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	push hl
	push bc

	ld a, SPRITE_ANIM_INDEX_EGG_HATCH
	call _InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0

	pop de
	ld a, e
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	add [hl]
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], d

	pop hl
	jr .loop
.done
	ld de, SFX_EGG_HATCH
	call PlaySFX
	jp EggHatch_DoAnimFrame

.SpriteData:
; Probably OAM.
	dsprite 10, 4,  9, 0, $00, $4 | X_FLIP
	dsprite 11, 4,  9, 0, $01, $4
	dsprite 10, 4, 10, 0, $00, $0 | X_FLIP
	dsprite 11, 4, 10, 0, $01, $0
	dsprite 10, 4, 11, 0, $02, $4 | X_FLIP
	dsprite 11, 4, 11, 0, $03, $4
	dsprite 10, 0,  9, 4, $00, $6 | X_FLIP
	dsprite 12, 0,  9, 4, $01, $2
	dsprite 10, 0, 10, 4, $02, $2 | X_FLIP
	dsprite 12, 0, 10, 4, $03, $6
	db -1

Hatch_ShellFragmentLoop:
	ld c, 129
.loop
	call EggHatch_DoAnimFrame
	dec c
	jr nz, .loop
	ret

Special_DayCareMon1:
	ld hl, DayCareMon1Text
	call PrintText
	ld a, [wBreedMon1Species]
	call PlayCry
	ld a, [wDayCareLady]
	bit 0, a
	jr z, DayCareMonCursor
	call ButtonSound
	ld hl, wBreedMon2Nick
	call DayCareMonCompatibilityText
	jp PrintText

Special_DayCareMon2:
	ld hl, DayCareMon2Text
	call PrintText
	ld a, [wBreedMon2Species]
	call PlayCry
	ld a, [wDayCareMan]
	bit 0, a
	jr z, DayCareMonCursor
	call ButtonSound
	ld hl, wBreedMon1Nick
	call DayCareMonCompatibilityText
	jp PrintText

DayCareMonCursor:
	jp WaitPressAorB_BlinkCursor

DayCareMon2Text:
	; It's @ that was left with the DAY-CARE LADY.
	text_jump _LeftWithDayCareLadyText
	text_end

DayCareMon1Text:
	; It's @ that was left with the DAY-CARE MAN.
	text_jump _LeftWithDayCareManText
	text_end

DayCareMonCompatibilityText:
	push bc
	ld de, wStringBuffer1
	ld bc, NAME_LENGTH
	rst CopyBytes
	call CheckBreedmonCompatibility
	pop bc
	ld a, [wd265]

	ld hl, .Incompatible
	and a
	ret z

	ld hl, .SlightCompatibility
	dec a
	ret z

	ld hl, .ModerateCompatibility
	dec a
	ret z

	ld hl, .HighCompatibility
	ret

.Incompatible:
	; It has no interest in @ .
	text_jump _BreedNoInterestText
	text_end

.HighCompatibility:
	; It appears to care for @ .
	text_jump _BreedAppearsToCareForText
	text_end

.ModerateCompatibility:
	; It's friendly with @ .
	text_jump _BreedFriendlyText
	text_end

.SlightCompatibility:
	; It shows interest in @ .
	text_jump _BreedShowsInterestText
	text_end
