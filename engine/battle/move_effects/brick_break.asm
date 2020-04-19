BattleCommand_brickbreak:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
    ld a, [hl]
	and a
	ret z
	push af
	and SCREENS_REFLECT
	jr z, .reflect_done
	push hl
	ld hl, BrokeReflectText
	call StdBattleTextBox
	pop hl
.reflect_done
	pop af
	and SCREENS_LIGHT_SCREEN
	ld a, 0 ; zero flag needs to be preserved
	ld [hl], a
	ret z
	ld hl, BrokeReflectText
	jp StdBattleTextBox
