BattleCommand_knockoff:
	call ReadMoveScriptByte
	ld b, a
	ld a, [wAttackMissed]
	and a
	ret nz

	call CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	push bc
	call CheckStickyHold
	pop bc
	ret nz

	push bc
	call OpponentCanLoseItem
	pop bc
	ret z

	call CheckPendingItemLoss
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

CheckPendingItemLoss:
; Check if we should perform the action, or if we should just set it to pending.
	ld a, b
	and a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	set SUBSTATUS_PENDING_ITEMLOSS, [hl]
	xor a
	ret
