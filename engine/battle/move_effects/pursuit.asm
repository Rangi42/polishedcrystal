BattleCommand_pursuit:
; Sets up the alternate animation branch and plays the withdrawal animation

	ld a, [wDeferredSwitch]
	and a
	ret z

	ld a, 1
	ld [wBattleAnimParam], a
	call StackCallOpponentTurn
.Function:
	ld de, ANIM_RETURN_MON
	farjp PlayBattleAnimDE
