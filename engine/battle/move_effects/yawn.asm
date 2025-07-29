BattleCommand_yawn:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	farcall CanSleepTarget
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyYawnMagnetRiseCount
	jr z, .got
	ld hl, wPlayerYawnMagnetRiseCount
.got
	ld a, [hl]
	and $F0
	jr nz, .failed
	ld a, [hl]
	or $20
	ld [hl], a
	ld hl, YawnEffectText
	farcall AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
