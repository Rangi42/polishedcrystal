BattleCommand_bounceback:
; Possibly bounce back an attack with Magic Bounce, or don't do anything if opponent is
; immune due to Prankster.
	call GetTrueUserAbility
	cp PRANKSTER
	jr nz, .prankster_done
	call CheckIfTargetIsDarkType
	jr nz, .prankster_done
	xor a
	ld [wTypeMatchup], a
	ld [wTypeModifier], a
	ld hl, wAttackMissed
	or [hl]
	ret nz
	ld [hl], ATKFAIL_ABILITY
	ret

.prankster_done
	call GetOpponentAbilityAfterMoldBreaker
	cp MAGIC_BOUNCE
	ret nz

	; Someone behind Protect will not bounceback
	ld a, [wAttackMissed]
	cp 2
	ret z

	; Some moves bypass Substitute
	ld de, 1
	ld hl, SubstituteBypassMoves
	call IsInArray
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
	farcall DisableAnimations
	farcall ShowAbilityActivation
	pop bc
	ld a, b
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ld hl, BouncedBackText
	call StdBattleTextbox
	farcall EnableAnimations

	; Flag the bouncing
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_IN_ABILITY, [hl]

	; Invert who went first
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	; Do the move
	call UpdateMoveData
	call BattleCommand_lowersub
	call ResetTurn

	; Restore old data
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	call UpdateMoveData
	jp SwitchTurn
