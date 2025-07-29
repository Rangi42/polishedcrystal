BattleCommand_magnetrise:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerYawnMagnetRiseCount
	jr z, .got
	ld hl, wEnemyYawnMagnetRiseCount
.got
	ld a, [hl]
	and $0F
	jr nz, .failed
	ld a, [hl]
	or $05
	ld [hl], a
	ld hl, MagnetRiseEffectText
	farcall AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
