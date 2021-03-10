DoBattleAnimFrame:
	ld hl, BATTLEANIMSTRUCT_FUNCTION
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw BattleAnimFunction_Null ; 00
	dw BattleAnimFunction_01 ; 01
	dw BattleAnimFunction_02 ; 02
	dw BattleAnimFunction_03 ; 03
	dw BattleAnimFunction_04 ; 04
	dw BattleAnimFunction_ThrowFromPlayerToEnemy ; 05
	dw BattleAnimFunction_ThrowFromPlayerToEnemyAndDisappear ; 06
	dw BattleAnimFunction_07 ; 07
	dw BattleAnimFunction_08 ; 08
	dw BattleAnimFunction_09 ; 09
	dw BattleAnimFunction_0A ; 0a
	dw BattleAnimFunction_RazorLeaf ; 0b
	dw BattleAnimFunction_0C ; 0c
	dw BattleAnimFunction_0D ; 0d
	dw BattleAnimFunction_0E ; 0e
	dw BattleAnimFunction_0F ; 0f
	dw BattleAnimFunction_10 ; 10
	dw BattleAnimFunction_11 ; 11
	dw BattleAnimFunction_PokeBall ; 12
	dw BattleAnimFunction_PokeBallBlocked ; 13
	dw BattleAnimFunction_14 ; 14
	dw BattleAnimFunction_15 ; 15
	dw BattleAnimFunction_16 ; 16
	dw BattleAnimFunction_17 ; 17
	dw BattleAnimFunction_18 ; 18
	dw BattleAnimFunction_19 ; 19
	dw BattleAnimFunction_1A ; 1a
	dw BattleAnimFunction_1B ; 1b
	dw BattleAnimFunction_1C ; 1c
	dw BattleAnimFunction_1D ; 1d
	dw BattleAnimFunction_1E ; 1e
	dw BattleAnimFunction_1F ; 1f
	dw BattleAnimFunction_LeechSeed ; 20
	dw BattleAnimFunction_21 ; 21
	dw BattleAnimFunction_22 ; 22
	dw BattleAnimFunction_23 ; 23
	dw BattleAnimFunction_24 ; 24
	dw BattleAnimFunction_25 ; 25
	dw BattleAnimFunction_26 ; 26
	dw BattleAnimFunction_27 ; 27
	dw BattleAnimFunction_28 ; 28
	dw BattleAnimFunction_SpiralDescent ; 29
	dw BattleAnimFunction_PoisonGas ; 2a
	dw BattleAnimFunction_Horn ; 2b
	dw BattleAnimFunction_2C ; 2c
	dw BattleAnimFunction_2D ; 2d
	dw BattleAnimFunction_2E ; 2e
	dw BattleAnimFunction_2F ; 2f
	dw BattleAnimFunction_30 ; 30
	dw BattleAnimFunction_31 ; 31
	dw BattleAnimFunction_32 ; 32
	dw BattleAnimFunction_33 ; 33
	dw BattleAnimFunction_34 ; 34
	dw BattleAnimFunction_35 ; 35
	dw BattleAnimFunction_36 ; 36
	dw BattleAnimFunction_37 ; 37
	dw BattleAnimFunction_38 ; 38
	dw BattleAnimFunction_39 ; 39
	dw BattleAnimFunction_3A ; 3a
	dw BattleAnimFunction_3B ; 3b
	dw BattleAnimFunction_3C ; 3c
	dw BattleAnimFunction_3D ; 3d
	dw BattleAnimFunction_3E ; 3e
	dw BattleAnimFunction_3F ; 3f
	dw BattleAnimFunction_40 ; 40
	dw BattleAnimFunction_41 ; 41
	dw BattleAnimFunction_42 ; 42
	dw BattleAnimFunction_43 ; 43
	dw BattleAnimFunction_44 ; 44
	dw BattleAnimFunction_45 ; 45
	dw BattleAnimFunction_46 ; 46
	dw BattleAnimFunction_47 ; 47
	dw BattleAnimFunction_48 ; 48
	dw BattleAnimFunction_49 ; 49
	dw BattleAnimFunction_4A ; 4a
	dw BattleAnimFunction_4B ; 4b
	dw BattleAnimFunction_4C ; 4c
	dw BattleAnimFunction_4D ; 4d
	dw BattleAnimFunction_4E ; 4e
	dw BattleAnimFunction_4F ; 4f
	dw BattleAnimFunction_StraightDescent
	dw BattleAnimFunction_PowerGem
	dw BattleAnimFunction_Moon

BattleAnim_AnonJumptable:
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	jp OffsetStackJumpTable

BattleAnim_IncAnonJumptableIndex:
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Null:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw DeinitBattleAnimation

BattleAnimFunction_ThrowFromPlayerToEnemyAndDisappear:
	call BattleAnimFunction_ThrowFromPlayerToEnemy
	ret c
	jp DeinitBattleAnimation

BattleAnimFunction_ThrowFromPlayerToEnemy:
	; If x coord at $88 or beyond, abort.
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	; Move right 2 pixels
	add $2
	ld [hl], a
	; Move down 1 pixel
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	; Decrease ??? and hold onto its previous value (argument of the sine function)
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	; Get ???, which is the amplitude of the sine function
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	call Sine
	; Store the result in the Y offset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	; Carry flag denotes success
	scf
	ret

BattleAnimFunction_04:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jp nc, DeinitBattleAnimation

	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
rept 4
	inc [hl]
endr
	ld d, $10
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	sra a
	sra a
	sra a
	ld [hl], a
	ret

BattleAnimFunction_03:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 7, [hl]
	ld a, 0
	jr z, .asm_cd0f9
	ld a, $20
.asm_cd0f9
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_01:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw DeinitBattleAnimation

.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jp Functionce70a

BattleAnimFunction_02:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .asm_cd158
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.asm_cd158
	jp DeinitBattleAnimation

BattleAnimFunction_PokeBall:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothing
	dw .three
	dw .four
	dw DoNothing
	dw .six
	dw .seven
	dw .eight
	dw DoNothing
	dw .ten
	dw DeinitBattleAnimation
.zero ; init
	call GetBallAnimPal
	jp BattleAnim_IncAnonJumptableIndex

.one
	call BattleAnimFunction_ThrowFromPlayerToEnemy
	ret c
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_0B
	call ReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.three
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_09
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $0
	inc hl
	ld [hl], $10
.four
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	dec [hl]
	ld a, [hl]
	and $1f
	ret nz
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
	ret nz
	ld a, BATTLEANIMFRAMESET_0C
	call ReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.six
	ld a, BATTLEANIMFRAMESET_0D
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	dec [hl]
	ret

.seven
	call GetBallAnimPal
	ld a, BATTLEANIMFRAMESET_0A
	call ReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $20
.eight
.ten
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	dec [hl]
	ld a, [hl]
	and $1f
	jr z, .done
	and $f
	ret nz
	jp BattleAnim_IncAnonJumptableIndex

.done
	jp DeinitBattleAnimation

BattleAnimFunction_PokeBallBlocked:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero
	call GetBallAnimPal
	jp BattleAnim_IncAnonJumptableIndex

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jp c, BattleAnimFunction_ThrowFromPlayerToEnemy

	call BattleAnim_IncAnonJumptableIndex
.two
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	add $4
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ret

.done
	jp DeinitBattleAnimation

GetBallAnimPal:
	ld hl, BATTLEANIMSTRUCT_PALETTE
	add hl, bc
	; poof uses GRAY, sparkle uses YELLOW, weather uses YELLOW/BLUE/BROWN/GRAY
	; RED and GREEN are free
	ld [hl], PAL_BATTLE_OB_RED
	ret

BattleAnimFunction_10:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DeinitBattleAnimation
	dw .three
	dw DoNothing
.zero
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.three
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_0F
	jp ReinitBattleAnimFrameset

BattleAnimFunction_07:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $30
	inc hl
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	sub [hl]
	jr z, .done
	jr c, .done
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
	ret

.done
	jp DeinitBattleAnimation

BattleAnimFunction_08:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jp c, .SetCoords
	call BattleAnim_IncAnonJumptableIndex
.one
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $0
.two
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .loop_back
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Cosine
	sub $18
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.loop_back
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f0
	jr z, .finish
	sub $10
	ld d, a
	ld a, [hl]
	and $f
	or d
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	dec [hl]
	ret

.finish
	call BattleAnim_IncAnonJumptableIndex
.three
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b0
	jp nc, DeinitBattleAnimation

.SetCoords:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.loop
	dec [hl]
	dec e
	jr nz, .loop
	ret

BattleAnimFunction_09:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DeinitBattleAnimation
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done_one
	dec [hl]
	ret

.done_one
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_0A:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw DoNothing
	dw .seven
	dw .eight
	dw DeinitBattleAnimation
.zero
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	cp $7
	jr z, .seven
	ld a, BATTLEANIMFRAMESET_11
	jp ReinitBattleAnimFrameset

.seven
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .set_up_eight
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.set_up_eight
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_10
	call ReinitBattleAnimFrameset
.eight
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ret

.one
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

.four
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.two
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

.five
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.three
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_RazorLeaf:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw .eight
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .sine_cosine
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hli], a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_17
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 6, [hl]
	ret z
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $5
	ret

.sine_cosine
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call Functioncd557
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ret

.two
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jp z, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 6, [hl]
	jr nz, .decrease
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	jr .finish

.decrease
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	dec [hl]
.finish
	ld de, $80
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ret

.three
	ld a, BATTLEANIMFRAMESET_16
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	res 5, [hl]
	jp BattleAnim_IncAnonJumptableIndex

.eight
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, $8
	jp Functionce70a

Functioncd557:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	bit 7, a
	jr nz, .negative
	cp $20
	jr nc, .plus_256
	cp $18
	jr nc, .plus_384
	ld de, $200
	ret

.plus_384
	ld de, $180
	ret

.plus_256
	ld de, $100
	ret

.negative
	and $3f
	cp $20
	jr nc, .minus_256
	cp $18
	jr nc, .minus_384
	ld de, -$200
	ret

.minus_384
	ld de, -$180
	ret

.minus_256
	ld de, -$100
	ret

BattleAnimFunction_4E:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $40
	rlca
	rlca
	add $19
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $30
	jp c, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call Functioncd557
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_0C:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $c
.one
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.next
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $0
	ld a, BATTLEANIMFRAMESET_22
	call ReinitBattleAnimFrameset
.two
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	jr nc, .okay
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	ld de, $60
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
.okay
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $20
	ret c
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f0
	ld e, a
	ld d, $ff
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

BattleAnimFunction_0D:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothing
	dw .three
	dw DeinitBattleAnimation
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld a, LOW(rSCY)
	ldh [hLCDCPointer], a
	ld a, $58
	ldh [hLYOverrideStart], a
	ld a, $5e
	ldh [hLYOverrideEnd], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp e
	jr nc, .asm_cd69b
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ldh [hLYOverrideStart], a
	ret

.asm_cd69b
	dec a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	sub $10
	ret c
	ldh [hLYOverrideStart], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	inc a
	and $7
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.three
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jr c, asm_cd6da
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	jp DeinitBattleAnimation

asm_cd6da:
	inc a
	inc a
	ld [hl], a
	sub $10
	ret c
	ldh [hLYOverrideStart], a
	ret

BattleAnimFunction_0E:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd6ea
	dw Functioncd6f7
Functioncd6ea:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, BATTLEANIMFRAMESET_24
	add [hl] ; offset
	call ReinitBattleAnimFrameset
Functioncd6f7:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jp nc, DeinitBattleAnimation

	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_0F:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd725
	dw Functioncd728
	dw Functioncd763
	dw DoNothing
Functioncd725:
	call BattleAnim_IncAnonJumptableIndex
Functioncd728:
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_cd747
	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_cd747
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_28
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], $30
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	ld a, [hl]
	and $1
	ld [hl], a
Functioncd763:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $18
	jr nc, .asm_cd76e
	inc [hl]
	ret

.asm_cd76e
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_29
	jp ReinitBattleAnimFrameset

BattleAnimFunction_11:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jp nc, DeinitBattleAnimation

	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld l, [hl]
	ld h, a
	ld de, $80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	xor $10
	ld [hl], a
	ret

BattleAnimFunction_14:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd7ab
	dw Functioncd7d2
Functioncd7ab:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f0
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	sla a
	sla a
	sla a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld [hl], $1
Functioncd7d2:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and a
	jp z, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	xor $1
	ld [hl], a
	ret z
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_15:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw Functioncd817
	dw DoNothing
	dw DeinitBattleAnimation
Functioncd817:
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_35
	jp ReinitBattleAnimFrameset

BattleAnimFunction_16:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd835
	dw Functioncd860
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd893
Functioncd835:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_cd852
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $10
	jr .asm_cd858

.asm_cd852
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $30
.asm_cd858
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncd860:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	jr nz, .load_no_inc
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	inc a
	jr .reinit

.load_no_inc
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
.reinit
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
Functioncd88f:
	jp BattleAnim_IncAnonJumptableIndex

Functioncd893:
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_17:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd8ab
	dw Functioncd8cc
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f9
Functioncd8ab:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_cd8be
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $10
	jr .asm_cd8c4

.asm_cd8be
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $30
.asm_cd8c4
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncd8cc:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	ld a, $3d
	jr z, .asm_cd8e8
	dec a ; ld a, $3c
.asm_cd8e8
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
Functioncd8f5:
	jp BattleAnim_IncAnonJumptableIndex

Functioncd8f9:
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_18:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd907
	dw Functioncd913
Functioncd907:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $28
	inc hl
	ld [hl], $0
Functioncd913:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cd950
	ld d, a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], d
	ret

.asm_cd950
	jp DeinitBattleAnimation

BattleAnimFunction_19:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd961
	dw Functioncd99a
	dw Functioncd96e
	dw Functioncd99a
	dw Functioncd97b
Functioncd961:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld [hl], $0
	jp Functioncd99a

Functioncd96e:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr c, asm_cd988
	jp BattleAnim_IncAnonJumptableIndex

Functioncd97b:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jp nc, DeinitBattleAnimation

asm_cd988:
	call Functioncd99a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

Functioncd99a:
	call .GetGustRadius
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cd9d7
	cp $c2
	jr c, .asm_cd9e2
.asm_cd9d7
	dec a
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	inc [hl]
	ret

.asm_cd9e2
	xor a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hli], a
	ld [hl], a
	ret

.GetGustRadius:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .GustOffsets
	add hl, de
	ld d, [hl]
	ret

.GustOffsets:
	db 8, 6, 5, 4, 5, 6, 8, 12, 16

BattleAnimFunction_1C:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jp c, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.asm_cda2c
	inc [hl]
	dec e
	jr nz, .asm_cda2c
	ret

BattleAnimFunction_1F:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw Functioncda3a
	dw DoNothing
Functioncda3a:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	inc a
	call ReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $8
	ret

BattleAnimFunction_LeechSeed:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $40
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $20
	jp nc, Functioncda8d

	ld [hl], $40
	ld a, BATTLEANIMFRAMESET_57
	call ReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.two:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and a
	jr z, .flutter
	dec [hl]
	ret

.flutter
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_58
	jp ReinitBattleAnimFrameset

Functioncda8d:
	dec [hl]
	ld d, $20
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_02
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld h, [hl]
	ld a, h
	and $f
	swap a
	ld l, a
	ld a, h
	and $f0
	swap a
	ld h, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_3F:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdadf
	dw Functioncdae9
	dw DoNothing
Functioncdadf:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $40
	ret

Functioncdae9:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $20
	jp c, BattleAnim_IncAnonJumptableIndex
	jp Functioncda8d

BattleAnimFunction_1A:
	call BattleAnimFunction_03
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	add $f
	ld [hl], a
	ret

BattleAnimFunction_1B:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw Functioncdb14
	dw Functioncdb28
	dw Functioncdb50
	dw Functioncdb65

Functioncdb14:
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_cdb24
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.asm_cdb24
	add $4
	ld [hl], a
	ret

Functioncdb28:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	set 0, [hl]
	ld hl, BATTLEANIMSTRUCT_02
	add hl, bc
	ld [hl], $90
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $2
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

Functioncdb50:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $2c
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $80
Functioncdb65:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_1D:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdb9f
	dw Functioncdbb3
	dw Functioncdbcf
	dw Functioncdbeb
	dw DoNothing
	dw DeinitBattleAnimation
	dw Functioncdbc1
	dw Functioncdc1e
	dw Functioncdc27
	dw Functioncdc39
	dw DoNothing
	dw Functioncdc48
	dw Functioncdc57
	dw DoNothing
Functioncdb9f:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $28
	inc hl
	ld [hl], $10
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	ret

Functioncdbb3:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .asm_cdbbd
	inc [hl]
.asm_cdbbd
	jp Functioncdc75

Functioncdbc1:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $4b
	jr nc, .asm_cdbcb
	inc [hl]
.asm_cdbcb
	jp Functioncdc75

Functioncdbcf:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .asm_cdbe6
	and $f
	jr nz, asm_cdbfa
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $10
	jp BattleAnim_IncAnonJumptableIndex

.asm_cdbe6
	call BattleAnim_IncAnonJumptableIndex
	inc [hl]
	ret

Functioncdbeb:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdbf5
	dec [hl]
	ret

.asm_cdbf5
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	dec [hl]
asm_cdbfa:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ret

Functioncdc1e:
	ld a, BATTLEANIMFRAMESET_4E
	call ReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

Functioncdc27:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $2
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

Functioncdc39:
	ld a, BATTLEANIMFRAMESET_50
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $4
	jp BattleAnim_IncAnonJumptableIndex

Functioncdc48:
	ld a, BATTLEANIMFRAMESET_4F
	call ReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $40
	ret

Functioncdc57:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $20
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $30
	jp c, BattleAnim_IncAnonJumptableIndex
	dec [hl]
	ret

Functioncdc75:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ret nz
	xor a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hli], a
	ld [hl], a
	jp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_1E:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdcb6
	cp $d8
	jp c, DeinitBattleAnimation

.asm_cdcb6
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ret

BattleAnimFunction_StraightDescent:
; Reverse 1E
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $28
	jp nc, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ret

BattleAnimFunction_PowerGem:
	call BattleAnim_AnonJumptable
.anon_dw
	dw PowerGemFunction1
	dw PowerGemFunction2
	dw PowerGemFunction3

PowerGemFunction1:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .asm_ce319
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $2
	ret

.asm_ce319
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ret

PowerGemFunction2:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce33a
	dec [hl]
	ret

.asm_ce33a
	ld [hl], $4
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

PowerGemFunction3:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, $8
	jp Functionce70a

BattleAnimFunction_Moon:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce306
	dw Functionce330
	dw Functionce34c

BattleAnimFunction_21:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdcca
	dw Functioncdced
Functioncdcca:
	ldh a, [hBattleTurn]
	and a
	jr z, .asm_cdcd9
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	cpl
	add $3
	ld [hl], a
.asm_cdcd9
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $8
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, BATTLEANIMFRAMESET_59
	add [hl]
	jp ReinitBattleAnimFrameset

Functioncdced:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdcfa
	dec [hl]
	jp Functioncdcfe

.asm_cdcfa
	jp DeinitBattleAnimation

Functioncdcfe:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $10
	call Sine
	ld d, a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdd20
	dec a
	ret z
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ret

.asm_cdd20
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, d
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_22:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdd31
	dw Functioncdd4f
Functioncdd31:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $3f
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld [hl], a
	add BATTLEANIMFRAMESET_5D
	jp ReinitBattleAnimFrameset

Functioncdd4f:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	swap a
	ld d, a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	inc [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	ret nc
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .asm_cdd87
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
.asm_cdd87
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_23:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdd97
	dw Functioncddbc
Functioncdd97:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	add [hl]
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncddbc:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $3f
	jr z, .asm_cddf0
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc a
	jr .asm_cddf5

.asm_cddf0
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
.asm_cddf5
	jp ReinitBattleAnimFrameset

BattleAnimFunction_24:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde02
	dw DoNothing
	dw DeinitBattleAnimation
Functioncde02:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	add BATTLEANIMFRAMESET_63
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .AmnesiaOffsets
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.AmnesiaOffsets:
	db $ec, $f8, $00

BattleAnimFunction_25:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $4
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld e, [hl]
	ld hl, $ffa0
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_26:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	dec [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_27:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde72
	dw DoNothing
Functioncde72:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .asm_cde83
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	set 6, [hl]
.asm_cde83
	add BATTLEANIMFRAMESET_6A
	jp ReinitBattleAnimFrameset

BattleAnimFunction_28:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde90
	dw Functioncdebf
Functioncde90:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld e, [hl]
	ld a, e
	and $70
	swap a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, e
	and $80
	jr nz, .asm_cdeb2
	ld a, e
	and $f
	ld [hl], a
	ret

.asm_cdeb2
	ld a, e
	and $f
	cpl
	inc a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_6E
	jp ReinitBattleAnimFrameset

Functioncdebf:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdec9
	dec [hl]
	ret

.asm_cdec9
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_SpiralDescent:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $28
	jr nc, .delete
	inc [hl]
	ret

.delete
	jp DeinitBattleAnimation

BattleAnimFunction_2D:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $28
	jr nc, .asm_cdf55
	inc [hl]
	ret

.asm_cdf55
	jp DeinitBattleAnimation

BattleAnimFunction_PoisonGas:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdf60
	dw BattleAnimFunction_SpiralDescent
Functioncdf60:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .next
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.next
	jp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_34:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $e8
	jr z, .asm_cdfc7
	dec [hl]
	ret

.asm_cdfc7
	jp DeinitBattleAnimation

BattleAnimFunction_3C:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .asm_ce007
	dec [hl]
	dec [hl]
	ret

.asm_ce007
	jp DeinitBattleAnimation

BattleAnimFunction_35:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce014
	dw Functionce023
	dw DeinitBattleAnimation
Functionce014:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $34
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $10
Functionce023:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $6c
	jr c, .asm_ce02d
	ret

.asm_ce02d
	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld d, [hl]
	call Sine
	bit 7, a
	jr nz, .asm_ce046
	cpl
	inc a
.asm_ce046
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
	and $1f
	cp $20
	ret nz
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	srl [hl]
	ret

BattleAnimFunction_Horn:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw Functionce09e

.zero:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	ret nc
	ld a, $2
	jp Functionce70a

.two:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	cp $20
	jp nc, DeinitBattleAnimation

Functionce09e:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	sra a
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

BattleAnimFunction_2C:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce0ce
	dw Functionce0f8
	dw Functionce0dd
Functionce0ce:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	ret

Functionce0dd:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .asm_ce0f0
	ld [hl], a
.asm_ce0f0
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
Functionce0f8:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jp nc, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jp Functionce70a

BattleAnimFunction_2E:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce115
	dw Functionce12a
Functionce115:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $28
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
Functionce12a:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	and [hl]
	jr nz, .asm_ce149
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.asm_ce149
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $20
	inc hl
	srl [hl]
	ret

BattleAnimFunction_2F:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	jr nz, .asm_ce189
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.asm_ce189
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .asm_ce197
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
.asm_ce197
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	cp $5a
	jr nc, .asm_ce1aa
	ld a, [hl]
	and a
	jr z, .asm_ce1ac
	dec [hl]
	ret

.asm_ce1aa
	inc [hl]
	ret

.asm_ce1ac
	jp DeinitBattleAnimation

BattleAnimFunction_42:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	cp $40
	jr nc, .asm_ce1df
	inc [hl]
	ret

.asm_ce1df
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jp DeinitBattleAnimation

BattleAnimFunction_30:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce1ee
	dw Functionce1fb
Functionce1ee:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], a
Functionce1fb:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $30
	call Sine
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	add $8
	ld d, $30
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_31:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce22d
	dw DoNothing
Functionce22d:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld [hl], $f
	ret

BattleAnimFunction_32:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce260
	dw Functionce29f
	dw Functionce278
	dw Functionce289
Functionce260:
	call BattleAnim_IncAnonJumptableIndex
	ldh a, [hBattleTurn]
	and a
	ld a, $f0
	jr z, .asm_ce26e
	ld a, $cc
.asm_ce26e
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], a
	ret

Functionce278:
	call Functionce29f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld a, $4
	jp Functionce70a

Functionce289:
	call Functionce29f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr nc, .asm_ce29b
	ld a, $4
	jp Functionce70a

.asm_ce29b
	jp DeinitBattleAnimation

Functionce29f:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and $7
	inc [hl]
	srl a
	ld e, a
	ld d, $0
	ld hl, Unknown_ce2c4
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	and [hl]
	ld [wOBP0], a
	ret

Unknown_ce2c4:
	db $ff, $aa, $55, $aa

BattleAnimFunction_33:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	dec [hl]
	dec [hl]
	ret

BattleAnimFunction_36:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce306
	dw Functionce330
	dw Functionce34c
Functionce306:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $e0
	jr nz, .asm_ce319
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $2
	ret

.asm_ce319
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ret

Functionce330:
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce33a
	dec [hl]
	ret

.asm_ce33a
	ld [hl], $4
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

Functionce34c:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .asm_ce35b
	ld a, $4
	jp Functionce70a

.asm_ce35b
	jp DeinitBattleAnimation

BattleAnimFunction_37:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce366
	dw Functionce375
Functionce366:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $7f
	add BATTLEANIMFRAMESET_81
	call ReinitBattleAnimFrameset
Functionce375:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_ce383
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

.asm_ce383
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_38:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce392
	dw Functionce39c
	dw Functionce3ae
Functionce392:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $c
	ret

Functionce39c:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce3a6
	dec [hl]
	ret

.asm_ce3a6
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_20
	call ReinitBattleAnimFrameset
Functionce3ae:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_39:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	ld d, $2
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop af
	ld d, $8
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_3A:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jp nc, DeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $8
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_3B:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce406
	dw DeinitBattleAnimation
Functionce406:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ret

BattleAnimFunction_3D:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	ret

BattleAnimFunction_3E:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce443
	dw Functionce465
	dw Functionce490
Functionce443:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	add [hl]
	call ReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and $f0
	or $8
	ld [hl], a
Functionce465:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce48b
	dec [hl]
	add $8
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce48b
	ld [hl], $10
	call BattleAnim_IncAnonJumptableIndex
Functionce490:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jp DeinitBattleAnimation

BattleAnimFunction_40:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce4a3
	dw Functionce4b0
Functionce4a3:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, BATTLEANIMFRAMESET_24
	add [hl]
	call ReinitBattleAnimFrameset
Functionce4b0:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jr nc, .asm_ce4d8
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	ret

.asm_ce4d8
	jp DeinitBattleAnimation

BattleAnimFunction_41:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Sine
	bit 7, a
	jr nz, .asm_ce4f4
	cpl
	inc a
.asm_ce4f4
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	srl [hl]
	ret

BattleAnimFunction_43:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .asm_ce52e
	inc [hl]
	inc [hl]
	ld d, a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce52e
	jp DeinitBattleAnimation

BattleAnimFunction_44:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld d, [hl]
	ld a, e
	and $c0
	rlca
	rlca
	add [hl]
	ld [hl], a
	ld a, e
	and $3f
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_45:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce564
	dw Functionce56e
	dw Functionce577
Functionce564:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	jr asm_ce58f

Functionce56e:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $18
Functionce577:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .asm_ce58b
	ld d, a
	add $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	jr asm_ce58f

.asm_ce58b
	jp DeinitBattleAnimation

asm_ce58f:
	jp Functionce6f1

BattleAnimFunction_46:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw Functionce59a
Functionce59a:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jp c, DeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_47:
	ld d, $50
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	add [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_48:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .disappear
rept 4
	dec [hl]
endr
	ret

.disappear
	jp DeinitBattleAnimation

BattleAnimFunction_49:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce5f9
	dw Functionce60a
	dw Functionce622
	dw DeinitBattleAnimation
Functionce5f9:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	and a
	jr nz, asm_ce61c
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $ec
Functionce60a:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $4
	jr z, Functionce618
rept 4
	inc [hl]
endr
	ret

Functionce618:
	jp DeinitBattleAnimation

asm_ce61c:
	call BattleAnim_IncAnonJumptableIndex
	call BattleAnim_IncAnonJumptableIndex
Functionce622:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d8
	ret z
rept 4
	dec [hl]
endr
	ret

BattleAnimFunction_4A:
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce63a
	dw Functionce648
	dw Functionce65c
	dw Functionce672
Functionce63a:
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	jp BattleAnim_IncAnonJumptableIndex

Functionce648:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce654
	xor a
.asm_ce654
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	inc [hl]
	ret

Functionce65c:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce668
	xor a
.asm_ce668
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

Functionce672:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce67e
	xor a
.asm_ce67e
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	ld [hl], a
	ret

BattleAnimFunction_4B:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	ld l, a
	and $f0
	ld h, a
	swap a
	or h
	ld h, a
	ld a, l
	and $f
	swap a
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_4C:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld a, [hl]
	inc [hl]
	jp Functionce6f1

BattleAnimFunction_4F:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_10
	add hl, bc
	ld a, [hl]
	inc [hl]
	srl a
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	add [hl]
	jp Functionce6f1

BattleAnimFunction_4D:
	ld hl, BATTLEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	cp $20
	jr nc, .asm_ce6ed
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_0B
	add hl, bc
	ld d, [hl]
	call Sine
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce6ed
	jp DeinitBattleAnimation

Functionce6f1:
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

Functionce70a:
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.asm_ce719
	dec [hl]
	dec e
	jr nz, .asm_ce719
	ret
