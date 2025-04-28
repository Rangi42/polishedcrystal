BattleCommand_endure:
; Endure shares code with Protect. See protect.asm.
	call ProtectChance
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_ENDURE, [hl]

	call AnimateCurrentMove

	ld hl, BracedItselfText
	jmp StdBattleTextbox
