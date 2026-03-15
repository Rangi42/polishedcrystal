_SwitchPartyMons:
	ld a, [wSwitchMon]
	dec a
	ld [wSwitchPartyMonTarget], a
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wSwitchPartyMonSource], a
	cp b
	ret z
	call SwapMonAndMail
	ld a, [wSwitchPartyMonTarget]
	call .ClearSprite
	ld a, [wSwitchPartyMonSource]
	; fallthrough

.ClearSprite:
	push af
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	rst AddNTimes
	ld bc, 2 * SCREEN_WIDTH
	ld a, ' '
	rst ByteFill
	pop af
	ld hl, wShadowOAM
	ld bc, MINI_OAM_COUNT * OBJ_SIZE
	rst AddNTimes
	ld de, OBJ_SIZE
	ld c, MINI_OAM_COUNT
.gfx_loop
	ld [hl], OAM_YCOORD_HIDDEN
	add hl, de
	dec c
	jr nz, .gfx_loop
	ld de, SFX_SWITCH_POKEMON
	jmp WaitPlaySFX

SwapMonAndMail:
	push hl
	push de
	push bc
	ld a, [wSwitchPartyMonSource]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld de, wSwitchMonBuffer
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wSwitchPartyMonTarget]
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
	ld a, [wSwitchPartyMonSource]
	ld hl, wPartyMonOTs
	call SkipNames
	push hl
	call .CopyNameTowSwitchMonBuffer
	ld a, [wSwitchPartyMonTarget]
	ld hl, wPartyMonOTs
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wSwitchMonBuffer
	call .CopyName
	ld hl, wPartyMonNicknames
	ld a, [wSwitchPartyMonSource]
	call SkipNames
	push hl
	call .CopyNameTowSwitchMonBuffer
	ld hl, wPartyMonNicknames
	ld a, [wSwitchPartyMonTarget]
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wSwitchMonBuffer
	call .CopyName
	ld hl, sPartyMail
	ld a, [wSwitchPartyMonSource]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld de, wSwitchMonBuffer
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	rst CopyBytes
	ld hl, sPartyMail
	ld a, [wSwitchPartyMonTarget]
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
