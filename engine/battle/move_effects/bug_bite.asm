BattleCommand_bugbite:
	call ReadMoveScriptByte
	ld b, a

	; these abilities prevent us from eating it
	call GetOpponentIgnorableAbility
	cp UNNERVE
	ret z
	push bc
	call CheckStickyHold
	pop bc
	ret nz

	; these held item effects prevent us from eating it
	push bc
	call GetOpponentItem
	ld a, b
	cp HELD_NO_BUG_BITE
	pop bc
	ret z

	; does the opponent even have a berry? DON'T check EdibleBerries,
	; there are non-edible ones which we'll still eat (with no effect)
	ld a, [hl]
	ld [wCurItem], a
	push bc
	farcall CheckItemPocket
	pop bc
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	ret nz

	call CheckPendingItemLoss
	ret z

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
	farcall BerryRecoveryAnim
	call GetCurItemName
	ld hl, BattleText_UserAteItem
	call StdBattleTextbox
	call ConsumeStolenOpponentItem
	ld hl, NothingHappenedText
	jmp StdBattleTextbox
