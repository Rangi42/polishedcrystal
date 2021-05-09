SpecialBeastsCheck:
; Check if the player owns all three legendary beasts.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in hScriptVar.

	ld a, LOW(RAIKOU)
	ldh [hScriptVar], a
	ld a, HIGH(RAIKOU) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, LOW(ENTEI)
	ldh [hScriptVar], a
	ld a, HIGH(ENTEI) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	ldh [hScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, LOW(SUICUNE)
	ldh [hScriptVar], a
	ld a, HIGH(SUICUNE) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	ldh [hScriptVar], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialBirdsCheck:
; Check if the player owns all three legendary birds.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in hScriptVar.

	ld a, LOW(ARTICUNO)
	ldh [hScriptVar], a
	ld a, HIGH(ARTICUNO) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, LOW(ZAPDOS)
	ldh [hScriptVar], a
	ld a, HIGH(ZAPDOS) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, LOW(MOLTRES)
	ldh [hScriptVar], a
	ld a, HIGH(MOLTRES) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialDuoCheck:
; Check if the player owns Lugia and Ho-Oh.
; They must exist in either party or PC, and have the player's OT and ID.
; Return the result in hScriptVar.

	ld a, LOW(LUGIA)
	ldh [hScriptVar], a
	ld a, HIGH(LUGIA) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	ld a, LOW(HO_OH)
	ldh [hScriptVar], a
	ld a, HIGH(HO_OH) << MON_EXTSPECIES_F
	ldh [hScriptVar+1], a
	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialMonCheck:
; Check if the player owns any monsters of the species in hScriptVar.
; Return the result in hScriptVar.

	call CheckOwnMonAnywhere
	jr nc, SpecialMonCheckFailed

	; they exist
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialMonCheckFailed:
	xor a
	ldh [hScriptVar], a
	ret

CheckOwnMonAnywhere:
; Check if the player owns any monsters of the species in hScriptVar.
; It must exist in either party or PC, and have the player's OT and ID.

	ld b, NUM_BOXES
.outer_loop
	inc b
	dec b
	ld c, PARTY_LENGTH
	jr z, .loop
	ld c, MONS_PER_BOX
.loop
	farcall GetStorageBoxMon
	jr z, .next

	; Check if the species is correct
	ld hl, wTempMonSpecies
	ldh a, [hScriptVar]
	cp [hl]
	jr nz, .next

	; Check if the extspecies is correct, too
	ld a, [wTempMonExtSpecies]
	and EXTSPECIES_MASK
	ld hl, hScriptVar+1
	cp [hl]
	jr nz, .next

	; Eggs don't count
	ld hl, wTempMonIsEgg
	bit MON_IS_EGG_F, [hl]
	jr nz, .next

	; If we have the "always OT" initial option on, this is always ours
	ld a, [wInitialOptions]
	bit TRADED_AS_OT_OPT, a
	scf
	ret nz

	; Verify ID
	ld hl, wTempMonID
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .next
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	jr nz, .next

	; Verify OT
	ld hl, wTempMonOT
	ld de, wPlayerName
.cmp_ot
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	jr nz, .next
	cp "@"
	scf
	ret z
	jr .cmp_ot
.next
	dec c
	jr nz, .loop
	dec b
	bit 7, b ; check for reaching -1
	jr z, .outer_loop

	; Failed to find a matching mon
	xor a
	ret
