BattleCommand_metronome:
	call ClearLastMove
	call CheckUserIsCharging
	jr nz, .asm_3742b

	ld a, [wKickCounter]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wKickCounter], a

.asm_3742b
	call LoadMoveAnim

.GetMove:
	call BattleRandom
	cp STRUGGLE
	jr z, .GetMove

; None of the moves in MetronomeExcepts.
	push af
	ld hl, MetronomeExcepts
	call IsInByteArray
	pop bc
	jr c, .GetMove

; No moves the user already has.
	ld a, b
	call CheckUserMove
	jr z, .GetMove

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], b
	call UpdateMoveData
	jp ResetTurn

INCLUDE "data/moves/metronome_exception_moves.asm"
