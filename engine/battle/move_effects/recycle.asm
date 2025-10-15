BattleCommand_recycle:
	push de
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	jr nz, .failed
	ld d, h
	ld e, l

	call GetUsedItemAddr
	ld a, [hl]
	and a
	jr z, .failed
	; Pick up the item
	ld [de], a
	ld [wNamedObjectIndex], a
	ld b, a
	xor a
	ld [hl], a

	push bc
	call GetItemName
	ld hl, RecycledItemText
	call StdBattleTextbox
	pop bc

	ldh a, [hBattleTurn]
	and a
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Item
	jr z, .got_item_addr
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Item
.got_item_addr
	call GetPartyLocation
	ld [hl], b
	ret

.failed
	pop de
	farjp ButItFailed
