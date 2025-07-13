BattleCommand_embargo:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyThroatChopEmbargoCount
	jr z, .got
	ld hl, wPlayerThroatChopEmbargoCount
.got
	ld a, [hl]
	and $0F
	jr nz, .failed
	ld a, [hl]
	or a, $05
	ld [hl], a
	ld hl, EmbargoEffectText
	farcall AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
