BattleCommand_checkfuturesight:
	call GetFutureSightUser
	ret c
	ld b, futuresight_command
	jmp SkipToBattleCommandAfter

BattleCommand_futuresight:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFutureSightCount
	ld bc, wCurBattleMon
	jr z, .got_future
	ld hl, wEnemyFutureSightCount
	ld bc, wCurOTMon
.got_future
	ld a, [hl]
	and a
	jr nz, .failed

	; end of turn 2 turns later (3 ticks)
	ld a, [bc]
	inc a
	swap a
	or $3
	ld [hl], a

	call BattleCommand_movedelay
	ld hl, ForesawAttackText
	call StdBattleTextbox
	jmp EndMoveEffect

.failed
	call AnimateFailedMove
	call PrintButItFailed
	jmp EndMoveEffect

GetFutureSightUser::
; Returns:
; c|z: Regular user in a (Future Sight not involved)
; nc|z: Active user in a (Future Sight applying)
; nc|nz: External user in a (or active fainted), future sight applying.
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFutureSightCount
	ld bc, wCurBattleMon
	jr z, .got_future
	ld hl, wEnemyFutureSightCount
	ld bc, wCurOTMon
.got_future
	ld a, [hl]
	and a
	jr z, .future_sight_offline
	and $f
	jr nz, .future_sight_offline
	ld a, [hl]
	swap a
	dec a
	and $f
	ld d, a
	ld a, [bc]
	cp d
	ld a, d
	pop bc
	pop de
	pop hl
	scf
	ccf
	ret nz

	; If user is fainted, treat as non-active
	push af
	push hl
	call HasUserFainted
	pop hl
	jr z, .active_fainted
	pop af
	ret

.active_fainted
	pop af
	and a
	ret nz
	rrca
	ret

.future_sight_offline
	xor a
	ld a, [bc]
	pop bc
	pop de
	pop hl
	scf
	ret
