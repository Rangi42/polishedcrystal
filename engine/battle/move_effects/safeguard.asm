BattleCommand_safeguard:
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
.ok
	bit SCREENS_SAFEGUARD, [hl]
	jr nz, .failed
	set SCREENS_SAFEGUARD, [hl]
	ld a, 5
	ld [de], a
	call AnimateCurrentMove
	ld hl, CoveredByVeilText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

SafeCheckSafeguard:
	push hl
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
	call GetTrueUserAbility
	bit SCREENS_SAFEGUARD, [hl]
	jr z, .done
	cp INFILTRATOR

.done
	pop hl
	ret

BattleCommand_checksafeguard:
	call SafeCheckSafeguard
	ret z
	ld a, 1
	ld [wAttackMissed], a
	call BattleCommand_movedelay
	ld hl, SafeguardProtectText
	call StdBattleTextBox
	jp EndMoveEffect
