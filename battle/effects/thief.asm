BattleCommand_Thief:
	; Maybe Substitute/Sheer Force prevents the steal
	ld a, [EffectFailed]
	and a
	ret nz

	; Sticky Hold prevents item theft.
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonItem
	ld bc, EnemyMonItem
	jr z, .got_target
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
	ret z

	; Mail can't be stolen
	ld d, a
	push bc
	push de
	farcall ItemIsMail
	pop de
	pop bc
	ret c

	; Steal item
	ld [hl], d
	xor a
	ld [bc], a

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
