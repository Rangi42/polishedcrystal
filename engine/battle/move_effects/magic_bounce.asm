BattleCommand_bounceback:
; Possibly bounce back an attack with Magic Bounce
	call GetOpponentAbilityAfterMoldBreaker
	cp MAGIC_BOUNCE
	ret nz

	; Someone behind Protect will not bounceback
	ld a, [wAttackMissed]
	cp ATKFAIL_PROTECT
	ret z

	; Some moves bypass Substitute
	ld hl, SubstituteBypassMoves
	call IsInByteArray
	jr c, .sub_ok

	; Otherwise, Substitute blocks it
	call CheckSubstituteOpp
	ret nz

.sub_ok
	; No infinite bouncing
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ret nz

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	push bc
	call SwitchTurn

	; Store old move and replace with the bounced move
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld a, [hl]
	pop bc
	ld [hl], b
	push af

	push bc
	farcall BeginAbility
	farcall ShowAbilityActivation
	pop bc
	ld a, b
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, BouncedBackText
	call StdBattleTextbox
	farcall EndAbility

	; Flag the bouncing
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_IN_ABILITY, [hl]

	; Invert who went first
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	call InvertDeferredSwitch

	; Do the move
	call UpdateMoveData
	call BattleCommand_lowersub
	call ResetTurn

	; Restore old data
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	call InvertDeferredSwitch

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	call UpdateMoveData
	jmp SwitchTurn

INCLUDE "data/moves/substitute_bypass_moves.asm"
