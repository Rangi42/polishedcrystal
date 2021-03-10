CopyPkmnOrEggToTempMon:
	ld a, [wMonType]
	ld hl, wPartyMon1IsEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	and a
	jr z, .got_addr
	ld hl, wOTPartyMon1IsEgg
	cp OTPARTYMON
	jr z, .got_addr
	ld hl, sBoxMon1IsEgg
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, BANK(sBoxMon1IsEgg)
	call GetSRAMBank
.got_addr
	ld a, [wCurPartyMon]
	rst AddNTimes
	bit MON_IS_EGG_F, [hl]
	jr z, CopyPkmnToTempMon
	ld a, EGG
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	jr _CopyPkmnToTempMon ; [wCurForm] doesn't matter form WGG

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
	ld bc, BOXMON_STRUCT_LENGTH
	farjp CopyBoxmonToTempMon

.copywholestruct
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ret

CalcBufferMonStats:
	ld bc, wBufferMon
	ld hl, wBufferMonOT
	jr _TempMonStatsCalculation

CalcTempmonStats:
	ld bc, wTempMon
_TempMonStatsCalculation:
	push hl
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	pop hl
	ld de, PLAYER_NAME_LENGTH
	add hl, de
	ld a, [hl]
	and HYPER_TRAINING_MASK
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_EVS - 1
	add hl, bc
	push bc
	inc a
	ld b, a
	predef CalcPkmnStats
	pop bc
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_IS_EGG
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	xor a
	ld [de], a
	inc de
	ld [de], a
	jr .zero_status

.not_egg
	push bc
	ld hl, MON_MAXHP
	add hl, bc
	ld bc, 2
	rst CopyBytes
	pop bc

.zero_status
	ld hl, MON_STATUS
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
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
	ld hl, wPartySpecies
	jr .done

.otpartymon
	ld hl, wOTPartySpecies
.done
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
.done2
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ret

.boxmon
	ld a, BANK(sBoxSpecies)
	call GetSRAMBank
	ld hl, sBoxSpecies
	call .done
	jp CloseSRAM

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
	and BASEMON_MASK
	ld [wCurForm], a
	ret

.boxmon
	ld a, BANK(sBoxSpecies)
	call GetSRAMBank
	ld hl, sBoxMon1Form
	ld bc, BOXMON_STRUCT_LENGTH
	call .getnthmon
	jp CloseSRAM

.breedmon
	ld a, [wBreedMon1Form]
	jr .done
