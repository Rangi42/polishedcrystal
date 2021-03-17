BattleCommand_attract:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	call CheckOppositeGender
	jr c, .failed
	jr z, .failed
	call CheckHiddenOpponent
	jr nz, .failed
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOVE, [hl]
	jr nz, .failed
	call GetOpponentAbilityAfterMoldBreaker
	cp OBLIVIOUS
	jr nz, .no_ability_protection

	; don't display anything in case we're in cute charm
	ld a, [wAnimationsDisabled]
	and a
	ret nz

	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farjp EnableAnimations

.failed
	; don't display anything in case we're in cute charm
	ld a, [wAnimationsDisabled]
	and a
	ret nz

	jp FailAttract

.no_ability_protection
	; maybe this was called by cute charm
	call ShowPotentialAbilityActivation
	set SUBSTATUS_IN_LOVE, [hl]
	call AnimateCurrentMove

	ld hl, FellInLoveText
	call StdBattleTextbox

	; Check Destiny Knot
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_DESTINY_KNOT
	jr nz, .destiny_knot_done

	call GetTrueUserAbility
	cp OBLIVIOUS
	jr nz, .no_user_ability_protection

	ld b, a
	push bc
	; put ability in buffer 1, item in buffer 2
	call GetCurItemName

	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	pop bc
	farcall BufferAbility
	ld hl, ObliviousPreventedDestinyKnot
	call StdBattleTextbox
	jr .destiny_knot_done

.no_user_ability_protection
	call GetCurItemName
	ld hl, DestinyKnotInfatuatedUser
	call StdBattleTextbox
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_IN_LOVE, [hl]

.destiny_knot_done
	; Speed check to see whose side is cured first, in case both
	; got infatuated
	ldh a, [hBattleTurn]
	push af
	call SetPlayerTurn
	call CheckSpeed
	call nz, SetEnemyTurn
	call .do_it
	call SwitchTurn
	call .do_it
	pop af
	ldh [hBattleTurn], a
	ret

.do_it
	call CheckMentalHerb
	farjp RunStatusHealAbilities

CheckOpponentMentalHerb:
	call CallOpponentTurn
CheckMentalHerb:
	; Check if we hold it
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_MENTAL_HERB
	ret nz

	; Keep track of if we're healing stuff in b
	ld b, 0

	; Check infatuation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOVE, [hl]
	jr z, .infatuation_done
	res SUBSTATUS_IN_LOVE, [hl]
	set 0, b

.infatuation_done
	; Check Encore
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerEncoreCount
	jr z, .got_encorecount
	ld hl, wEnemyEncoreCount
.got_encorecount
	ld a, [hl]
	and $f
	jr z, .encore_done
	set 1, b
	ld a, [hl]
	and $f0
	ld [hl], a

.encore_done
	; Check Disable
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerDisableCount
	jr z, .got_disable_vars
	ld hl, wEnemyDisableCount
.got_disable_vars
	ld a, [hl]
	and a
	jr z, .disable_done
	set 2, b
	ld [hl], 0

.disable_done
	ld a, b
	and a
	ret z

	; We healed something, so consume the item
	push bc
	farcall ItemRecoveryAnim
	call GetUserItem
	call GetCurItemName

	pop bc
	bit 0, b
	ld hl, CuredInfatuationWithItem
	call nz, .print
	bit 1, b
	ld hl, CuredEncoreWithItem
	call nz, .print
	bit 2, b
	ld hl, CuredDisableWithItem
	call nz, .print

	jp ConsumeUserItem

.print
	push bc
	call StdBattleTextbox
	pop bc
	ret

CheckOppositeGender:
; Returns c (either mon is genderless), nc|z (same gender), nc|nz (opposite gender).
; Don't remove the possibility to check for same gender, Rivalry needs this.
	ld a, MON_SPECIES
	call TrueUserPartyAttr
	ld [wCurPartySpecies], a
	ld a, MON_GENDER
	call TrueUserPartyAttr
	ld [wTempMonGender], a
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	ret c ; User mon is genderless

	ld b, 1
	jr nz, .got_gender
	dec b

.got_gender
	push bc
	ld a, MON_SPECIES
	call OpponentPartyAttr
	ld [wCurPartySpecies], a
	ld a, MON_GENDER
	call OpponentPartyAttr
	ld [wTempMonGender], a
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	pop bc
	ret c ; Opponent mon is genderless

	ld a, 1
	jr nz, .got_enemy_gender
	dec a

.got_enemy_gender
	xor b
	ret
