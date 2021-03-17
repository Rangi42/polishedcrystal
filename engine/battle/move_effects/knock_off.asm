BattleCommand_knockoff:
	ld a, [wAttackMissed]
	and a
	ret nz

	; Maybe Substitute/Sheer Force prevents the steal
	call CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	call CheckStickyHold
	ret nz

	call OpponentCanLoseItem
	ret z

	call GetOpponentItem
	xor a
	ld [hl], a
	call GetCurItemName
	ld hl, KnockedOffItemText
	call StdBattleTextbox
	ld a, MON_ITEM
	call OpponentPartyAttr
	ret z
	xor a
	ld [hl], a
	ret
