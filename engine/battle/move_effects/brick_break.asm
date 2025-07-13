BattleCommand_brickbreak:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	ld de, wEnemyVeils
	jr z, .got_screens
	ld hl, wPlayerScreens
	ld de, wPlayerVeils
.got_screens
	ld b, [hl]
	ld a, [de]
	and VEILS_AURORA_VEIL
	ld c, a
	or b
	ret z
	xor a
	ld [hl], a
	ld [de], a
	
	ld a, b
	and SCREENS_REFLECT
	jr z, .reflect_done
	ld hl, BrokeReflectText
	call StdBattleTextbox
.reflect_done
	ld a, b
	and SCREENS_LIGHT_SCREEN
	jr z, .light_screen_done
	ld hl, BrokeLightScreenText
	call StdBattleTextbox
.light_screen_done
	ld a, c
	and VEILS_AURORA_VEIL
	ret z
	ld hl, BrokeAuroraVeilText
	jmp StdBattleTextbox
