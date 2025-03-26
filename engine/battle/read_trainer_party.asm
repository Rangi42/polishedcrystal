ReadTrainerParty:
	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz ; populated elsewhere

	xor a
	ld [wOTPartyCount], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	rst ByteFill

	call FindTrainerData
	ld a, b
	add l
	ld b, a
	push bc

	call GetNextTrainerDataByte
	ld [wOtherTrainerType], a

.loop2
; level
	pop bc
	ld a, l
	sub b
	ret z
	push bc

	call GetNextTrainerDataByte
	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a

; species
	call GetNextTrainerDataByte
	ld [wCurPartySpecies], a
	ld c, a

	call GetNextTrainerDataByte
	ld [wCurForm], a
	ld b, a

; NPC trainers should appear to have Kantonian Arbok in Kanto,
; so form 0 becomes 1 (Johto) or 2 (Kanto), non-zero forms remain unchanged
	assert !HIGH(ARBOK)
	and SPECIESFORM_MASK
	jr nz, .not_arbok
	ld a, c
	cp LOW(ARBOK)
	jr nz, .not_arbok

	push bc
	call RegionCheck
	ld a, e
	pop bc
	and a
	assert ARBOK_JOHTO_FORM == ARBOK_KANTO_FORM - 1
	ld c, ARBOK_KANTO_FORM
	jr nz, .got_arbok_form
	dec c
.got_arbok_form
	ld a, b
	or c
	ld [wCurForm], a

.not_arbok
	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	pop hl

; item?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_ITEM, a
	jr z, .not_item

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	ld [de], a

.not_item
; DVs?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_DVS, a
	jr z, .not_dvs

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	farcall WriteTrainerDVs

.not_dvs
; personality?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_PERSONALITY, a
	jr z, .not_personality

	; We only care about the upper personality byte.
	; The lower one has already been specified as part of
	; extended species data ("dp").
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl
	call GetNextTrainerDataByte
	ld [de], a

.not_personality
; nickname?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_NICKNAME, a
	jr z, .not_nickname

	call GetNextTrainerDataByte
	cp "@"
	jr z, .not_nickname

	push de
	ld de, wStringBuffer2
	ld [de], a
	inc de
.copy
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	cp "@"
	jr nz, .copy
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop hl
	pop de

.not_nickname
; EVs?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_EVS, a
	jr z, .not_evs
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	farcall WriteTrainerEVs

.not_evs
; moves?
	ld a, [wOtherTrainerType]
	bit TRNTYPE_MOVES, a
	jr z, .not_moves

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	cp RETURN
	jr z, .return
	cp GYRO_BALL
	jr nz, .done_special_moves

	; Set speed EVs and IVs to 0
	push hl
	push de
	push bc
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1SpeEV
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld [hl], 0
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1DefSpeDV
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	; $f1, not $f0, to leave Hidden Power type alone
	and $f1
	ld [hl], a
	pop bc
	pop de
	pop hl
	jr .done_special_moves

.return
	; Maximize happiness
	push hl
	push de
	push bc
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld [hl], MAX_RETURN_HAPPINESS
	pop bc
	pop de
	pop hl

.done_special_moves
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	predef FillPP

	pop hl

.not_moves
	; custom DVs or nature may alter stats
	ld a, [wOtherTrainerType]
	and TRAINERTYPE_EVS | TRAINERTYPE_DVS | TRAINERTYPE_PERSONALITY
	jr z, .no_stat_recalc
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	ld bc, PARTYMON_STRUCT_LENGTH
	push af
	rst AddNTimes
	pop af
	push hl
	ld hl, wOTPartyMon1EVs - 1
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop de
	ld b, TRUE
	push de
	predef CalcPkmnStats
	pop hl
	inc hl
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	dec hl
	ld [hl], a
	pop hl
.no_stat_recalc
	jmp .loop2

Battle_GetTrainerName::
	ld a, [wInBattleTowerBattle]
	and a
	ld hl, wOTPlayerName
	ld a, BANK(Battle_GetTrainerName) ; make FarCopyBytes act like CopyBytes
	ld [wTrainerGroupBank], a
	jr nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wTrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	call SkipTrainerParties
	jr CopyTrainerName

SkipTrainerParties:
; Skips b-1 parties
	; Size of the current party.
	call GetNextTrainerDataByte
	dec b
	ret z

	; Skip all of it.
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	jr SkipTrainerParties

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	ld a, [wTrainerGroupBank]
	call FarCopyBytes
	pop de
	ret

SetTrainerBattleLevel:
	ld a, 255
	ld [wCurPartyLevel], a

	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	call FindTrainerData

	inc hl
	call GetNextTrainerDataByte

	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a
	ret

FindTrainerData:
; Returns party size in bytes excluding trainer name in b.
	farcall SetBadgeBaseLevel

	ld a, [wOtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wTrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
	; fallthrough
SkipTrainerPartiesAndName:
	call SkipTrainerParties
	ld b, a

.skip_name
	dec b
	call GetNextTrainerDataByte
	cp "@"
	jr nz, .skip_name
	ret

GetNextTrainerDataByte:
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	ret

; must come before the EVSpreads table below, to define
; the EV_SPREAD_* values and NUM_EV_SPREADS total
INCLUDE "data/trainers/parties.asm"


SECTION "DV and EV Spreads", ROMX

WriteTrainerDVs:
; Writes DVs to de with the DV spread index in a.
	push hl
	push de
	push bc

	push de
	ld hl, DVSpreads
	ld bc, NUM_STATS / 2 ; 2 DVs per byte
	rst AddNTimes
	rst CopyBytes
	pop hl
	jmp PopBCDEHL

WriteTrainerEVs:
; Writes EVs to de with the EV spread index in a.
; For classic EVs, writes (EV total / 2) to all stats.
; For modern EVs, writes the table data directly.
	push hl
	push de
	push bc

	push de
	ld hl, EVSpreads
	ld bc, NUM_STATS
	rst AddNTimes
	rst CopyBytes
	pop hl

	; If modern EVs are enabled, we're done.
	ld a, [wInitialOptions2]
	and EV_OPTMASK
	cp EVS_OPT_MODERN
	jr z, .done

	; Otherwise, calculate total and set EV to total/2.
	push hl
	farcall _GetEVTotal
	pop hl
	srl b
	rr c
	ld a, c
	cp MODERN_MAX_EV + 1
	jr c, .got_evs
	ld a, MODERN_MAX_EV
.got_evs
	ld bc, NUM_STATS
	rst ByteFill

.done
	jmp PopBCDEHL

DVSpreads:
	table_width NUM_STATS / 2
	for n, NUM_DV_SPREADS
		; each DV_SPREAD_*_HP/ATK/DEF/SPE/SAT/SDF is implicitly defined
		; by `tr_dvs` (see data/trainers/parties.asm)
		dn DV_SPREAD_{d:n}_HP, DV_SPREAD_{d:n}_ATK
		dn DV_SPREAD_{d:n}_DEF, DV_SPREAD_{d:n}_SPE
		dn DV_SPREAD_{d:n}_SAT, DV_SPREAD_{d:n}_SDF
	endr
	assert_table_length NUM_DV_SPREADS

EVSpreads:
	table_width NUM_STATS
	for n, NUM_EV_SPREADS
		; each EV_SPREAD_*_HP/ATK/DEF/SPE/SAT/SDF is implicitly defined
		; by `tr_evs` (see data/trainers/parties.asm)
		with_each_stat "db EV_SPREAD_{d:n}_?"
	endr
	assert_table_length NUM_EV_SPREADS

ENDSECTION
