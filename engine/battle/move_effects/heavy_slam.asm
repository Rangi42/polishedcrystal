BattleCommand_heavyslam:
	farcall GetUserWeight
	push hl
	farcall GetOpponentWeight
	pop de
	ld b, h
	ld c, l
	xor a
.loop
	inc a
	cp a, 10
	jr nc, .got_ratio
	add hl, bc
	; compare weights
	push bc
	ld b, a
	ld a, h
	cp a, d
	jr nz, .got_comparison
	ld a, l
	cp a, e
.got_comparison
	ld a, b
	pop bc
	jr z, .loop
	jr c, .loop

.got_ratio
	dec a
	ld c, 40 ; >= 50%
	jr z, .got_power
	dec a
	ld c, 60 ; (33.33%..50%]
	jr z, .got_power
	dec a
	ld c, 80 ; (25%..33.33%]
	jr z, .got_power
	dec a
	ld c, 100 ; (20%..25%]
	jr z, .got_power
	ld c, 120 ; <= 20%
.got_power
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld [hl], c
	ret
