; PutNameInBufferAndGetName types
	const_def 0, 3
	const TRAINER_CLASS_NAME ; 0
	const ITEM_NAME          ; 1
	const KEY_ITEM_NAME      ; 2
	const SPECIAL_ITEM_NAME  ; 3
	const BADGE_NAME         ; 4
	const APRICORN_NAME      ; 5
	const WING_NAME          ; 6
	const EXP_CANDY_NAME     ; 7
DEF NUM_NAME_TYPES EQU const_value / 3

GetNthString16::
; Like GetNthString, but with a 16-bit index in bc
	inc b
	jr .handle_loop
.loop
	xor a
	call GetNthString.loop ; will act as a = $100
.handle_loop
	dec b
	jr nz, .loop
	ld a, c
	; fallthrough
GetNthString::
; Return the address of the
; ath string starting from hl.
	and a
	ret z

.loop
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
	; fallthrough

GetPokemonName::
; Get Pokemon name wNamedObjectIndex.
	push hl
	ld hl, wNamedObjectIndex
	ld a, [hli]
	ld e, a
	ld a, [hl]
	call ConvertFormToExtendedSpecies
	ld d, a
	ld h, d
	ld l, e
	assert MON_NAME_LENGTH - 1 == 10
	add hl, hl ; hl = hl * 2
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + hl
	add hl, hl ; hl = (5*hl) + (5*hl)
	ld de, PokemonNames
	add hl, de
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

GetTrainerClassName::
	ld a, [wNamedObjectIndex]
	dec a
	ld [wCurSpecies], a
	ld a, TRAINER_CLASS_NAME
	jr PutNameInBufferAndGetName

GetCurItemName::
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	; fallthrough
GetItemName::
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, ITEM_NAME
	jr PutNameInBufferAndGetName

GetCurKeyItemName::
	ld a, [wCurKeyItem]
	ld [wNamedObjectIndex], a
	; fallthrough
GetKeyItemName::
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, KEY_ITEM_NAME
	jr PutNameInBufferAndGetName

GetBadgeName::
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, BADGE_NAME
	jr PutNameInBufferAndGetName

GetApricornName::
	ld a, [wNamedObjectIndex]
	dec a
	ld [wCurSpecies], a
	ld a, APRICORN_NAME
	jr PutNameInBufferAndGetName

GetExpCandyName::
	ld a, [wNamedObjectIndex]
	dec a
	ld [wCurSpecies], a
	ld a, EXP_CANDY_NAME
	jr PutNameInBufferAndGetName

GetSpecialItemName::
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, SPECIAL_ITEM_NAME
	jr PutNameInBufferAndGetName

GetWingName::
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld a, WING_NAME
	; fallthrough

PutNameInBufferAndGetName:
	push hl
	ld de, wStringBuffer1
	push de
	push bc
	add LOW(.NamesPointers)
	ld l, a
	adc HIGH(.NamesPointers)
	sub l
	ld h, a
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	rst Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurSpecies]
	call GetNthString
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	pop af
	rst Bankswitch
	jmp PopBCDEHL

.NamesPointers:
; entries correspond to *_NAME constants
	table_width 3
	dba TrainerClassNames
	dba ItemNames
	dba KeyItemNames
	dba SpecialItemNames
	dba BadgeNames
	dba ApricornNames
	dba WingNames
	dba ExpCandyNames
	assert_table_length NUM_NAME_TYPES

GetCurTMHMName::
	ld a, [wCurTMHM]
	ld [wNamedObjectIndex], a
	; fallthrough
GetTMHMName::
	homecall _GetTMHMName
	ret

GetMoveName::
	push hl
	push bc
	ldh a, [hROMBank]
	push af
	ld a, BANK(MoveNames)
	rst Bankswitch
	ld a, [wNamedObjectIndex]
	call GetMoveIndexFromID
	dec hl
	ld b, h
	ld c, l
	ld hl, MoveNames
	call GetNthString16
	ld de, wStringBuffer1
	push de
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes
	pop de
	pop af
	rst Bankswitch
	pop bc
	pop hl
	ret
