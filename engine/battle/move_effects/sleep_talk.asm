BattleCommand_sleeptalk:
	call ClearLastMove
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK
	jr z, .fail

	ld a, [wAttackMissed]
	and a
	jr nz, .fail

	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	jr z,  .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	farcall GetDisableEncoreMoves
	lb bc, NUM_MOVES, 0
	ld e, c
	push hl

.usable_move_loop
; b: loop counter
; c: number of eligible moves
; d: disabled move ID
; e: eligible move flags (%0000eeee)
	ld a, [hli]
	and a
	jr z, .end_loop
	sla e
	cp d
	jr z, .next_move

	push hl
	push de
	push bc
	farcall GetMoveEffect
	ld hl, SleepTalkExcepts
	call IsInByteArray
	pop bc
	pop de
	pop hl
	jr c, .next_move
	inc e
	inc c

.next_move
	dec b
	jr nz, .usable_move_loop

.end_loop
	pop hl
	ld a, c
	and a
	jr z, .fail
	call RandomRange
	inc a
	ld b, a
	ld c, NUM_MOVES

.get_move_loop
	dec c
	srl e
	jr nc, .get_move_loop
	dec b
	jr nz, .get_move_loop

	add hl, bc
	ld e, [hl]
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], e
	call CheckUserIsCharging
	jr nz, .charging
	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wBattleAnimParam], a
.charging
	call LoadMoveAnim
	ld a, [wCurMoveNum] ; preserve cursor position
	push af
	call UpdateMoveData
	pop af
	ld [wCurMoveNum], a
	jmp ResetTurn

.fail
	call AnimateFailedMove
	jmp TryPrintButItFailed

INCLUDE "data/moves/sleep_talk_exception_move_effects.asm"
