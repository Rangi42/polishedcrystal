CheckBattleEffects:
; Return carry if battle scene is turned off.
	ld a, [wOptions1]
	bit BATTLE_EFFECTS, a
	jr z, .off
	and a
	ret
.off
	scf
	ret
