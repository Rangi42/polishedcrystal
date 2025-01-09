BattleCommand_skillswap:
; Does not work if either side has no Ability.
	call CheckHiddenOpponent
	jr nz, .failed

	ld a, [wPlayerAbility]
	push af
	ld hl, SkillSwapExcepts
	push hl
	call IsInByteArray
	pop hl
	pop bc
	jr c, .failed
	ld a, [wEnemyAbility]
	push bc
	push af
	call IsInByteArray
	pop de
	pop bc
	jr c, .failed

	ld a, b
	ld [wEnemyAbility], a
	ld a, d
	ld [wPlayerAbility], a

	call AnimateCurrentMove

	ld hl, SwappedAbilitiesText
	call StdBattleTextbox

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
	farcall RunEntryAbilitiesInner
	call SwitchTurn
	farcall RunEntryAbilitiesInner
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

SkillSwapExcepts:
	db NO_ABILITY
	db NEUTRALIZING_GAS
	db -1
