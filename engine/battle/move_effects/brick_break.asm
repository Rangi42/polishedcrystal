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
	ld [hl], 0
	push af
	and SCREENS_REFLECT
	jr z, .reflect_done
	ld hl, BrokeReflectText
	call StdBattleTextbox
.reflect_done
	pop af
	and SCREENS_LIGHT_SCREEN
	ret z
	ld hl, BrokeLightScreenText
	jmp StdBattleTextbox
