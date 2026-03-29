DrawBattleHPBar::
; Draw an HP bar d tiles long at hl
; Fill it up to e pixels

	push hl
	push de
	push bc

; Place 'HP:'
	ld a, '<HP1>'
	ld [hli], a
	inc a ; ld a, "<HP2>"
	ld [hli], a

; Draw a template
	push hl
	inc a ; ld a, '<NOHP>' ; empty bar
.template
	ld [hli], a
	dec d
	jr nz, .template
	ld [hl], '<HPEND>' ; bar end cap
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
	ld a, '<FULLHP>'
	ld [hli], a
	ld a, e
	and a
	jr z, .done
	jr .fill

.lastbar
	ld a, '<NOHP>'
	add e
	ld [hl], a

.done
	jmp PopBCDEHL

GetPaddedFrontpicAddress::
; 5x5 or 6x6 pics padded to 7x7 tiles are stored at the tail end of wDecompressScratch.
; 7x7 pics may have enough animation tiles that there are not 7x7 free tiles at the end;
; but since the beginning is already 7x7 it can reuse that space.
	ld a, [wMonPicSize]
	cp 7
	ld de, wDecompressScratch
	ret z
	ld de, wDecompressScratch + $100 tiles - (7 * 7) tiles
	ret

PlaceFrontpicAtHL:
	xor a
_PlaceFrontpicAtHL:
	ld de, SCREEN_WIDTH
	ld b, 7
.row
	ld c, 7
	push af
	push hl
.col
	ld [hli], a
	add 7
	dec c
	jr nz, .col
	pop hl
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row
	ret

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
	ld a, '<LV>'
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
	; fallthrough

PrintNum::
	homecall _PrintNum
	ret

GetBaseDataFromIndexBC::
	push hl
	push de
	push bc
	jr _GetBaseData

GetBaseData::
	push hl
	push de
	push bc
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetSpeciesAndFormIndex
_GetBaseData::
	ld a, BASE_DATA_SIZE
	ld hl, BaseData
	rst AddNTimes
	ld de, wCurBaseData
	ld bc, BASE_DATA_SIZE
	ld a, BANK(BaseData)
	call FarCopyBytes
	jmp PopBCDEHL

GetPicSize::
	push hl
	push de
	push bc
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetCosmeticSpeciesAndFormIndex
	srl b
	rr c
	push af
	ld hl, PokemonPicSizes
	add hl, bc
	ld a, BANK(PokemonPicSizes)
	call GetFarByte
	ld b, a
	pop af
	jr c, .skip_swap
	swap b ; use high nybble if index is even
.skip_swap
	ld a, b
	and $f
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
	jmp PopBCDEHL

GetAbility::
; 'hl' contains the target personality to check (ability and form)
; 'c' contains the target species
; returns ability in a and b
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

DexCompareWildForm:
; Compares wildmon form in a (converting form 0->1) with b.
; If b is cosmetic form, only check for matching extspecies.
; Otherwise, check exact form. Returns z if matching. Always returns nc.
	; Translate form 0->1
	push bc
	ld c, a
	and FORM_MASK
	jr nz, .got_form
	inc c
.got_form
	ld a, c
	pop bc

	; If xor b returns z, form is identical.
	xor b
	ret z

	; a at this point has MON_COSMETIC_F if form is cosmetic.
	; Thus, doubling it will leave mismatching extspecies/form data
	; on noncarry, returning nz.

	assert MON_COSMETIC_F == 7

	add a
	ret nc

	; At this point, we know we're dealing with a cosmetic form.
	; Verify that extspecies matched (the above becomes a=0 if matched)..
	and EXTSPECIES_MASK << 1
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

GetDexEntryPointer::
; input: c = species, b = extspecies+form
; output: a = bank, hl = address
; clobbers d
	ld hl, PokedexDataPointerTable
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(PokedexDataPointerTable)
	call GetFarByte
	ld d, a
	inc hl
	ld a, BANK(PokedexDataPointerTable)
	call GetFarWord
	ld a, d
	ret

GetPokedexNumber::
; input: c = species, b = extspecies+form
; output bc = de = pokedex number ((256*extspecies + c) - (2*extspecies))
; this reflects how c = $00 and c = $ff don't have a pokédex number.
	ld a, [wPokedexMode]
	and a
	jr nz, GetNationalDexNumber

	ld a, BANK(NewPokedexOrder)
	call StackCallInBankA
.Function:
	push hl
	ld hl, NewPokedexOrder
.loop
	ld a, [hli]
	cp c
	ld a, [hli]
	jr nz, .loop
	xor b
	and EXTSPECIES_MASK
	jr nz, .loop
	srl h
	rr l
	ld bc, -(NewPokedexOrder / 2)
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret

GetNationalDexNumber:
; input: c = species, b = extspecies+form
; output: bc = natdex number ((256*extspecies + c) - (2*extspecies))
	ld a, b
	call ConvertFormToExtendedSpecies
	ld b, a
	add a
	push de
	ld d, a
	ld a, c
	sub d
	pop de
	ld c, a
	ret nc
	dec b
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

CompareSpeciesWithDE:
; Compares given species+form in bc with target in de. Returns z if matching.
; Uses similar logic as GetSpeciesAndFormIndexFromHL for what constitutes
; a match. Namely, if d doesn't explicitly specify a form, any form will do.
; Cosmetic forms are treated as separate (assuming d specifies a form).
	ld a, e
	cp c
	ret nz
	ld a, d
	; fallthrough
CompareSpeciesForm:
; Compare form bytes a with b. Zero form bits in a is considered a wildcard.
; Unless a has gender bit set, gender is ignored. Extspecies mismatch always
; results in a comparision failure. Returns z if the form byte matches.
	push bc
	ld c, a
	assert (MON_GENDER_F == 7)
	add a
	ld a, c
	jr c, .skip_gender_reset
	res MON_GENDER_F, b
.skip_gender_reset
	; Effectively does a comparision between a and b.
	xor b
	jr z, .done ; This is a match.

	; If FORM_MASK+1 is noncarry, either gender is wrong (if included),
	; or species bits are wrong.
	assert (EXTSPECIES_MASK > FORM_MASK) && (GENDER_MASK > FORM_MASK)
	cp (FORM_MASK + 1)
	jr nc, .done ; Not a match.

	; At this point, we know that form bits are a mismatch.
	; Check for form bits in a being zero.
	xor b ; Undo previous xor.
	and FORM_MASK
.done
	and a ; This results in z on a match, nz otherwise.
	ld a, c
	pop bc
	ret

GetCosmeticSpeciesAndFormIndex::
; input: c = species, b = form
; output: bc = extended index, carry if anything found
	ld hl, CosmeticSpeciesAndFormTable
	jr GetSpeciesAndFormIndexFromHL

GetSpeciesAndFormIndex::
; input: c = species, b = form
; output: bc = extended index, carry if anything found
	ld hl, VariantSpeciesAndFormTable
GetSpeciesAndFormIndexFromHL::
; input: c = species, b = form, hl = cosmetic/variant table
; output: bc = extended index, carry if anything found
; For custom hl, note that returned index is offset by species amount.
	push de
	ld a, h
	cpl
	ld d, a
	ld a, l
	cpl
	ld e, a
	call .helper
	jr nc, .final
	ccf
	pop de
	ret

.final:
	add hl, de
	srl h
	rr l
	ld de, NUM_SPECIES
	add hl, de
	ld b, h
	ld c, l
	scf
	pop de
	ret

.helper:
	inc c
	jr z, .egg
	dec c
	ld a, b
	and SPECIESFORM_MASK
	ld b, a
.loop
	ld a, [hli]
	and a
	jr z, .normal
	cp c
	ld a, [hli]
	jr nz, .loop

	call CompareSpeciesForm
	jr nz, .loop
	ret

.egg
	ld b, 0
	dec c
.normal
	; Converts species 1-254 to 0-253, extspecies to 256-509 (egg is 255)
	ld a, b
	call ConvertFormToExtendedSpecies
	ld b, a
	dec c
	scf
	ret
