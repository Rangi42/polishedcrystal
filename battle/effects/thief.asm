BattleCommand_Thief: ; 37492
; thief

; Can't steal during link battles.
	ld a, [wLinkMode]
	and a
	ret nz

; The enemy can't steal items.
	ld a, [hBattleTurn]
	and a
	ret nz

; The player needs to be able to steal an item.
	ld a, [BattleMonItem]
	and a
	ret nz

; The enemy needs to have an item to steal.
	ld a, [EnemyMonItem]
	and a
	ret z

; Can't steal mail.
	ld [wd265], a
	ld d, a
	farcall ItemIsMail
	ret c

; Sticky Hold prevents item theft.
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

; effectchance may prevent theft.
	ld a, [EffectFailed]
	and a
	ret nz

; Take item from enemy.
	ld a, MON_ITEM
	call OTPartyAttr
	xor a
	ld [hl], a
	ld [EnemyMonItem], a

; Give item to player.
	ld a, MON_ITEM
	call BattlePartyAttr
	ld a, [wd265]
	ld [hl], a
	ld [BattleMonItem], a

	call GetItemName
	ld hl, StoleText
	jp StdBattleTextBox

; 37517
