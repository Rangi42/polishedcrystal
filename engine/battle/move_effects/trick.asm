BattleCommand_trick:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed

	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .ability_failed

	call UserCanLoseItem
	jr z, .failed
	call OpponentCanLoseItem
	jr z, .failed

	call AnimateCurrentMove

	call GetUserItem
	push hl
	call GetOpponentItem
	pop de

	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a

	ld hl, SwappedItemsText
	call StdBattleTextBox

	ld a, MON_ITEM
	call BattlePartyAttr
	ld a, [wBattleMonItem]
	ld [hl], a

	ld a, MON_ITEM
	call OTPartyAttr
	ret z
	ld a, [wEnemyMonItem]
	ld [hl], a
	ret

.ability_failed
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	call PrintDoesntAffect
	farjp EnableAnimations
.failed
	call AnimateFailedMove
	jp PrintButItFailed
