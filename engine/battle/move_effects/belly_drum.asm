BattleCommand_bellydrum:
	call GetHalfMaxHP
	call CompareHP
	jr c, .failed
	jr z, .failed

	ld b, $f0 | ATTACK
	ld a, STAT_SKIPTEXT
	call _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .failed

	call AnimateCurrentMove
	call GetHalfMaxHP
	predef SubtractHPFromUser
	call UpdateUserInParty
	call GetTrueUserAbility
	cp CONTRARY
	ld hl, BellyDrumContraryText
	jr z, .print
	ld hl, BellyDrumText
.print
	xor a
	farjp DoPrintStatChange

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
