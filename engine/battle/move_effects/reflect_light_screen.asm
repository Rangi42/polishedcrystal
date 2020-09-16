BattleCommand_screen:
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens

.got_screens_pointer
	ld a, HELD_PROLONG_SCREENS
	call GetItemBoostedDuration
	ld b, a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LIGHT_SCREEN
	ld a, [hl]
	jr nz, .reflect

	and SCREENS_LIGHT_SCREEN
	jr nz, .failed
	ld a, b
	swap a
	or [hl]
	ld [hl], a
	ld hl, LightScreenEffectText
	jr .succeeded

.reflect
	and SCREENS_REFLECT
	jr nz, .failed
	ld a, b
	or [hl]
	ld [hl], a
	ld hl, ReflectEffectText
.succeeded
	call AnimateCurrentMove
	jp StdBattleTextbox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
