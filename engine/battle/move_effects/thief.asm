BattleCommand_thief:
	; Pickpocket uses this too
	call CanStealItem
	jr z, .ok
	ret nc
	; Can't due to an ability. Maybe do ability display.

	call CheckStickyHold
	ret nz

.ok
	; Steal item
	ld [hl], d
	xor a
	ld [bc], a
	ld a, d
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, StoleText
	call StdBattleTextbox

	; Update parties
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld a, [wBattleMonItem]
	ld [hl], a
	ld b, a

	; Update backup item if we stole from wildmon
	ld a, [wBattleMode]
	dec a
	call z, SetBackupItem

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Item
	call GetPartyLocation
	ld a, [wEnemyMonItem]
	ld [hl], a
	ret

CheckStickyHold:
; Returns nz if opponent Sticky Hold is in effect.
	call HasOpponentFainted
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr nz, .no_sticky_hold

	; Don't display anything if we're in Pickpocket
	ld a, [wAnimationsDisabled]
	and a
	ret nz

	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, ItemCantBeStolenText
	call StdBattleTextbox
	farcall EnableAnimations
	or 1
	ret

.no_sticky_hold
	xor a
	ret

CanStealItem:
; Returns z if we can and put item into d, target item addr into bc,
; user item addr into hl. Returns nz if we can't, and c if we can't
; because of an ability.
	; Maybe Substitute/Sheer Force prevents the steal
	ld a, [wEffectFailed]
	and a
	ret nz

	; Sticky Hold prevents item theft
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .cant_ability

	call OpponentCanLoseItem
	jr z, .cant

	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonItem
	ld bc, wEnemyMonItem
	jr z, .got_target

	; Wildmons can't steal items
	ld a, [wBattleMode]
	dec a
	jr z, .cant

	ld hl, wEnemyMonItem
	ld bc, wBattleMonItem
.got_target
	; Check if user is holding an item already
	ld a, [bc]
	ld d, a
	ld a, [hl]
	and a
	ret

.cant_ability
	or 1
	scf
	ret

.cant
	or 1
	ret
