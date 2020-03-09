BattleCommand_brickbreak:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount
	jr z, .got_screens
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
.got_screens
	bit SCREENS_LIGHT_SCREEN, [hl]
	jr z, .light_screen_done
	res SCREENS_LIGHT_SCREEN, [hl]
	xor a
	ld [bc], a
	push hl
	push bc
	ld hl, BrokeLightScreenText
	call StdBattleTextBox
	pop bc
	pop hl
.light_screen_done
	inc bc
	bit SCREENS_REFLECT, [hl]
	ret z
	res SCREENS_REFLECT, [hl]
	xor a
	ld [bc], a
	ld hl, BrokeReflectText
	jp StdBattleTextBox
