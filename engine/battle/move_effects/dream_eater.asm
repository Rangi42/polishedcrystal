BattleCommand_eatdream:
	call SapHealth
	ld hl, DreamEatenText
	jp StdBattleTextBox
