BattleCommand_Thief: ; 37492
; thief

; The enemy can't steal items.

	ld a, [hBattleTurn]
	and a
	ret nz

; The player needs to be able to steal an item.

	call .playeritem
	ld a, [hl]
	and a
	ret nz

; Sticky Hold prevents item theft.

	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

; The enemy needs to have an item to steal.

	call .enemyitem
	ld a, [hl]
	and a
	ret z

; Can't steal mail.

	ld [wd265], a
	ld d, a
	farcall ItemIsMail
	ret c

	ld a, [EffectFailed]
	and a
	ret nz

	ld a, [wLinkMode]
	and a
	jr z, .stealenemyitem

	ld a, [wBattleMode]
	dec a
	ret z

.stealenemyitem
	call .enemyitem
	xor a
	ld [hl], a
	ld [de], a

	call .playeritem
	ld a, [wd265]
	ld [hl], a
	ld [de], a

	call GetItemName
	ld hl, StoleText
	jp StdBattleTextBox


.playeritem
	ld a, MON_ITEM
	call BattlePartyAttr
	ld d, h
	ld e, l
	ld hl, BattleMonItem
	ret

.enemyitem
	ld a, MON_ITEM
	call OTPartyAttr
	ld d, h
	ld e, l
	ld hl, EnemyMonItem
	ret
; 37517
