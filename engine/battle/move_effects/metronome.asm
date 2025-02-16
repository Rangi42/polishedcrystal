BattleCommand_metronome:
	call ClearLastMove
	call CheckUserIsCharging
	jr nz, .charging

	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wBattleAnimParam], a

.charging
	call LoadMoveAnim

.GetMove:
	call ChooseRandomMove

; None of the moves in MetronomeExcepts.
	ld de, 2
	ld hl, MetronomeExcepts
	call IsInWordArray
	jr c, .GetMove
	ld h, b
	ld l, c
	call GetMoveIDFromIndex

; No moves the user already has.
	ld b, a
	call CheckUserMove
	jr z, .GetMove

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], b
	call UpdateMoveData
	jmp ResetTurn

ChooseRandomMove:
	; chooses a random valid move and returns it in bc
	call BattleRandom
	if HIGH(NUM_ATTACKS)
		maskbits HIGH(NUM_ATTACKS) + 1
		if HIGH(NUM_ATTACKS) & (HIGH(NUM_ATTACKS) + 1)
			; if HIGH(NUM_ATTACKS) is not one less than a power of two
			cp HIGH(NUM_ATTACKS) + 1
			jr nc, ChooseRandomMove
		endc
		ld b, a
		call BattleRandom
		ld c, a
		or b
		jr z, ChooseRandomMove
		if LOW(NUM_ATTACKS) != $ff
			ld a, b
			cp HIGH(NUM_ATTACKS)
			ret nz
			ld a, c
			cp LOW(NUM_ATTACKS) + 1
			jr nc, ChooseRandomMove
		endc
	else
		cp NUM_ATTACKS
		jr nc, ChooseRandomMove
		inc a
		ld c, a
		ld b, 0
	endc
	ret

INCLUDE "data/moves/metronome_exception_moves.asm"
