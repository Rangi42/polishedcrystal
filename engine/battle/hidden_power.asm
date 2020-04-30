HiddenPowerDamageStats:
; Override Hidden Power's type based on the user's DVs.

	ld hl, wBattleMonDVs
	ldh a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, wEnemyMonDVs
.got_dvs

	call GetHiddenPowerType

; Overwrite the current move type.
	push af
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	pop af
	ld [hl], a

; Get the rest of the damage formula variables
; based on the new type.
	push af
	farcall BattleCommand_damagestats ; damagestats
	pop af
	ret

GetHiddenPowerType::
; return Hidden Power type in a from DVs at hl
	push de
	ld bc, 3
	ld de, 1
.loop
	ld a, [hli]
	swap a
	and %00010001
	srl a
	push af
	call c, .add_bit
	pop af
	sla e
	and a
	call nz, .add_bit
	sla e
	dec c
	jr nz, .loop
	; b = %00fedcba (SpD, SpA, Spe, Def, Atk, HP)
if DEF(FAITHFUL)
; type = %fedcba * 15 / 63 + 1 (1-16, Fighting-Dark)
	inc c
	ld e, c ; ld e, 1

.loop2
	ld d, 4
	dec c
	jr nz, .got_subtraction
	ld c, 5
	inc d
.got_subtraction
	ld a, b
	sub d
	jr c, .got_type
	ld b, a
	inc e
	jr .loop2
else
; type = %fedcba * 16 / 63 + 1 (1-17, Fighting-Fairy)
	ld a, b
	cp 63
	ld e, 17
	jr z, .got_type
	srl a
	srl a
	inc a
	ld e, a
endc

.got_type
	ld a, e
	pop de
	ret

.add_bit
	ld a, b
	or e
	ld b, a
	ret
