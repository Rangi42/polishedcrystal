BattleCommand_memento:
	ld a, [wAttackMissed]
	and a
	ret nz

	farcall CheckSubstituteOpp
	jr nz, .failed

	;farcall AnimateCurrentMove

	ld b, $10 | ATTACK
	farcall ForceLowerOppStat
	ld b, $10 | SP_ATTACK
	farcall ForceLowerOppStat

	ld hl, wWhichMonFaintedFirst
	ldh a, [hBattleTurn]
	inc a
	ld [hl], a

	xor a
	farjp SelfFaintUser

.failed
	farjp ButItFailed