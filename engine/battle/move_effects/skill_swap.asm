BattleCommand_skillswap:
; Does not work if either side has no Ability.
	call CheckHiddenOpponent
	jr nz, .failed

	ld a, [wPlayerAbility]
	inc a
	jr z, .failed
	dec a
	jr z, .failed
	ld b, a
	ld a, [wEnemyAbility]
	inc a
	jr z, .failed
	dec a
	jr z, .failed
	ld [wPlayerAbility], a
	ld a, b
	ld [wEnemyAbility], a

	call AnimateCurrentMove

	ld hl, SwappedAbilitiesText
	call StdBattleTextbox

	; Don't use RunBothActivationAbilities, because
	; Skill Swap always runs the user first
	farcall RunActivationAbilitiesInner
	call SwitchTurn
	farcall RunActivationAbilitiesInner
	jp SwitchTurn

.failed
	call AnimateFailedMove
	jp PrintButItFailed
