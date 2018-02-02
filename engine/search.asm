SpecialBeastsCheck: ; 0x4a6e8
; Check if the player owns all three legendary beasts.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in ScriptVar.

	ld a, RAIKOU
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, ENTEI
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, SUICUNE
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ld [ScriptVar], a
	ret


SpecialBirdsCheck:
; Check if the player owns all three legendary birds.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in ScriptVar.

	ld a, ARTICUNO
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, ZAPDOS
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, MOLTRES
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ld [ScriptVar], a
	ret


SpecialDuoCheck:
; Check if the player owns Lugia and Ho-Oh.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in ScriptVar.

	ld a, LUGIA
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, HO_OH
	ld [ScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ld [ScriptVar], a
	ret


SpecialMonCheck: ; 0x4a711
; Check if the player owns any monsters of the species in ScriptVar.
; Return the result in ScriptVar.

	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ld [ScriptVar], a
	ret


SpecialMonCheckFailed:
	xor a
	ld [ScriptVar], a
	ret


CheckOwnMonAnywhere: ; 0x4a721
; Check if the player owns any monsters of the species in ScriptVar.
; It must exist in either party or PC, and have the player's OT and ID.

	; If there are no monsters in the party,
	; the player must not own any yet.
	ld a, [PartyCount]
	and a
	ret z

	ld d, a
	ld e, 0
	ld hl, PartyMon1Species
	ld bc, PartyMonOT

	; Run CheckOwnMon on each Pokémon in the party.
.partymon
	call CheckOwnMon
	ret c ; found!

	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .partymon

	; Run CheckOwnMon on each Pokémon in the PC.
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld a, [sBoxCount]
	and a
	jr z, .boxes

	ld d, a
	ld hl, sBoxMon1Species
	ld bc, sBoxMonOT
.openboxmon
	call CheckOwnMon
	jr nc, .loop

	; found!
	jp CloseSRAM

.loop
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .openboxmon

	; Run CheckOwnMon on each monster in the other 13 PC boxes.
.boxes
	call CloseSRAM

	ld c, 0
.box
	; Don't search the current box again.
	ld a, [wCurBox]
	and $f
	cp c
	jr z, .loopbox

	; Load the box.
	ld hl, BoxAddressTable1
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call GetSRAMBank
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Number of monsters in the box
	ld a, [hl]
	and a
	jr z, .loopbox

	push bc

	push hl
	ld de, sBoxMons - sBoxCount
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	ld de, sBoxMonOT - sBoxCount
	add hl, de
	ld b, h
	ld c, l
	pop hl

	ld d, a

.boxmon
	call CheckOwnMon
	jr nc, .loopboxmon

	; found!
	pop bc
	jp CloseSRAM

.loopboxmon
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	call UpdateOTPointer
	dec d
	jr nz, .boxmon
	pop bc

.loopbox
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .box

	; not found
	call CloseSRAM
	and a
	ret


CheckOwnMon: ; 0x4a7ba
; Check if a Pokémon belongs to the player and is of a specific species.

; inputs:
; hl, pointer to PartyMonNSpecies
; bc, pointer to PartyMonNOT
; ScriptVar should contain the species we're looking for

; outputs:
; sets carry if monster matches species, ID, and OT name.

	push bc
	push hl
	push de
	ld d, b
	ld e, c

; check species
	ld a, [ScriptVar] ; species we're looking for
	ld b, [hl] ; species we have
	cp b
	jr nz, .notfound ; species doesn't match

; check ID number
	ld bc, MON_ID
	add hl, bc ; now hl points to ID number
	ld a, [PlayerID]
	cp [hl]
	jr nz, .notfound ; ID doesn't match
	inc hl
	ld a, [PlayerID + 1]
	cp [hl]
	jr nz, .notfound ; ID doesn't match

; check OT
	ld hl, PlayerName
	ld b, PLAYER_NAME_LENGTH +- 1
.loop
	ld a, [de]
	cp [hl]
	jr nz, .notfound
	cp "@"
	jr z, .found ; reached end of string
	inc hl
	inc de
	dec b
	jr nz, .loop

.found
	pop de
	pop hl
	pop bc
	scf
	ret

.notfound
	pop de
	pop hl
	pop bc
	and a
	ret
; 0x4a810

BoxAddressTable1: ; 4a810
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14
; 4a83a

UpdateOTPointer: ; 0x4a83a
	push hl
	ld hl, NAME_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret
; 0x4a843
