BattleCommand_nightmare:
	ld a, [wAttackMissed]
	and a
	jr nz, .evaded

	farcall CheckSubstituteOpp
	jr nz, .evaded

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and SLP_MASK
	jr z, .failed

	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_NIGHTMARE, [hl]
	jr nz, .failed
	set SUBSTATUS_NIGHTMARE, [hl]
	farcall AnimateCurrentMove
	ld hl, FellIntoANightmareText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed

.evaded
	farcall AnimateFailedMove
	ld hl, EvadedText
	jmp StdBattleTextbox
