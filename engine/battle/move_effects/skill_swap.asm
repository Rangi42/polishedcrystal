BattleCommand_skillswap:
; Does not work if either side has no Ability.
	call CheckHiddenOpponent
	jr nz, .failed

	ld a, [wPlayerAbility]
	ld b, a
	call AbilityCanBeSkillSwapped
	jr c, .failed
	ld a, [wEnemyAbility]
	ld c, a
	call AbilityCanBeSkillSwapped
	jr c, .failed

	ld a, b
	ld [wEnemyAbility], a
	ld a, c
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
	farcall RunEntryAbilitiesInner_SkillSwap
	call SwitchTurn
	farcall RunEntryAbilitiesInner_SkillSwap
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

NoSkillSwapEntry:
	ld hl, NoSkillSwapEntryAbilities
	jr AbilityChangeCheck_IsInByteArray

AbilityCanBeSuppressed:
	ld hl, AbilitySuppressionExcepts
	jr AbilityChangeCheck_IsInByteArray

AbilityCanBeTraced:
	ld hl, TraceExcepts
	jr AbilityChangeCheck_IsInByteArray

AbilityCanBeSkillSwapped:
	ld hl, SkillSwapExcepts
	; fallthrough
AbilityChangeCheck_IsInByteArray:
; Returns carry if ability is part of a blacklist in hl.
	; Handle Neutralizing Gas sentinel (-1).
	add 1 ; no-optimize a++|a-- (sets carry)
	dec a ; doesn't mess with carry
	ret c

	; Otherwise, check the relevant array. Preserve non-flag registers.
	push hl
	push de
	push bc
	push af
	call IsInByteArray
	pop bc
	ld a, b
	jmp PopBCDEHL

TraceExcepts:
	db IMPOSTER
	db TRACE
	; fallthrough
SkillSwapExcepts:
	db NO_ABILITY
AbilitySuppressionExcepts:
	db NEUTRALIZING_GAS
	db -1

NoSkillSwapEntryAbilities:
	db IMPOSTER
	db CLOUD_NINE
	db -1
