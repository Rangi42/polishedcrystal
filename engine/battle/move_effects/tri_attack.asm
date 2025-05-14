BattleCommand_tristatuschance:
	ld a, 3
	call BattleRandomRange
	call StackJumpTable

.Jumptable:
	dw BattleCommand_paralyzetarget ; paralyze
	dw BattleCommand_freezetarget ; freeze
	dw BurnTarget ; burn, no defrosting
