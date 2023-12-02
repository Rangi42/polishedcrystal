BattleCommand_pursuit:
; Sets up the alternate animation branch and plays the withdrawal animation

	ld a, [wDeferredSwitch]
	and a
	ret z

	; Don't play the anim if battle effects are off, because this causes the
	; animation to play twice (here + the switch-out code) with nothing for
	; the actual Pursuit anim.
	call CheckBattleEffects
	ret c

	ld a, 1
	ld [wBattleAnimParam], a
	call StackCallOpponentTurn
.Function:
	ld de, ANIM_RETURN_MON
	farjp PlayBattleAnimDE
