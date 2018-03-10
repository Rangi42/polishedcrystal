BattleCommand_Metronome: ; 37418
; metronome

	call ClearLastMove
	call CheckUserIsCharging
	jr nz, .asm_3742b

	ld a, [wKickCounter]
	push af
	call BattleCommand_LowerSub
	pop af
	ld [wKickCounter], a

.asm_3742b
	call LoadMoveAnim

.GetMove:
	call BattleRandom

; None of the moves in MetronomeExcepts.
	push af
	ld de, 1
	ld hl, MetronomeExcepts
	call IsInArray
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
; 37454


MetronomeExcepts: ; 37454
	db NO_MOVE
	db COUNTER
	db DESTINY_BOND
	db ENDURE
	db METRONOME
	db MIRROR_COAT
	db PROTECT
	db SKETCH
	db SLEEP_TALK
	db THIEF
	db TRANSFORM
	db STRUGGLE
	db -1
; 37462
