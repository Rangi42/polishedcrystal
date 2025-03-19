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
	farcall RunEntryAbilitiesInner
	call SwitchTurn
	farcall RunEntryAbilitiesInner
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

AbilityCanBeTraced:
	ld hl, TraceExcepts
	jr AbilityChangeCheck_IsInByteArray

AbilityCanBeSkillSwapped:
	ld hl, SkillSwapExcepts
	; fallthrough
AbilityChangeCheck_IsInByteArray:
; Returns carry if ability is part of a blacklist in hl.
	; Handle Neutralizing Gas sentinel (-1).
	add 1
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
	db NEUTRALIZING_GAS
	db -1
