BattleCommand_arenatrap:
	; Doesn't work on an absent opponent.
	call CheckHiddenOpponent
	jr nz, .failed

	; Don't trap if the opponent is already trapped.
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_CANT_RUN, [hl]
	jr nz, .failed

	; Don't trap Ghost types
	call CheckIfTargetIsGhostType
	jr z, .immune

	; Otherwise trap the opponent.
	set SUBSTATUS_CANT_RUN, [hl]
	call AnimateCurrentMove
	ld hl, CantEscapeNowText
	jp StdBattleTextbox

.immune
	call AnimateFailedMove
	ld hl, DoesntAffectText
	jp StdBattleTextbox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
