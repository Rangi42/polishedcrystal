BattleCommand_torment:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_TORMENTED, a
	jr nz, .failed

	set SUBSTATUS_TORMENTED, a
	ld [hl], a
	
	ld hl, TormentEffectText
	farcall AnimateCurrentMove
	call StdBattleTextbox
	farjp CheckMentalHerb

.failed
	farjp ButItFailed
