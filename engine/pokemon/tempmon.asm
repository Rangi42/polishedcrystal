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
	jr _CopyPkmnToTempMon

CopyPkmnToTempMon:
; gets the BaseData of a Pkmn
; and copys the PkmnStructure to wTempMon

	ld a, [wCurPartyMon]
	ld e, a
	call GetPkmnSpecies
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
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

CalcwBufferMonStats:
	ld bc, wBufferMon
	jr _TempMonStatsCalculation

CalcTempmonStats:
	ld bc, wTempMon
_TempMonStatsCalculation:
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_EVS - 1
	add hl, bc
	push bc
	ld b, TRUE
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
; [wMonType] has the type of the Pkmn
; e = Nr. of Pkmn (i.e. [wCurPartyMon])

	ld a, [wMonType]
	and a ; PARTYMON
	jr z, .partymon
	cp OTPARTYMON
	jr z, .otpartymon
	cp BOXMON
	jr z, .boxmon
	cp TEMPMON
	jr z, .breedmon
	; WILDMON

.partymon
	ld hl, wPartySpecies
	jr .done

.otpartymon
	ld hl, wOTPartySpecies
	jr .done

.boxmon
	ld a, BANK(sBoxSpecies)
	call GetSRAMBank
	ld hl, sBoxSpecies
	call .done
	jp CloseSRAM

.breedmon
	ld a, [wBreedMon1Species]
	jr .done2

.done
	ld d, 0
	add hl, de
	ld a, [hl]

.done2
	ld [wCurPartySpecies], a
	ret
