BattleCommand_perishsong:
	; Track if we have afflicted anyone with Perish.
	; Bit 7 unset: Afflicted someone
	; Bit 0 unset: Soundproof immunity (suppresses normal fail msg)
	ld d, -1

	; Check if opponent Soundproof immunity applies
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_PERISH, [hl]
	jr nz, .not_soundproof
	call GetOpponentAbilityAfterMoldBreaker
	cp SOUNDPROOF
	jr nz, .not_soundproof

	; Otherwise, notify about soundproof immunity
	dec d ; unset bit 0
	push de
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farcall EnableAnimations
	pop de
	jr .afflict_user

.not_soundproof
	call SwitchTurn
	call .Afflict
	call SwitchTurn
.afflict_user
	call .Afflict

	inc d
	jr z, .failed ; no unset bits

	call AnimateCurrentMove
	ld hl, StartPerishText
	jp StdBattleTextbox

.Afflict:
	; Possibly afflict user with Perish Song.
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	bit SUBSTATUS_PERISH, [hl]
	ret nz
	set SUBSTATUS_PERISH, [hl]
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerPerishCount
	jr z, .got_user_perish
	ld hl, wEnemyPerishCount
.got_user_perish
	ld [hl], 4
	res 7, d
	ret

.failed
	call AnimateFailedMove
	jp PrintButItFailed
