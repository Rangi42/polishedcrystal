BattleCommand_skillswap:
; Does not work if either side has no Ability.
	call CheckHiddenOpponent
	jr nz, .failed

	ld a, [wPlayerAbility]
	ld b, a
	call AbilityCanBeSwapped
	jr nz, .failed
	ld a, [wEnemyAbility]
	ld c, a
	call AbilityCanBeSwapped
	jr nz, .failed

	push bc
	call AnimateCurrentMove

	; Show the abilities being swapped.
	farcall DisplayAbilitySwap

	; Perform the actual ability swap.
	pop bc
	ld a, b
	ld [wEnemyAbility], a
	ld a, c
	ld [wPlayerAbility], a

	; Reset variables related to abilities
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_UNBURDEN, [hl]
	res SUBSTATUS_FLASH_FIRE, [hl]
	ld hl, wEnemySubStatus1
	res SUBSTATUS_UNBURDEN, [hl]
	res SUBSTATUS_FLASH_FIRE, [hl]
	xor a
	ld [wPlayerCudChewBerry], a
	ld [wEnemyCudChewBerry], a

	; Don't use RunBothEntryAbilities, because
	; Skill Swap always runs the user first
	farcall RunEntryAbilitiesInner_SkillSwap
	call SwitchTurn
	farcall RunEntryAbilitiesInner_SkillSwap
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
