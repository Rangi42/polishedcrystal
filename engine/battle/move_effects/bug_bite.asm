BattleCommand_bugbite:
	; these abilities prevent us from eating it
	call GetOpponentAbilityAfterMoldBreaker
	cp UNNERVE
	ret z
	call CheckStickyHold
	ret nz

	; these held item effects prevent us from eating it
	call GetOpponentItem
	ld a, b
	cp HELD_NO_BUG_BITE
	ret z

	; does the opponent even have a berry? DON'T check EdibleBerries,
	; there are non-edible ones which we'll still eat (with no effect)
	call GetOpponentItem
	ld a, [hl]
	ld [wCurItem], a
	push bc
	push hl
	farcall CheckItemPocket
	pop hl
	pop bc
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	ret nz

	; OK, we will eat the berry. Done by reusing item effect functions,
	; and if the opponent still has an item, eating it with no effect
	farcall StealConfusionHealingItem
	farcall StealHeldStatusHealingItem
	farcall StealHPHealingItem ; also Enigma Berry
	farcall StealStatBoostBerry ; also Lansat Berry
	farcall StealDefendHitBerry
	farcall StealLeppaBerry

	; check if the opponent still has a berry
	call GetOpponentItem
	ld a, [hl]
	and a
	ret z
	farcall ItemRecoveryAnim
	call GetCurItemName
	ld hl, BattleText_UserAteItem
	call StdBattleTextbox
	call ConsumeOpponentItem
	ld hl, NothingHappenedText
	jp StdBattleTextbox
