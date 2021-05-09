DrawBattleHPBar::
; Draw an HP bar d tiles long at hl
; Fill it up to e pixels

	push hl
	push de
	push bc

; Place 'HP:'
	ld a, "<HP1>"
	ld [hli], a
	inc a ; ld a, "<HP2>"
	ld [hli], a

; Draw a template
	push hl
	inc a ; ld a, "<NOHP>" ; empty bar
.template
	ld [hli], a
	dec d
	jr nz, .template
	ld [hl], "<HPEND>" ; bar end cap
	pop hl

; Safety check # pixels
	ld a, e
	and a
	jr nz, .fill
	ld a, c
	and a
	jr z, .done
	ld e, 1

.fill
; Keep drawing tiles until pixel length is reached
	ld a, e
	sub TILE_WIDTH
	jr c, .lastbar

	ld e, a
	ld a, "<FULLHP>"
	ld [hli], a
	ld a, e
	and a
	jr z, .done
	jr .fill

.lastbar
	ld a, "<NOHP>"
	add e
	ld [hl], a

.done
	jmp PopBCDEHL

PrepMonFrontpicFlipped::
	xor a
	jr _PrepMonFrontpic

PrepMonFrontpic::
	ld a, $1

_PrepMonFrontpic:
	ld [wBoxAlignment], a
	ld a, [wCurPartySpecies]
	and a
	jr z, .not_pokemon

	push hl
	ld de, vTiles2
	predef GetFrontpic
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ld [wBoxAlignment], a
	ret

.not_pokemon
	xor a
	ld [wBoxAlignment], a
	inc a
	ld [wCurPartySpecies], a
	ret

PrintLevel::
; Print wTempMonLevel at hl
	ld a, "<LV>"
	ld [hli], a
; How many digits?
	ld c, 2
	ld a, [wTempMonLevel]
	cp 100
	jr c, Print8BitNumRightAlign
; 3-digit numbers overwrite the :L.
	dec hl
	inc c
	; fallthrough

Print8BitNumRightAlign::
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	ld b, PRINTNUM_LEFTALIGN | 1
	jmp PrintNum

GetBaseData::
	push hl
	push de
	push bc
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetSpeciesAndFormIndex
	ld a, BASE_DATA_SIZE
	ld hl, BaseData
	rst AddNTimes
	ld de, wCurBaseData
	ld bc, BASE_DATA_SIZE
	ld a, BANK(BaseData)
	call FarCopyBytes
	jmp PopBCDEHL

GetNature::
; 'b' contains the target Nature to check
; returns nature in b
	ld a, [wInitialOptions]
	bit NATURES_OPT, a
	jr z, .no_nature
	ld a, b
	and NATURE_MASK
	; assume nature is 0-24
	ld b, a
	ret

.no_nature:
	ld b, NO_NATURE
	ret

GetLeadAbility::
; Returns ability of lead mon unless it's an Egg. Used for field
; abilities
	ld a, [wPartyMon1IsEgg]
	and IS_EGG_MASK
	xor IS_EGG_MASK
	ret z
	ld a, [wPartyMon1Species]
	inc a
	ret z
	dec a
	ret z
	push hl
	push de
	push bc
	ld c, a
	ld hl, wPartyMon1Personality
	call GetAbility
	ld a, b
	jmp PopBCDEHL

GetAbility::
; 'hl' contains the target personality to check (ability and form)
; 'c' contains the target species
; returns ability in b
; preserves curspecies and base data
	anonbankpush BaseData

.Function:
	ld a, [wInitialOptions]
	and ABILITIES_OPTMASK
	jr z, .got_ability

	inc hl
	ld a, [hld]
	and SPECIESFORM_MASK
	ld b, a

	push hl
	push bc

	push hl
	call GetSpeciesAndFormIndex
	ld a, BASE_DATA_SIZE
	ld hl, BaseData + BASE_ABILITIES
	rst AddNTimes
	pop bc

	ld a, [bc]
	and ABILITY_MASK
	cp ABILITY_1
	jr z, .got_ability_ptr
	inc hl
	cp ABILITY_2
	jr z, .got_ability_ptr
	inc hl
.got_ability_ptr
	ld a, [hl]

	pop bc
	pop hl

.got_ability
	ld b, a
	ret

GetGenderRatio::
; 'b' contains the target form
; 'c' contains the target species
; returns gender ratio in c
; preserves curspecies and base data
	anonbankpush BaseData

.Function:
	push hl
	push bc
	call GetSpeciesAndFormIndex
	ld a, BASE_DATA_SIZE
	ld hl, BaseData + BASE_GENDER
	rst AddNTimes
	pop bc
	ld a, [hl]
	pop hl
	swap a
	and $f
	ld c, a
	ret

GetCurNickname::
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
GetNickname::
; Get nickname a from list hl.
	ld de, wStringBuffer1
	push hl
	push de
	push bc
	call SkipNames
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	jmp PopBCDEHL

GetPokedexNumber::
; input: c = species, b = extspecies+form
; output bc = de = pokedex number ((256*extspecies + c) - (2*extspecies))
; this reflects how c = $00 and c = $ff don't have a pokédex number.
; assumes number of pokemon < $1000
	ld a, b
	call ConvertFormToExtendedSpecies
	ld b, a
	add a
	cpl
	inc a
	add c
	ld c, a
	jr c, .no_carry
	dec b
.no_carry
	ld d, b
	ld e, c
	ret

ConvertFormToExtendedSpecies::
; input: a = form
; output: a = extended index >> MON_EXTSPECIES_F
; WARNING: this discards form data and only keeps extspecies
	and EXTSPECIES_MASK
	assert (EXTSPECIES_MASK > %00011111) && (EXTSPECIES_MASK & %00100000)
	swap a
	rra
	ret

GetCosmeticSpeciesAndFormIndex::
; input: c = species, b = form
; output: bc = extended index, carry if nothing found
	ld hl, CosmeticSpeciesAndFormTable
	jr GetSpeciesAndFormIndexFromHL

GetSpeciesAndFormIndex::
; input: c = species, b = form
; output: bc = extended index, carry if nothing found
	ld hl, VariantSpeciesAndFormTable
GetSpeciesAndFormIndexFromHL::
; input: c = species, b = form, hl = cosmetic/variant table
; output: bc = extended index, carry if nothing found
; For custom hl, note that returned index is offset by species amount.
	push de
	ld a, h
	cpl
	ld d, a
	ld a, l
	cpl
	ld e, a
	dec hl
	call .helper
	jr c, .final
	pop de
	and a
	ret

.final:
	add hl, de
	srl h
	rr l
	ld de, REAL_NUM_POKEMON - 1
	add hl, de
	ld b, h
	ld c, l
	scf
	pop de
	ret

.helper:
	ld a, b
	and SPECIESFORM_MASK
	ld b, a
.next
	inc hl
.loop
	ld a, [hli]
	and a
	jr z, .normal
	cp c
	jr nz, .next

	; If form mask is 0, only verify extspecies
	ld a, SPECIESFORM_MASK
	and [hl]
	jr nz, .not_null_speciesform

	; Compare extspecies only
	ld a, b
	and EXTSPECIES_MASK
	jr z, .found_index
	jr .next

.not_null_speciesform
	cp EXTSPECIES_MASK
	jr nz, .full_comparision

	; Table index is extspecies only. If input form isn't, ignore it.
	bit MON_EXTSPECIES_F, b
	jr z, .next
.found_index
	inc hl ; makes sure we point at a proper index with final helper
	scf
	ret

.full_comparision
	ld a, [hli]
	set MON_EXTSPECIES_F, a
	cp b
	jr nz, .loop
	dec bc
	scf
	ret

.normal
	; Converts species 1-254 to 0-253, extspecies to 256-509 (egg is 255)
	bit MON_EXTSPECIES_F, b
	ld b, 0
	jr z, .done
	inc b
.done
	dec c
	and a
	ret
