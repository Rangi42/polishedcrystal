HiddenPowerDamage: ; fbced
; Override Hidden Power's type based on the user's DVs.

	ld hl, BattleMonDVs
	ld a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, EnemyMonDVs
.got_dvs

	; Def & 3
	ld a, [hl]
	and 3
	ld b, a

	; + (Atk & 3) << 2
	ld a, [hl]
	and 3 << 4
	swap a
rept 2
	add a
endr
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
	callba BattleCommand_DamageStats ; damagestats
	pop af
	ret
; fbd54
