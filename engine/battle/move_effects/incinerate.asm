BattleCommand_incinerate:
	farcall ReadMoveScriptByte
	ld b, a
	ld a, [wAttackMissed]
	and a
	ret nz

	farcall CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	push bc
	farcall CheckStickyHold
	pop bc
	ret nz

	push bc
	call OpponentCanLoseItem
	pop bc
	ret z

	farcall GetOpponentItem
	push hl
	; Incinerate also destroys gems, but there are none in polished
	farcall IsItemBerry
	pop hl
	ret nz

	push hl
	farcall CheckPendingItemLoss
	pop hl
	ret z

	xor a
	ld [hl], a
	call GetCurItemName
	ld hl, IncineratedItemText
	call StdBattleTextbox
	ld a, MON_ITEM
	call OpponentPartyAttr
	ret z
	xor a
	ld [hl], a
	ret
