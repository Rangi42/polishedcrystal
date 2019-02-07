BattleCommand_Thief:
	; Pickpocket uses this too
	call CanStealItem
	ret nz

	; Steal item
	ld [hl], d
	xor a
	ld [bc], a
	ld a, d
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, StoleText
	call StdBattleTextBox

	; Update parties
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld a, [wBattleMonItem]
	ld [hl], a
	ld b, a

	; Wilds don't have a party struct, but update backup item for them if we stole it
	ld a, [wBattleMode]
	dec a
	jp z, SetBackupItem

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Item
	call GetPartyLocation
	ld a, [wEnemyMonItem]
	ld [hl], a
	ret

CanStealItem:
; Returns z if we can and put item into d, target item addr into bc, user item addr into hl
	; Maybe Substitute/Sheer Force prevents the steal
	ld a, [wEffectFailed]
	and a
	ret nz

	; Sticky Hold prevents item theft
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .cant

	call OpponentCanLoseItem
	jr z, .cant

	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonItem
	ld bc, wEnemyMonItem
	jr z, .got_target

	; Wildmons can't steal items
	ld a, [wBattleMode]
	dec a
	ret z

	ld hl, wEnemyMonItem
	ld bc, wBattleMonItem
.got_target
	; Check if user is holding an item already
	ld a, [hl]
	and a
	ret

.cant
	or 1
	ret
