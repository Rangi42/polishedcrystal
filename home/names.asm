NamesPointers::
	dba PokemonNames
	dba MoveNames
	dba ApricornNames
	dba WingNames
	dba ItemNames
	dbw 0, wPartyMonOTs
	dbw 0, wOTPartyMonOTs
	dba TrainerClassNames
	dba KeyItemNames
	dba ExpCandyNames

GetName::
; Return name wCurSpecies from name list wNamedObjectTypeBuffer in wStringBuffer1.
	ldh a, [hROMBank]
	push hl
	push de
	push bc
	push af

	ld a, [wNamedObjectTypeBuffer]
	cp MON_NAME
	jr nz, .NotPokeName

	ld hl, wNamedObjectIndex
	ld a, [wCurSpecies]
	ld [hli], a
	ld a, [wCurForm]
	ld [hl], a
	call GetPokemonName
	ld hl, MON_NAME_LENGTH
	add hl, de
	ld e, l
	ld d, h
	jr .done

.NotPokeName:
	dec a
	ld e, a
	ld d, 0
	ld hl, NamesPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	rst Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurSpecies]
	call GetNthString
	ld de, wStringBuffer1
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes

.done
	pop af
	pop bc
	pop de
	pop hl
	rst Bankswitch
	ret

GetNthString::
; Return the address of the
; ath string starting from hl.
	and a
	ret z

	push bc
	ld b, a
.readChar
	ld a, [hli]
	cp "@"
	jr nz, .readChar
	dec b
	jr nz, .readChar
	pop bc
	ret

GetBasePokemonName::
; Discards gender (Nidoran).
	push hl
	call GetPokemonName

	ld hl, wStringBuffer1
.loop
	ld a, [hl]
	cp "@"
	jr z, .quit
	cp "♂"
	jr z, .end
	cp "♀"
	jr z, .end
	inc hl
	jr .loop
.end
	ld [hl], "@"
.quit
	pop hl
	ret

GetPartyPokemonName::
; Get Pokemon name wCurPartySpecies + wCurForm
	push hl
	ld hl, wNamedObjectIndex
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld a, [wCurForm]
	ld [hl], a
	pop hl
	; fall-through
GetPokemonName::
; Get Pokemon name wNamedObjectIndex.
	push hl

; Each name is ten characters
	ld hl, wNamedObjectIndex
	ld a, [hli]
	ld e, a
	ld a, [hl]
	call ConvertFormToExtendedSpecies
	ld d, a
	ld h, d
	ld l, e
	add hl, hl ; hl = hl * 2
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + hl
	add hl, hl ; hl = (5*hl) + (5*hl)
	ld de, PokemonNames
	add hl, de

; Terminator
	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH - 1
	ld a, BANK(PokemonNames)
	call FarCopyBytes
	ld h, d
	ld l, e
	ld [hl], "@"
	pop de

	pop hl
	ret

GetCurItemName::
; Get item name from item in CurItem
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
GetItemName::
; Get item name wNamedObjectIndex.
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, ITEM_NAME
	jr PutNameInBufferAndGetName

GetCurKeyItemName::
; Get item name from item in CurItem
	ld a, [wCurKeyItem]
	ld [wNamedObjectIndex], a
GetKeyItemName::
; Get key item item name wNamedObjectIndex.
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, KEY_ITEM_NAME
	jr PutNameInBufferAndGetName

GetApricornName::
; Get apricorn name wNamedObjectIndex.
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, APRICORN_NAME
	jr PutNameInBufferAndGetName

GetExpCandyName::
	ld a, [wNamedObjectIndex]
	dec a
	ld [wCurSpecies], a
	ld a, EXP_CANDY_NAME
	jr PutNameInBufferAndGetName

GetWingName::
; Get wing name wNamedObjectIndex.
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, WING_NAME
	; fallthrough
PutNameInBufferAndGetName::
	push hl
	push bc
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

GetTMHMName::
	homecall _GetTMHMName
	ret

GetMoveName::
	push hl

	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a

	ld a, [wNamedObjectIndex] ; move id
	ld [wCurSpecies], a

	call GetName
	ld de, wStringBuffer1

	pop hl
	ret
