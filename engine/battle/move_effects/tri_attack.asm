BattleCommand_tristatuschance:
	call BattleCommand_effectchance

; 1/3 chance of each status
.loop
	call BattleRandom
	swap a
	and %11
	jr z, .loop
; jump
	dec a
	call StackJumpTable

.Jumptable:
	dw BattleCommand_paralyzetarget ; paralyze
	dw BattleCommand_freezetarget ; freeze
	dw BattleCommand_burntarget ; burn
