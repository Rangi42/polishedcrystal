BattleCommand_batonpass:
	call CheckAnyOtherAliveMons
	jr z, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerMinimized
	jr z, .got_minimize
	ld hl, wEnemyMinimized
.got_minimize
	xor a
	ld [hl], a

	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_BATON_PASS
	jp SetDeferredSwitch

.failed
	call AnimateFailedMove
	jp PrintButItFailed
