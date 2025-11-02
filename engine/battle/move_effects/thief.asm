BattleCommand_thief:
	; Substitute prevents this move from working.
	call CheckSubstituteOpp
	ret nz

	; Pickpocket uses this too
	call CanStealItem
	jr z, .ok
	ret nc
	; Can't due to an ability. Maybe do ability display.

	call CheckStickyHold
	ret nz

.ok
	; Steal item
	push bc
	ld c, d
	call ReceiveBattleItem
	pop bc
	ret nc

	xor a
	ld [bc], a
	farcall ShowPotentialAbilityActivation
	ld a, d
	ld [wNamedObjectIndex], a
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

ReceiveBattleItem:
; This will either give the current battler an item, or put it in our bag.
; If we are already holding an item, and our bag is full, return noncarry.
; Otherwise, return carry.
; Inputs: [hl] is battler's item address, c is item to give.
	; Are we holding an item currently?
	ld a, [hl]
	and a
	ld a, c
	jr nz, .holding_item
	ld [hl], c
	scf
	ret

.holding_item
	; If we are already holding an item, check if we have room in the bag.
	; If we don't, abort the ability activation.
	push hl
	push de
	push bc
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	pop bc
	pop de
	pop hl
	ret

CheckStickyHold:
; Returns nz if opponent Sticky Hold is in effect.
	call HasOpponentFainted
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr nz, .no_sticky_hold

	; Don't display anything if we're in Pickpocket
	ld a, [wInAbility]
	and a
	ret nz

	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	ld hl, ItemCantBeStolenText
	call StdBattleTextbox
	farcall EndAbility
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

	; Sticky Hold prevents item theft unless fainted
	call HasOpponentFainted
	jr z, .sticky_hold_done
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .cant_ability

.sticky_hold_done
	call OpponentCanLoseItem
	jr z, .cant

	; For wildmon battles, players can steal item even if they already hold
	; one, while the wildmon can never steal items.
	ld hl, wBattleMode
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	ld hl, wBattleMonItem
	ld bc, wEnemyMonItem
	jr nz, .foe

	; If we're battling a wildmon, the player can always steal items.
	; A later check (ReceiveBattleItem) is done for a full bag.
	dec a
	ld a, [bc]
	ld d, a
	ret z

	; Otherwise, check if we're already holding an item.
	jr .got_target
.foe
	; A wildmon can never steal items.
	dec a
	jr z, .cant

	; Swap item source and target since the enemy is the one stealing an item.
	push hl
	ld h, b
	ld l, c
	pop bc
.got_target
	; Check if the user is holding an item already.
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
