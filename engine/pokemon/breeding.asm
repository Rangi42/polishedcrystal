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
	jr nc, .done
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
	ld [wBreedingCompatibility], a
	ret

.CheckBreedingGroupCompatibility:
; If either mon is in the No Eggs group,
; they are not compatible.
	ld a, [wBreedMon2Species]
	ld [wCurSpecies], a
	ld a, [wBreedMon2Form]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseEggGroups]
	assert EGG_NONE * $11 == $ff
	inc a
	jr z, .Incompatible

	ld a, [wBreedMon1Species]
	ld [wCurSpecies], a
	ld a, [wBreedMon1Form]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseEggGroups]
	assert EGG_NONE * $11 == $ff
	inc a
	jr z, .Incompatible

; Ditto is automatically compatible with everything.
; If not Ditto, load the breeding groups into b/c and d/e.
	ld a, [wBreedMon2Species]
	cp DITTO
	jr z, .Compatible
	ld [wCurSpecies], a
	ld a, [wBreedMon2Form]
	and SPECIESFORM_MASK
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
	and SPECIESFORM_MASK
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
	ld a, [wPartyCount]
	and a
	ret z

	; Check if Flame Body/Magma Armor applies
	ld e, a
	ld hl, wPartyMon1IsEgg
	push hl
	push de
.loop
	bit MON_IS_EGG_F, [hl]
	jr nz, .next_ability
	push hl
	push de
	ld de, MON_SPECIES - MON_IS_EGG
	add hl, de
	ld c, [hl]
	ld de, MON_ABILITY - MON_SPECIES
	add hl, de
	call GetAbility
	pop de
	pop hl
	ld a, b
	ld c, 2
	cp FLAME_BODY
	jr z, .got_decrement
	cp MAGMA_ARMOR
	jr z, .got_decrement
.next_ability
	call .NextPartyMon
	jr nz, .loop
	ld c, 1
.got_decrement
	; Check if Oval Charm applies
	ld a, OVAL_CHARM
	ld [wCurKeyItem], a
	push bc
	call CheckKeyItem
	pop bc
	jr nc, .no_oval_charm
	sla c
.no_oval_charm
	pop de
	pop hl
	ld d, c

	; Tick down eggs by d egg cycles.
	xor a ; Hatching marker.
	push af
.egg_loop
	bit MON_IS_EGG_F, [hl]
	jr z, .next_egg
	push hl
	ld bc, MON_HAPPINESS - MON_IS_EGG
	add hl, bc
	ld a, [hl]
	sub d
	jr nc, .egg_ok
	xor a
.egg_ok
	ld [hl], a
	pop hl
	jr nz, .next_egg
	pop af
	or 1
	push af
.next_egg
	call .NextPartyMon
	jr nz, .egg_loop
	pop af
	ret

.NextPartyMon:
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	dec e
	ret

OverworldHatchEgg::
	call BackupSprites
	call ReanchorMap
	call LoadStandardMenuHeader
	call HatchEggs
	farcall ClearSavedObjPals
	farcall DisableDynPalUpdates
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call CloseText
	call RestoreSprites
	call UpdateSprites
	farcall EnableDynPalUpdatesNoApply
	call FinishExitMenu
	farcall Script_refreshmap
	jmp RestartMapMusic

HatchEggs:
	xor a
	ld [wCurPartyMon], a

	ld a, [wPartyCount]
	and a
	ret z
	ld e, a

.loop
	push de

	; Check if egg cycles is zero.
	ld a, MON_HAPPINESS
	call GetPartyParamLocationAndValue
	and a
	jmp nz, .next

	; Is this mon an egg?
	push hl
	ld bc, MON_IS_EGG - MON_HAPPINESS
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	res MON_IS_EGG_F, [hl]
	pop hl
	jmp z, .next

	; We have a valid egg. Set friendship state.
	ld [hl], HATCHED_HAPPINESS

	; Set OTID
	ld bc, MON_ID - MON_HAPPINESS
	add hl, bc
	ld a, [wPlayerID]
	ld [hli], a
	ld a, [wPlayerID + 1]
	ld [hld], a

	; Heal the mon. UpdatePkmnStats will readjust HP later if max HP changes.
	ld bc, (MON_MAXHP + 1) - MON_ID
	add hl, bc
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	dec hl
	ld [hld], a

	; Zero status and Unused
	xor a
	ld [hld], a
	ld [hl], a

	; Initialize egg caught data.
	farcall SetEggMonCaughtData

	; Write to wTempMon, wCurPartySpecies and wCurForm. Also gets base data.
	xor a
	ld [wMonType], a
	predef CopyPkmnToTempMon

	; Mark the mon as caught.
	ld a, [wTempMonSpecies]
	ld c, a
	ld a, [wTempMonForm]
	ld b, a
	push bc
	call SetSeenAndCaughtMon
	pop bc

	; If we hatched a Togepi, set the relevant Prof Elm event flag.
	ld de, TOGEPI
	call CompareSpeciesWithDE
	jr nz, .nottogepi
	eventflagset EVENT_TOGEPI_HATCHED

.nottogepi
	call GetPartyPokemonName

	; Write the species name to replace "Egg" (or "Bad Egg" I suppose...).
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	push hl
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	; Update stats.
	farcall UpdatePkmnStats

	; Write OT name.
	pop hl
	push hl
	ld bc, wPartyMonOTs - wPartyMonNicknames
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	; This prints "Huh?" and does the egg hatch animation.
	ld a, TRUE
	ld [wSpriteUpdatesEnabled], a ; needed so SafeCopyTilemapAtOnceproperly updates textbox palettes when within nickname menu
	ld hl, .Text_HatchEgg
	call PrintText

	ld hl, .Text_NicknameHatchling
	call PrintText
	call YesNoBox
	jr c, .nonickname

	; de = the relevant entry in wPartyMonNicknames.
	pop de
	push de
	ld b, $0 ; pokemon
	farcall NamingScreen
	pop hl
	ld de, wStringBuffer1
	call InitName
	jr .next

.nonickname
	pop de
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

.next
	pop de
	dec e
	ret z
	ld hl, wCurPartyMon
	inc [hl]
	jmp .loop

.Text_HatchEgg:
	; Huh? @ @
	text_far Text_BreedHuh
	text_asm
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
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
	text_far ClearText
	text_end

.CameOutOfItsEgg:
	; came out of its EGG!@ @
	text_far _BreedEggHatchText
	text_end

.Text_NicknameHatchling:
	; Give a nickname to @ ?
	text_far _BreedAskNicknameText
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
	ld de, wTempMonMoves
	xor a
	ld [wEvolutionOldSpecies], a
	; c = species
	ld a, [wTempMonSpecies]
	ld c, a
	; b = form
	ld a, [wTempMonForm]
	and SPECIESFORM_MASK
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
	ld hl, wTempMonMoves
	ld de, wTempMonPP
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
	ld a, [wTempMonSpecies]
	ld c, a
	; b = form
	ld a, [wTempMonForm]
	and SPECIESFORM_MASK
	ld b, a
	; bc = index
	predef GetEvosAttacksPointer
.loop
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	inc a
	jr nz, .loop
.loop2
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc a
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
	ld a, [wTempMonSpecies]
	ld c, a
	; b = form
	ld a, [wTempMonForm]
	and SPECIESFORM_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	ld hl, EggSpeciesMovesPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EggSpeciesMovesPointers)
	call GetFarWord
	inc hl
	inc hl
.loop
	ld a, BANK(EggSpeciesMoves)
	call GetFarByte
	inc a
	ret z
	dec a
	cp d
	jr z, InheritMove
	inc hl
	jr .loop

InheritMove:
	ld hl, wTempMonMoves
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
	ld hl, wTempMonMoves + 1
	ld de, wTempMonMoves
	rst CopyBytes
	pop de
.got_move_byte
	dec hl
	ld [hl], d
	ret

GetEggFrontpic:
	push de
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld [wCurForm], a
	ld a, EGG
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef_jump GetFrontpic

GetHatchlingFrontpic:
	push de
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld [wCurForm], a
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
	call SetDefaultBGPAndOBP
	jmp ApplyAttrAndTilemapInVBlank

EggHatch_DoAnimFrame:
	push hl
	push de
	push bc
	farcall PlaySpriteAnimations
	call DelayFrame
	jmp PopBCDEHL

EggHatch_AnimationSequence:
	ld a, [wNamedObjectIndex]
	ld [wJumptableIndex], a
	ld a, [wCurSpecies]
	push af
	ld e, MUSIC_NONE
	call PlayMusic
	farcall FadeOutPalettes
	farcall BlankScreen
	call DisableLCD
	ld a, CGB_PLAIN
	call GetCGBLayout
	ld a, " "
	ld bc, vBGMap1 - vBGMap0
	hlbgcoord 0, 0
	rst ByteFill
	ld hl, EggHatchGFX
	ld de, vTiles0 tile $00
	ld bc, 2 tiles
	ld a, BANK(EggHatchGFX)
	call FarCopyBytes
	call ClearSpriteAnims
	ld de, vTiles2 tile $00
	ld a, [wJumptableIndex]
	call GetHatchlingFrontpic
	ld de, vTiles2 tile $31
	call GetEggFrontpic
	ld e, MUSIC_EVOLUTION
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
	jmp GetCGBLayout

EggHatch_CrackShell:
	ld a, [wFrameCounter]
	dec a
	and $7 ; no-optimize a & X == X
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
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0
	ld de, SFX_EGG_CRACK
	jmp PlaySFX

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
	call InitSpriteAnimStruct

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
	jmp EggHatch_DoAnimFrame

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
	ld c, a
	ld a, [wBreedMon1Form]
	ld b, a
	call PlayMonCry
	ld a, [wDayCareLady]
	bit 0, a
	jr z, DayCareMonCursor
	call ButtonSound
	ld hl, wBreedMon2Nickname
	call DayCareMonCompatibilityText
	jmp PrintText

Special_DayCareMon2:
	ld hl, DayCareMon2Text
	call PrintText
	ld a, [wBreedMon2Species]
	ld c, a
	ld a, [wBreedMon2Form]
	ld b, a
	call PlayMonCry
	ld a, [wDayCareMan]
	bit 0, a
	jr z, DayCareMonCursor
	call ButtonSound
	ld hl, wBreedMon1Nickname
	call DayCareMonCompatibilityText
	jmp PrintText

DayCareMonCursor:
	jmp WaitPressAorB_BlinkCursor

DayCareMon2Text:
	; It's @ that was left with the DAY-CARE LADY.
	text_far _LeftWithDayCareLadyText
	text_end

DayCareMon1Text:
	; It's @ that was left with the DAY-CARE MAN.
	text_far _LeftWithDayCareManText
	text_end

DayCareMonCompatibilityText:
	push bc
	ld de, wStringBuffer1
	ld bc, NAME_LENGTH
	rst CopyBytes
	call CheckBreedmonCompatibility
	pop bc
	ld a, [wBreedingCompatibility]

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
	text_far _BreedNoInterestText
	text_end

.HighCompatibility:
	; It appears to care for @ .
	text_far _BreedAppearsToCareForText
	text_end

.ModerateCompatibility:
	; It's friendly with @ .
	text_far _BreedFriendlyText
	text_end

.SlightCompatibility:
	; It shows interest in @ .
	text_far _BreedShowsInterestText
	text_end
