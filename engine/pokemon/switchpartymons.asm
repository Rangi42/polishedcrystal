_SwitchPartyMons:
	ld a, [wSwitchMon]
	dec a
	ld [wBuffer3], a
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wBuffer2], a
	cp b
	ret z
	call SwapMonAndMail
	ld a, [wBuffer3]
	call .ClearSprite
	ld a, [wBuffer2]
	; fallthrough

.ClearSprite:
	push af
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	rst AddNTimes
	ld bc, 2 * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	pop af
	ld hl, wVirtualOAM
	ld bc, $10
	rst AddNTimes
	ld de, $4
	ld c, $4
.gfx_loop
	ld [hl], $a0
	add hl, de
	dec c
	jr nz, .gfx_loop
	ld de, SFX_SWITCH_POKEMON
	jmp WaitPlaySFX

SwapMonAndMail:
	push hl
	push de
	push bc
	ld bc, wPartySpecies
	ld a, [wBuffer2]
	ld l, a
	ld h, $0
	add hl, bc
	ld d, h
	ld e, l
	ld a, [wBuffer3]
	ld l, a
	ld h, $0
	add hl, bc
	ld a, [hl]
	push af
	ld a, [de]
	ld [hl], a
	pop af
	ld [de], a
	ld a, [wBuffer2]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld de, wSwitchMonBuffer
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wBuffer3]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop de
	push hl
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	pop de
	ld hl, wSwitchMonBuffer
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wBuffer2]
	ld hl, wPartyMonOTs
	call SkipNames
	push hl
	call .CopyNameTowSwitchMonBuffer
	ld a, [wBuffer3]
	ld hl, wPartyMonOTs
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wSwitchMonBuffer
	call .CopyName
	ld hl, wPartyMonNicknames
	ld a, [wBuffer2]
	call SkipNames
	push hl
	call .CopyNameTowSwitchMonBuffer
	ld hl, wPartyMonNicknames
	ld a, [wBuffer3]
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wSwitchMonBuffer
	call .CopyName
	ld hl, sPartyMail
	ld a, [wBuffer2]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld de, wSwitchMonBuffer
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	rst CopyBytes
	ld hl, sPartyMail
	ld a, [wBuffer3]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	pop de
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop de
	ld hl, wSwitchMonBuffer
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	call CloseSRAM
	jmp PopBCDEHL

.CopyNameTowSwitchMonBuffer:
	ld de, wSwitchMonBuffer

.CopyName:
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret
