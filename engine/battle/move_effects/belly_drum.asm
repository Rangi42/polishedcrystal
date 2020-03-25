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

	call GetHalfMaxHP
	predef SubtractHPFromUser
	call UpdateUserInParty
	call GetTrueUserAbility
	cp CONTRARY
	ld hl, BellyDrumContraryText
	jr z, .print
	ld hl, BellyDrumText
.print
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
