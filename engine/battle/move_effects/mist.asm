BattleCommand_mist:
	ld hl, wPlayerGuards
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyGuards
.ok
	ld a, [hl]
	and GUARD_MIST
	jr nz, .failed
	ld a, 5 << 4
	or [hl]
	ld [hl], a
	farcall AnimateCurrentMove
	ld hl, MistText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed

