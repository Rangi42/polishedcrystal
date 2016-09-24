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

; The enemy needs to have an item to steal.

	call .enemyitem
	ld a, [hl]
	and a
	ret z

; Sticky Hold prevents item theft.

	ld a, [EnemyAbility]
	cp STICKY_HOLD
	jr nz, .ability_ok
	; (except if the user has Mold Breaker)
	ld a, [PlayerAbility]
	cp MOLD_BREAKER
	ret nz

; Can't steal mail.

.ability_ok
	ld [wd265], a
	ld d, a
	callba ItemIsMail
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
	ld a, 1
	call BattlePartyAttr
	ld d, h
	ld e, l
	ld hl, BattleMonItem
	ret

.enemyitem
	ld a, 1
	call OTPartyAttr
	ld d, h
	ld e, l
	ld hl, EnemyMonItem
	ret
; 37517
