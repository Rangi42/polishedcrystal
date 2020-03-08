NamesPointers:: ; 33ab
	dba PokemonNames
	dba MoveNames
	dba ApricornNames
	dba ItemNames
	dbw 0, wPartyMonOT
	dbw 0, wOTPartyMonOT
	dba TrainerClassNames
	dba KeyItemNames
; 33c0

GetName:: ; 33c3
; Return name wCurSpecies from name list wNamedObjectTypeBuffer in wStringBuffer1.
	ld a, [hROMBank]
	push af
	push hl
	push bc
	push de

	ld a, [wNamedObjectTypeBuffer]
	cp PKMN_NAME
	jr nz, .NotPokeName

	ld a, [wCurSpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, PKMN_NAME_LENGTH
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
	dec a
	call GetNthString
	ld de, wStringBuffer1
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes

.done
	pop de
	pop bc
	pop hl
	pop af
	rst Bankswitch
	ret
; 3411

GetNthString:: ; 3411
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
; 3420

GetBasePokemonName:: ; 3420
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
; 343b

GetPokemonName:: ; 343b
; Get Pokemon name wNamedObjectIndexBuffer.
	ld a, [hROMBank]
	push af
	push hl
	ld a, BANK(PokemonNames)
	rst Bankswitch

; Each name is ten characters
	ld a, [wNamedObjectIndexBuffer]
	dec a
	ld d, 0
	ld e, a
	ld h, 0
	ld l, a
	add hl, hl ; hl = hl * 4
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + de
	add hl, hl ; hl = (5*hl) + (5*hl)
	ld de, PokemonNames
	add hl, de

; Terminator
	ld de, wStringBuffer1
	push de
	ld bc, PKMN_NAME_LENGTH - 1
	rst CopyBytes
	ld hl, wStringBuffer1 + PKMN_NAME_LENGTH - 1
	ld [hl], "@"
	pop de

	pop hl
	pop af
	rst Bankswitch
	ret
; 3468

GetCurItemName::
; Get item name from item in CurItem
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
GetItemName:: ; 3468
; Get item name wNamedObjectIndexBuffer.
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, ITEM_NAME
	jr PutNameInBufferAndGetName
; 3487

GetCurKeyItemName::
; Get item name from item in CurItem
	ld a, [wCurKeyItem]
	inc a
	ld [wNamedObjectIndexBuffer], a
GetKeyItemName:: ; 3468
; Get key item item name wNamedObjectIndexBuffer.
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, KEY_ITEM_NAME
	jr PutNameInBufferAndGetName

GetApricornName::
; Get apricorn name wNamedObjectIndexBuffer.
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, APRICORN_NAME
PutNameInBufferAndGetName::
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

GetTMHMName::
	homecall _GetTMHMName
	ret

IsHMMove:: ; 34e7
	ld hl, .HMMoves
	ld de, 1
	jp IsInArray

.HMMoves:
	db CUT
	db FLY
	db SURF
	db STRENGTH
	db WATERFALL
	db WHIRLPOOL
	db -1
; 34f8

GetMoveName:: ; 34f8
	push hl

	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a

	ld a, [wNamedObjectIndexBuffer] ; move id
	ld [wCurSpecies], a

	call GetName
	ld de, wStringBuffer1

	pop hl
	ret
; 350c
