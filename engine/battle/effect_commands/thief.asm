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
	ld a, [CurBattleMon]
	ld hl, PartyMon1Item
	call GetPartyLocation
	ld a, [BattleMonItem]
	ld [hl], a
	ld b, a

	; Wilds don't have a party struct, but update backup item for them if we stole it
	ld a, [wBattleMode]
	dec a
	jp z, SetBackupItem

	ld a, [CurOTMon]
	ld hl, OTPartyMon1Item
	call GetPartyLocation
	ld a, [EnemyMonItem]
	ld [hl], a
	ret

CanStealItem:
; Returns z if we can and put item into d, target item addr into bc, user item addr into hl
	; Maybe Substitute/Sheer Force prevents the steal
	ld a, [EffectFailed]
	and a
	ret nz

	; Sticky Hold prevents item theft
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .cant

	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonItem
	ld bc, EnemyMonItem
	jr z, .got_target

	; Wildmons can't steal items
	ld a, [wBattleMode]
	dec a
	ret z

	ld hl, EnemyMonItem
	ld bc, BattleMonItem
.got_target
	; Check if user is holding an item already
	ld a, [hl]
	and a
	ret nz

	; Check if target has an item to steal
	ld a, [bc]
	and a
	jr z, .cant

	; Armor Suit can't be stolen
	cp ARMOR_SUIT
	jr z, .cant

	; Mail can't be stolen
	ld d, a
	push bc
	push de
	push hl
	farcall ItemIsMail
	pop hl
	pop de
	pop bc
	jr c, .cant
	xor a
	ret

.cant
	or 1
	ret
