BattleCommand_pursuit:
; Double damage if the opponent is switching.

	ld a, [wDeferredSwitch]
	and a
	ret z

	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret
