BattleCommand_taunt:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyTauntCount
	ld a, [wEnemyGoesFirst]
	jr z, .got
	ld hl, wPlayerTauntCount
	xor a, 1
.got
	and a
	; we went first
	ld b, $30
	jr z, .order_done
	; they went first
	ld b, $40
.order_done
	ld a, [hl]
	and $F0
	jr nz, .failed
	ld a, [hl]
	or a, b
	ld [hl], a
	ld hl, TauntEffectText
	farcall AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
