BattleCommand_safeguard:
	ld hl, wPlayerGuards
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyGuards
.ok
	ld a, [hl]
	and GUARD_SAFEGUARD
	jr nz, .failed
	ld a, 5
	or [hl]
	ld [hl], a
	call AnimateCurrentMove
	ld hl, CoveredByVeilText
	jp StdBattleTextbox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

SafeCheckSafeguard:
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyGuards]
	jr z, .got_guard
	ld a, [wPlayerGuards]
.got_guard
	and GUARD_SAFEGUARD
	ret z
	call GetTrueUserAbility
	cp INFILTRATOR
	ret

BattleCommand_checksafeguard:
	call SafeCheckSafeguard
	ret z
	ld a, 1
	ld [wAttackMissed], a
	call BattleCommand_movedelay
	ld hl, SafeguardProtectText
	call StdBattleTextbox
	jp EndMoveEffect
