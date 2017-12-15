ReadTrainerParty: ; 39771
	ld a, [InBattleTowerBattle]
	bit 0, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz ; populated elsewhere

	ld hl, OTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, OTPartyMons
	ld bc, OTPartyMonsEnd - OTPartyMons
	xor a
	call ByteFill

	call FindTrainerData

	call GetNextTrainerDataByte
	ld [OtherTrainerType], a

.loop2
; level
	call GetNextTrainerDataByte
	cp $ff
	ret z

	ld [CurPartyLevel], a

; species
	call GetNextTrainerDataByte
	ld [CurPartySpecies], a

	ld a, OTPARTYMON
	ld [MonType], a

	push hl
	predef TryAddMonToParty
	pop hl

; item?
	ld a, [OtherTrainerType]
	bit TRNTYPE_ITEM, a
	jr z, .not_item

	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	ld [de], a

.not_item
; EVs?
	ld a, [OtherTrainerType]
	bit TRNTYPE_EVS, a
	jr z, .not_evs
	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1EVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	push hl
	ld h, d
	ld l, e
rept 6
	ld [hli], a
endr
	pop hl

.not_evs
; DVs?
	ld a, [OtherTrainerType]
	bit TRNTYPE_DVS, a
	jr z, .not_dvs

	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	; when reading DVs, $00 means $ff, since $ff is the end-of-trainer marker
	call GetNextTrainerDataByte
	and a
	jr nz, .dv1_ok
	ld a, $ff
.dv1_ok
	ld [de], a
	inc de
	call GetNextTrainerDataByte
	and a
	jr nz, .dv2_ok
	ld a, $ff
.dv2_ok
	ld [de], a
	inc de
	call GetNextTrainerDataByte
	and a
	jr nz, .dv3_ok
	ld a, $ff
.dv3_ok
	ld [de], a

.not_dvs
; personality?
	ld a, [OtherTrainerType]
	bit TRNTYPE_PERSONALITY, a
	jr z, .not_personality

	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	call GetNextTrainerDataByte
	ld [de], a
	inc de
	call GetNextTrainerDataByte
	ld [de], a

.not_personality
; nickname?
	ld a, [OtherTrainerType]
	bit TRNTYPE_NICKNAME, a
	jr z, .not_nickname

	push de
	ld de, StringBuffer2
.copy
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	cp "@"
	jr nz, .copy
	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, StringBuffer2
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	pop hl
	pop de

.not_nickname
; moves?
	ld a, [OtherTrainerType]
	bit TRNTYPE_MOVES, a
	jr z, .not_moves

	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	call GetNextTrainerDataByte
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp
	pop hl

.not_moves
	; custom DVs or nature may alter stats
	ld a, [OtherTrainerType]
	and TRAINERTYPE_EVS | TRAINERTYPE_DVS | TRAINERTYPE_PERSONALITY
	jr z, .no_stat_recalc
	push hl
	ld a, [OTPartyCount]
	dec a
	ld hl, OTPartyMon1MaxHP
	ld bc, PARTYMON_STRUCT_LENGTH
	push af
	call AddNTimes
	pop af
	push hl
	ld hl, OTPartyMon1EVs - 1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop de
	ld b, TRUE
	push de
	predef CalcPkmnStats
	pop hl
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b
	pop hl
.no_stat_recalc
	jp .loop2

Battle_GetTrainerName:: ; 39939
	ld a, [InBattleTowerBattle]
	bit 0, a
	ld hl, OTPlayerName
	ld a, BANK(Battle_GetTrainerName) ; make FarCopyBytes act like CopyBytes
	ld [TrainerGroupBank], a
	jp nz, CopyTrainerName

	ld a, [OtherTrainerID]
	ld b, a
	ld a, [OtherTrainerClass]
	ld c, a

GetTrainerName:: ; 3994c
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [TrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, CopyTrainerName

.skip
	call GetNextTrainerDataByte
	cp $ff
	jr nz, .skip
	jr .loop

CopyTrainerName: ; 39984
	ld de, StringBuffer1
	push de
	ld bc, NAME_LENGTH
	ld a, [TrainerGroupBank]
	call FarCopyBytes
	pop de
	ret
; 39990

SetTrainerBattleLevel:
	ld a, 255
	ld [CurPartyLevel], a

	ld a, [InBattleTowerBattle]
	bit 0, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	call FindTrainerData

	inc hl
	call GetNextTrainerDataByte
	ld [CurPartyLevel], a
	ret

FindTrainerData:
	ld a, [OtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [TrainerGroupBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [OtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop1
	call GetNextTrainerDataByte
	cp $ff
	jr nz, .loop1
	jr .skip_trainer
.got_trainer

.skip_name
	call GetNextTrainerDataByte
	cp "@"
	jr nz, .skip_name
	ret

GetNextTrainerDataByte:
	ld a, [TrainerGroupBank]
	call GetFarByte
	inc hl
	ret
