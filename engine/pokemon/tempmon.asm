CopyPkmnToTempMon:
; gets the BaseData of a Pkmn
; and copys the PkmnStructure to wTempMon

	call GetPkmnSpecies
	call GetPkmnForm
_CopyPkmnToTempMon:
	call GetBaseData

	ld a, [wMonType]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	and a
	jr z, .copywholestruct
	ld hl, wOTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	cp OTPARTYMON
	jr z, .copywholestruct
	ld a, ERR_PC_BOX_OLD
	jmp Crash

.copywholestruct
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ret

GetPkmnSpecies:
	ld a, [wMonType]
	and a ; PARTYMON
	jr z, .partymon
	dec a ; OTPARTYMON
	jr z, .otpartymon
	dec a ; BOXMON
	jr z, .boxmon
	dec a ; TEMPMON
	jr z, .breedmon
	; WILDMON

.partymon
	ld hl, wPartyMon1Species
	jr .done

.otpartymon
	ld hl, wOTPartyMon1Species
.done
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld a, [hl]
.done2
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ret

.boxmon
	ld a, ERR_PC_BOX_OLD
	jmp Crash

.breedmon
	ld a, [wBreedMon1Species]
	jr .done2

GetPkmnForm:
	ld a, [wMonType]
	and a ; PARTYMON
	jr z, .partymon
	dec a ; OTPARTYMON
	jr z, .otpartymon
	dec a ; BOXMON
	jr z, .boxmon
	dec a ; TEMPMON
	jr z, .breedmon
	; WILDMON

.partymon
	ld hl, wPartyMon1Form
	jr .getnthpartymon

.otpartymon
	ld hl, wOTPartyMon1Form
.getnthpartymon
	ld bc, PARTYMON_STRUCT_LENGTH
.getnthmon
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld a, [hl]
.done
	and SPECIESFORM_MASK
	ld [wCurForm], a
	ret

.boxmon
	ld a, ERR_PC_BOX_OLD
	jmp Crash

.breedmon
	ld a, [wBreedMon1Form]
	jr .done
