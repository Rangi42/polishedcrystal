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

	; Don't use RunBothActivationAbilities, because
	; Skill Swap always runs the user first
	farcall RunActivationAbilitiesInner
	call SwitchTurn
	farcall RunActivationAbilitiesInner
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed

SkillSwapExcepts:
	db NO_ABILITY
	db NEUTRALIZING_GAS
	db -1
