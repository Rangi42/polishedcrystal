BattleCommand_screen:
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount

.got_screens_pointer
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LIGHT_SCREEN
	jr nz, .reflect

	bit SCREENS_LIGHT_SCREEN, [hl]
	jr nz, .failed
	set SCREENS_LIGHT_SCREEN, [hl]
	ld hl, LightScreenEffectText
	jr .set_timer
.reflect
	bit SCREENS_REFLECT, [hl]
	jr nz, .failed
	set SCREENS_REFLECT, [hl]
	inc bc ; LightScreenCount -> ReflectCount
	ld hl, ReflectEffectText
.set_timer
	ld a, HELD_PROLONG_SCREENS
	call GetItemBoostedDuration
	ld [bc], a
	call AnimateCurrentMove
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
