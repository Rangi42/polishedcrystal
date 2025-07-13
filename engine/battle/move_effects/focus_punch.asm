BattleCommand_focuspunch:
	ld a, 1 << PHYSICAL | 1 << SPECIAL
	farcall HasOpponentDamagedUs
	ret z

	ld hl, LostFocusText
	call StdBattleTextbox
	farjp EndMoveEffect
