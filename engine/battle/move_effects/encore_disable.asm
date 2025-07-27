BattleCommand_encore:
	ldh a, [hBattleTurn]
	and a
	ld bc, ENCORE
	ld de, wEnemyEncoreCount
	ld hl, wEnemyMonMoves
	jr z, DoEncoreDisable
	ld de, wPlayerEncoreCount
	ld hl, wBattleMonMoves
	jr DoEncoreDisable

BattleCommand_disable:
	ldh a, [hBattleTurn]
	and a
	ld bc, DISABLE
	ld de, wEnemyDisableCount
	ld hl, wEnemyMonMoves
	jr z, DoEncoreDisable
	ld de, wPlayerDisableCount
	ld hl, wBattleMonMoves
DoEncoreDisable:
	ld a, [de]
	and $f
	jr nz, .failed

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	jr z, .failed
	ld b, a
	push bc
	ld bc, STRUGGLE
	call CompareMove
	pop bc
	jr z, .failed

	; Don't allow encoring Encore
	call CompareMove
	jr nz, .move_ok
	push bc
	ld bc, ENCORE
	call CompareMove
	pop bc
	jr z, .failed
.move_ok

	push hl
	push de
	push bc
	push af

	ld [wNamedObjectIndex], a
	call GetMoveName
	; since abilities use strbuf1, copy to strbuf2 to not overwrite it
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	rst CopyBytes

	pop af
	pop bc
	pop de
	pop hl

	call UserKnowsMove
	ret nz

	; Can't Disable/Encore moves with no PP left
	push bc
	ld bc, wBattleMonPP - wBattleMonMoves
	add hl, bc
	pop bc
	ld a, [hl]
	and $3f
	jr z, .failed

	; Potential Cursed Body message
	farcall ShowPotentialAbilityActivation

	; Get move effect text and duration
	ld a, b
	assert HIGH(DISABLE) == 0
	and a
	jr nz, .cpbc_disable
	ld a, c
	assert LOW(DISABLE) != 0
	cp LOW(DISABLE)
.cpbc_disable
	ld hl, WasDisabledText
	ld a, 4
	jr z, .got_text_and_duration
	ld hl, GotAnEncoreText
	dec a

	; Force opponent to use encored move in case it moves second
	push hl
	push af
	ld a, BATTLE_VARS_MOVE_OPP
	call GetBattleVarAddr
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	ld [hl], a
	pop af
	pop hl
.got_text_and_duration
	inc c
	swap c
	or c
	ld [de], a
	call AnimateCurrentMove
	call StdBattleTextbox
	jmp CheckOpponentMentalHerb

.failed
	; Cursed Body prints nothing in this case.
	ld a, [wInAbility]
	and a
	ret nz

	call AnimateFailedMove
	jmp PrintButItFailed
