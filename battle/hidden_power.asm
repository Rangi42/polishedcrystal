HiddenPowerDamage: ; fbced
; Override Hidden Power's type based on the user's DVs.

	ld hl, wBattleMonDVs
	ld a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, wEnemyMonDVs
.got_dvs

	; (Atk & 3) << 2
	ld a, [hli]
	and 3
rept 2
	add a
endr
	ld b, a

	; + Def & 3
	ld a, [hl]
	and 3 << 4
	swap a
	or b

; Skip Normal
	inc a

.done

; Overwrite the current move type.
	push af
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	pop af
	ld [hl], a

; Get the rest of the damage formula variables
; based on the new type.
	push af
	farcall BattleCommand_DamageStats ; damagestats
	pop af
	ret
; fbd54
