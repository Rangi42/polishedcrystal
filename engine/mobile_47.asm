Function11d0b6: ; 11d0b6 (47:50b6)
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]

.Jumptable:
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw .six
	dw .seven
	dw .eight
	dw .nine
	dw .ten

.zero ; 11d0dd (47:50dd)
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	sla a
	ld hl, Unknown_11d208_zero
	ld e, $1
	jr .load

.one ; 11d0e9 (47:50e9)
	ld a, [wcd21]
	sla a
	ld hl, Unknown_11d21a_one
	ld e, $2
	jr .load

.two ; 11d0f5 (47:50f5)
	ld hl, Unknown_11d2be_two_a
	ld a, [wcd22]
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hl]
	call ReinitSpriteAnimFrame
	ld a, [wcd22]
	sla a
	ld hl, Unknown_11d23e_two_b
	ld e, $4
	jr .load

.three ; 11d10f (47:510f)
	ld a, SPRITE_ANIM_FRAMESET_27
	call ReinitSpriteAnimFrame
	ld a, [wcd25]
	sla a
	ld hl, Unknown_11d29e_three
	ld e, $8
.load ; 11d11e (47:511e)
	push de
	ld e, a
	ld d, $0
	add hl, de
	push hl
	pop de
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	pop de
	ld a, e
	call Function11d2ee
	ret

.four ; 11d134 (47:5134)
	ld a, SPRITE_ANIM_FRAMESET_27
	call ReinitSpriteAnimFrame
	ld a, [wcd2a]
	sla a
	ld hl, Unknown_11d2b6_four
	ld e, $10
	jr .load

.five ; 11d145 (47:5145)
	ld a, SPRITE_ANIM_FRAMESET_27
	call ReinitSpriteAnimFrame
	ld a, [wcd2c]
	sla a
	ld hl, Unknown_11d2ba_five
	ld e, $20
	jr .load

.six ; 11d156 (47:5156)
	ld a, SPRITE_ANIM_FRAMESET_2A
	call ReinitSpriteAnimFrame
	ld a, [wcd4a]
	sla a
	sla a
	sla a
	add $18
	ld hl, $4
	add hl, bc
	ld [hli], a
	ld a, $30
	ld [hl], a
	ld a, $1
	ld e, a
	call Function11d2ee
	ret

.seven ; 11d175 (47:5175)
	ld a, [wcd4d]
	cp $4
	jr z, .asm_11d180
	ld a, SPRITE_ANIM_FRAMESET_28
	jr .asm_11d182
.asm_11d180
	ld a, SPRITE_ANIM_FRAMESET_26
.asm_11d182
	call ReinitSpriteAnimFrame
	ld a, [wcd4d]
	cp $4
	jr z, .asm_11d1b1
	ld a, [wcd4c]
	sla a
	sla a
	sla a
	add $20
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hli], a
	ld a, [wcd4d]
	sla a
	sla a
	sla a
	sla a
	add $48
	ld [hl], a
	ld a, $2
	ld e, a
	call Function11d2ee
	ret

.asm_11d1b1
	ld a, [wcd4c]
	sla a
	sla a
	sla a
	ld e, a
	sla a
	sla a
	add e
	add $18
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hli], a
	ld a, $8a
	ld [hl], a
	ld a, $2
	ld e, a
	call Function11d2ee
	ret

.nine ; 11d1d1 (47:51d1)
	ld d, -13 * 8
	ld a, SPRITE_ANIM_FRAMESET_2C
	jr .eight_nine_load

.eight ; 11d1d7 (47:51d7)
	ld d, 2 * 8
	ld a, SPRITE_ANIM_FRAMESET_2B
.eight_nine_load ; 11d1db (47:51db)
	push de
	call ReinitSpriteAnimFrame
	ld a, [wcd4a]
	sla a
	sla a
	sla a
	ld e, a
	sla a
	add e
	add 8 * 8
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hld], a
	pop af
	ld [hl], a
	ld a, $4
	ld e, a
	call Function11d2ee
	ret

.ten ; 11d1fc (47:51fc)
	ld a, SPRITE_ANIM_FRAMESET_26
	call ReinitSpriteAnimFrame
	ld a, $8
	ld e, a
	call Function11d2ee
	ret

; 11d208 (47:5208)

Unknown_11d208_zero: ; 11d208
	db $0d, $1a
	db $3d, $1a
	db $6d, $1a
	db $0d, $2a
	db $3d, $2a
	db $6d, $2a
	db $0d, $8a
	db $3d, $8a
	db $6d, $8a

Unknown_11d21a_one: ; 11d21a
	db $0d, $42
	db $3d, $42
	db $6d, $42
	db $0d, $52
	db $3d, $52
	db $6d, $52
	db $0d, $62
	db $3d, $62
	db $6d, $62
	db $0d, $72
	db $3d, $72
	db $6d, $72
	db $0d, $82
	db $3d, $82
	db $6d, $82
	db $0d, $92
	db $3d, $92
	db $6d, $92

Unknown_11d23e_two_b: ; 11d23e
	db $10, $48
	db $18, $48
	db $20, $48
	db $28, $48
	db $30, $48
	db $10, $58
	db $18, $58
	db $20, $58
	db $28, $58
	db $30, $58
	db $10, $68
	db $18, $68
	db $20, $68
	db $28, $68
	db $30, $68
	db $10, $78
	db $18, $78
	db $20, $78
	db $28, $78
	db $30, $78
	db $40, $48
	db $48, $48
	db $50, $48
	db $58, $48
	db $60, $48
	db $40, $58
	db $48, $58
	db $50, $58
	db $58, $58
	db $60, $58
	db $40, $68
	db $48, $68
	db $50, $68
	db $58, $68
	db $60, $68
	db $70, $48
	db $80, $48
	db $90, $48
	db $40, $78
	db $48, $78
	db $50, $78
	db $58, $78
	db $60, $78
	db $70, $58
	db $70, $68
	db $0d, $92
	db $3d, $92
	db $6d, $92

Unknown_11d29e_three: ; 11d29e
	db $10, $50
	db $40, $50
	db $70, $50
	db $10, $60
	db $40, $60
	db $70, $60
	db $10, $70
	db $40, $70
	db $70, $70
	db $10, $80
	db $40, $80
	db $70, $80

Unknown_11d2b6_four: ; 11d2b6
	db $80, $50
	db $80, $60

Unknown_11d2ba_five: ; 11d2ba
	db $20, $50
	db $20, $60

Unknown_11d2be_two_a: ; 11d2be
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $28, $28
	db $29, $26
	db $26, $26

Function11d2ee: ; 11d2ee (47:52ee)
	ld hl, wcd24
	and [hl]
	jr nz, .update_y_offset
	ld a, e
	ld hl, wcd23
	and [hl]
	jr z, .reset_y_offset
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld a, [hl]
	and a
	jr z, .flip_bit_0
	dec [hl]
	ret

.flip_bit_0
	xor a
	ld [hld], a
	inc a
	xor [hl]
	ld [hl], a
	and a
	jr nz, .update_y_offset
.reset_y_offset
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	xor a
	ld [hl], a
	ret

.update_y_offset
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, $b0
	sub [hl]
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret
