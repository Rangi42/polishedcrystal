_StatsScreenDPad:
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	and a
	jr z, .empty
	dec a
	cp $1
	jr z, .empty
	ld e, a
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown
.empty
	xor a
	ret

BillsPC_PressUp:
	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	and a
	jr z, .top
	dec [hl]
	jr BillsPC_UpDownDidSomething

.top
	ld hl, wBillsPC_ScrollPosition
	ld a, [hl]
	and a
	jr z, BillsPC_JoypadDidNothing
	dec [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_PressDown:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	inc a
	cp e
	jr nc, BillsPC_JoypadDidNothing

	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	inc a
	cp d
	jr nc, .not_bottom
	inc [hl]
	jr BillsPC_UpDownDidSomething

.not_bottom
	ld hl, wBillsPC_ScrollPosition
	inc [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_JoypadDidNothing:
	xor a
	ret

BillsPC_UpDownDidSomething:
	ld a, TRUE
	and a
	ret

BillsPC_LoadMonStats:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wBillsPCPokemonList + 1
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jp z, .sBox
	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	; level
	push hl
	ld bc, sBoxMon1Level - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	pop hl
	; item
	push hl
	ld bc, sBoxMon1Item - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	pop hl
	; DVs and personality (DVs for color variation)
	push hl
	ld bc, sBoxMon1DVs - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	pop hl
	; moves (for Pikachu forms)
	ld bc, sBoxMon1Moves - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	jp CloseSRAM

.party
	; level
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	; item
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	; DVs and personality (DVs for color variation)
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	; moves (for Pikachu forms)
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	ret

.sBox
	ld a, BANK(sBox)
	call GetSRAMBank
	; level
	ld hl, sBoxMon1Level
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	; item
	ld hl, sBoxMon1Item
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	; DVs and personality (DVs for color variation)
	ld hl, sBoxMon1DVs
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	; moves (for Pikachu forms)
	ld hl, sBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	jp CloseSRAM

BillsPC_GetSelectedPokemonSpecies:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wBillsPCPokemonList
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	ret

CheckCurPartyMonFainted:
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, $0
.loop
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	dec hl

.skip
	inc b
	ld a, [wPartyCount]
	cp b
	jr z, .done
	add hl, de
	jr .loop

.done
	scf
	ret

.notfainted
	and a
	ret

StatsScreenDPad:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON | D_RIGHT | D_LEFT
	ld [wMenuJoypad], a
	ret nz

	ld a, [hl]
	and D_DOWN | D_UP
	ld [wMenuJoypad], a
	ret z

	call _StatsScreenDPad
	and a
	jr z, .did_nothing
	call BillsPC_GetSelectedPokemonSpecies
	ld [wd265], a
	call BillsPC_LoadMonStats
	ld a, [wd265]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonForm
	predef GetVariant
	call GetBaseData
	jp BillsPC_CopyMon

.did_nothing
	xor a
	ld [wMenuJoypad], a
	ret

BillsPC_CopyMon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr nz, .box
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxSpecies
	call CopySpeciesToTemp
	ld hl, sBoxMonNicknames
	call CopyNicknameToTemp
	ld hl, sBoxMonOT
	call CopyOTNameToTemp
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	call CloseSRAM
	farjp CalcBufferMonStats

.party
	ld hl, wPartySpecies
	call CopySpeciesToTemp
	ld hl, wPartyMonNicknames
	call CopyNicknameToTemp
	ld hl, wPartyMonOT
	call CopyOTNameToTemp
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ret

.box
	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	push hl
	inc hl
	call CopySpeciesToTemp
	pop hl
	push hl
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	call CopyNicknameToTemp
	pop hl
	push hl
	ld bc, sBoxMonOT - sBox
	add hl, bc
	call CopyOTNameToTemp
	pop hl
	ld bc, sBoxMons - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyMonToTemp
	call CloseSRAM
	farjp CalcBufferMonStats

CopySpeciesToTemp:
	ld a, [wCurPartyMon]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ret

CopyNicknameToTemp:
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMonNick
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret

CopyOTNameToTemp:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

CopyMonToTemp:
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	rst CopyBytes
	ret

GetBoxPointer:
	dec b
	ld c, b
	ld b, 0
	ld hl, .boxes
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.boxes
	;  bank, address
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

GetBoxName:
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	rst AddNTimes
	ld d, h
	ld e, l
	ret

GetBoxCountWithC:
	ld a, [wCurBox]
	ld b, a
	ld a, c
	ld c, b
	dec a
	cp c
	jr z, .activebox
	ld c, a
	ld b, 0
	ld hl, .boxbanks
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	call GetSRAMBank
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ld c, a
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .newfile
	ld a, c
	ret

.newfile
	xor a
	ret

.activebox
	ld a, BANK(sBoxCount)
	ld b, a
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, [hl]
	jp CloseSRAM

.boxbanks
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
