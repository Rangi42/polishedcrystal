BattleCommand_leechseed:
	ld a, [wAttackMissed]
	and a
	jr nz, .evaded
	call CheckSubstituteOpp
	jr nz, .evaded
	call CheckIfTargetIsGrassType
	jr z, .grass

	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr nz, .evaded
	set SUBSTATUS_LEECH_SEED, [hl]
	call AnimateCurrentMove
	ld hl, WasSeededText
	jmp StdBattleTextbox

.grass
	call AnimateFailedMove
	jmp PrintDoesntAffect

.evaded
	call AnimateFailedMove
	ld hl, EvadedText
	jmp StdBattleTextbox
