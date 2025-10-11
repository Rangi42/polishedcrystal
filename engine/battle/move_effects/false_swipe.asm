BattleCommand_falseswipe:
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld de, wCurDamage
	ld c, 2
	push hl
	push de
	call StringCmp
	pop de
	pop hl
	jr c, .done
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	dec a
	ld [de], a
	inc a
	jr nz, .okay
	dec de
	ld a, [de]
	dec a
	ld [de], a
.okay
	scf
	ret

.done
	and a
	ret
