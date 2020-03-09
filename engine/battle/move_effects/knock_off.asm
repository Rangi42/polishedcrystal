BattleCommand_knockoff:
	ld a, [wAttackMissed]
	and a
	ret nz

	; Maybe Substitute/Sheer Force prevents the steal
	call CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

	call OpponentCanLoseItem
	ret z

	call GetOpponentItem
	xor a
	ld [hl], a
	call GetCurItemName
	ld hl, KnockedOffItemText
	call StdBattleTextBox
	ld a, MON_ITEM
	call OpponentPartyAttr
	ret z
	xor a
	ld [hl], a
	ret
