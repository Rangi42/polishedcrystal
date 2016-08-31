; These functions seem to be related to the selection of preset phrases
; for use in mobile communications.  Annoyingly, they separate the
; Battle Tower function above from the data it references.

Function11c08f: ; 11c08f
	ld l, e
	ld h, d
	push hl
	ld a, $3
.asm_11c094
	push af
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	push bc

	jr c, .asm_11c0a2
	inc bc

.asm_11c0a2
	ld l, c
	ld h, b
	pop bc
	pop af
	dec a
	jr nz, .asm_11c094
	pop hl
	ld de, $0028
	add hl, de
	ld a, $3
.asm_11c0b0
	push af
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
	push bc

	jr c, .asm_11c0be
	inc bc

.asm_11c0be
	ld l, c
	ld h, b
	pop bc
	pop af
	dec a
	jr nz, .asm_11c0b0
	ret

; 11c0c6

Function11c277: ; 11c277 (47:4277)
	ld a, " "
	hlcoord 0, 6
	ld bc, (SCREEN_HEIGHT - 6) * SCREEN_WIDTH
	call ByteFill
	ret

.DoJumptableFunction: ; 11c2ac
	jumptable .Jumptable, wJumptableIndex
; 11c2bb

.Jumptable: ; 11c2bb (47:42bb)
	dw Function11c2e9 ; 00
	dw Function11c346 ; 01
	dw Function11c35f ; 02
	dw Function11c373 ; 03
	dw Function11c3c2 ; 04
	dw Function11c3ed ; 05
	dw Function11c52c ; 06
	dw Function11c53d ; 07
	dw Function11c658 ; 08
	dw Function11c675 ; 09
	dw Function11c9bd ; 0a
	dw Function11c9c3 ; 0b
	dw Function11caad ; 0c
	dw Function11cab3 ; 0d
	dw Function11cb52 ; 0e
	dw Function11cb66 ; 0f
	dw Function11cbf5 ; 10
	dw Function11ccef ; 11
	dw Function11cd04 ; 12
	dw Function11cd20 ; 13
	dw Function11cd54 ; 14
	dw Function11ce0b ; 15
	dw Function11ce2b ; 16


Function11c2e9: ; 11c2e9 (47:42e9)
	depixel 3, 1, 2, 5
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	depixel 8, 1, 2, 5
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	ld hl, $c
	add hl, bc
	ld a, $1
	ld [hl], a
	depixel 9, 2, 2, 0
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	ld hl, $c
	add hl, bc
	ld a, $3
	ld [hl], a
	depixel 10, 16
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	ld hl, $c
	add hl, bc
	ld a, $4
	ld [hl], a
	depixel 10, 4
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	ld hl, $c
	add hl, bc
	ld a, $5
	ld [hl], a
	depixel 10, 2
	ld a, SPRITE_ANIM_INDEX_1D
	call _InitSpriteAnimStruct
	ld hl, $c
	add hl, bc
	ld a, $2
	ld [hl], a
	ld hl, wcd23
	set 1, [hl]
	set 2, [hl]
	jp Function11cfb5

Function11c346: ; 11c346 (47:4346)
	ld a, $9
	ld [wcd2d], a
	ld a, $2
	ld [wcd2e], a
	ld [wcd2f], a
	ld [wcd30], a
	ld de, wcd2d
	call Function11cfce
	jp Function11cfb5

Function11c35f: ; 11c35f (47:435f)
	ld hl, wcd2f
	inc [hl]
	inc [hl]
	dec hl
	dec hl
	dec [hl]
	push af
	ld de, wcd2d
	call Function11cfce
	pop af
	ret nz
	jp Function11cfb5

Function11c373: ; 11c373 (47:4373)
	ld hl, wcd30
	inc [hl]
	inc [hl]
	dec hl
	dec hl
	dec [hl]
	push af
	ld de, wcd2d
	call Function11cfce
	pop af
	ret nz
	call Function11c38a
	jp Function11cfb5

Function11c38a: ; 11c38a (47:438a)
	ld hl, Unknown_11c986
	ld bc, wcd36
	ld a, $6
.asm_11c392
	push af
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	push de
	pop hl
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a
	push bc
	or e
	jr z, .asm_11c3af
	ld a, e
	and d
	cp $ff
	jr z, .asm_11c3af

	jr .asm_11c3b5
.asm_11c3af
	ld de, String_11c3bc
	call PlaceString
.asm_11c3b5
	pop bc
	pop hl
	pop af
	dec a
	jr nz, .asm_11c392
	ret

; 11c3bc (47:43bc)

String_11c3bc: ; 11c3bc
	db "ーーーーー@"
; 11c3c2

Function11c3c2: ; 11c3c2 (47:43c2)
	call Function11c277
	ld de, Unknown_11cfbe
	call Function11d035
	hlcoord 1, 7
	ld de, String_11c4db
	call PlaceString
	hlcoord 1, 16
	ld de, String_11c51b
	call PlaceString
	call Function11c4be
	ld hl, wcd23
	set 0, [hl]
	ld hl, wcd24
	res 0, [hl]
	call Function11cfb5

Function11c3ed: ; 11c3ed (47:43ed)
	ld hl, wcd20 ; wcd20 (aliases: CreditsPos)
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and $8
	jr nz, .asm_11c426
	ld a, [de]
	and $2
	jr nz, .asm_11c41a
	ld a, [de]
	and $1
	jr nz, .asm_11c42c
	ld de, hJoyLast
	ld a, [de]
	and $40
	jr nz, .asm_11c47c
	ld a, [de]
	and $80
	jr nz, .asm_11c484
	ld a, [de]
	and $20
	jr nz, .asm_11c48c
	ld a, [de]
	and $10
	jr nz, .asm_11c498
	ret

.asm_11c41a
	call PlayClickSFX
.asm_11c41d
	ld hl, wcd24
	set 0, [hl]
	ld a, $c
	jr .asm_11c475
.asm_11c426
	ld a, $8
	ld [wcd20], a ; wcd20 (aliases: CreditsPos)
	ret

.asm_11c42c
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	cp $6
	jr c, .asm_11c472
	sub $6
	jr z, .asm_11c469
	dec a
	jr z, .asm_11c41d
	ld hl, wcd36
	ld c, $c
	xor a
.asm_11c440
	or [hl]
	inc hl
	dec c
	jr nz, .asm_11c440
	and a
	jr z, .asm_11c460
	ld de, Unknown_11cfba
	call Function11cfce
	decoord 1, 2
	ld bc, wcd36
	call Function11c08f
	ld hl, wcd24
	set 0, [hl]
	ld a, $e
	jr .asm_11c475
.asm_11c460
	ld hl, wcd24
	set 0, [hl]
	ld a, $11
	jr .asm_11c475
.asm_11c469
	ld hl, wcd24
	set 0, [hl]
	ld a, $a
	jr .asm_11c475
.asm_11c472
	call Function11c4a5
.asm_11c475
	ld [wJumptableIndex], a
	call PlayClickSFX
	ret

.asm_11c47c
	ld a, [hl]
	cp $3
	ret c
	sub $3
	jr .asm_11c4a3
.asm_11c484
	ld a, [hl]
	cp $6
	ret nc
	add $3
	jr .asm_11c4a3
.asm_11c48c
	ld a, [hl]
	and a
	ret z
	cp $3
	ret z
	cp $6
	ret z
	dec a
	jr .asm_11c4a3
.asm_11c498
	ld a, [hl]
	cp $2
	ret z
	cp $5
	ret z
	cp $8
	ret z
	inc a
.asm_11c4a3
	ld [hl], a
	ret

Function11c4a5: ; 11c4a5 (47:44a5)
	ld hl, wcd23
	res 0, [hl]
	ld a, [wcd2b]
	and a
	jr nz, .asm_11c4b7
	xor a
	ld [wcd21], a
	ld a, $6
	ret

.asm_11c4b7
	xor a
	ld [wcd22], a
	ld a, $15
	ret

Function11c4be: ; 11c4be (47:44be)
	ld a, $1
	hlcoord 0, 6, AttrMap
	ld bc, $a0
	call ByteFill
	ld a, $7
	hlcoord 0, 14, AttrMap
	ld bc, $28
	call ByteFill
	callba ReloadMapPart
	ret

; 11c4db (47:44db)

String_11c4db: ; 11c4db
	db   "6つのことば¯くみあわせます"
	next "かえたいところ¯えらぶと でてくる"
	next "ことばのグループから いれかえたい"
	next "たんご¯えらんでください"
	db   "@"
; 11c51b

String_11c51b: ; 11c51b
	db "ぜんぶけす やめる   けってい@"
; 11c52c

Function11c52c: ; 11c52c (47:452c)
	call Function11c277
	call Function11c618
	ld hl, wcd24
	res 1, [hl]
	call Function11cfb5

Function11c53d: ; 11c53d (47:453d)
	ld hl, wcd21
	ld de, hJoypadPressed ; $ffa3

	ld a, [de]
	and START
	jr nz, .start

	ld a, [de]
	and SELECT
	jr nz, .select

	ld a, [de]
	and B_BUTTON
	jr nz, .b

	ld a, [de]
	and A_BUTTON
	jr nz, .a

	ld de, hJoyLast

	ld a, [de]
	and D_UP
	jr nz, .up

	ld a, [de]
	and D_DOWN
	jr nz, .down

	ld a, [de]
	and D_LEFT
	jr nz, .left

	ld a, [de]
	and D_RIGHT
	jr nz, .right

	ret

.a
	ld a, [wcd21]
	cp $f
	jr c, .asm_11c59d
	sub $f
	jr z, .asm_11c5ab
	dec a
	jr z, .asm_11c599
	jr .b

.start
	ld hl, wcd24
	set 0, [hl]
	ld a, $8
	ld [wcd20], a ; wcd20 (aliases: CreditsPos)

.b
	ld a, $4
	jr .asm_11c59f

.select
	ld a, [wcd2b]
	xor $1
	ld [wcd2b], a
	ld a, $15
	jr .asm_11c59f

.asm_11c599
	ld a, $13
	jr .asm_11c59f

.asm_11c59d
	ld a, $8

.asm_11c59f
	ld hl, wcd24
	set 1, [hl]
	ld [wJumptableIndex], a
	call PlayClickSFX
	ret

.asm_11c5ab
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	call Function11ca6a
	call PlayClickSFX
	ret

.up
	ld a, [hl]
	cp $3
	ret c
	sub $3
	jr .asm_11c5ee

.down
	ld a, [hl]
	cp $f
	ret nc
	add $3
	jr .asm_11c5ee

.left
	ld a, [hl]
	and a
	ret z
	cp $3
	ret z
	cp $6
	ret z
	cp $9
	ret z
	cp $c
	ret z
	cp $f
	ret z
	dec a
	jr .asm_11c5ee

.right
	ld a, [hl]
	cp $2
	ret z
	cp $5
	ret z
	cp $8
	ret z
	cp $b
	ret z
	cp $e
	ret z
	cp $11
	ret z
	inc a

.asm_11c5ee
	ld [hl], a
	ret

; 11c5f0

Function11c618: ; 11c618 (47:4618)
	ld a, $2
	hlcoord 0, 6, AttrMap
	ld bc, $c8
	call ByteFill
	callba ReloadMapPart
	ret

; 11c62a (47:462a)

String_11c62a: ; 11c62a
	db "けす    モード   やめる@"
; 11c63a

Function11c658: ; 11c658 (47:4658)
	call Function11c277
	call Function11c770
	ld de, Unknown_11cfc2
	call Function11d035
	call Function11c9ab
	call Function11c7bc
	call Function11c86e
	ld hl, wcd24
	res 3, [hl]
	call Function11cfb5

Function11c675: ; 11c675 (47:4675)
	ld hl, wcd25
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and A_BUTTON
	jr nz, .a
	ld a, [de]
	and B_BUTTON
	jr nz, .b
	ld a, [de]
	and START
	jr nz, .start
	ld a, [de]
	and SELECT
	jr z, .select

	ld a, [wcd26]
	and a
	ret z
	sub $c
	jr nc, .asm_11c699
	xor a
.asm_11c699
	ld [wcd26], a
	jr .asm_11c6c4

.start
	ld hl, wcd28
	ld a, [wcd26]
	add $c
	cp [hl]
	ret nc
	ld [wcd26], a
	ld a, [hl]
	ld b, a
	ld hl, wcd25
	ld a, [wcd26]
	add [hl]
	jr c, .asm_11c6b9
	cp b
	jr c, .asm_11c6c4
.asm_11c6b9
	ld a, [wcd28]
	ld hl, wcd26
	sub [hl]
	dec a
	ld [wcd25], a
.asm_11c6c4
	call Function11c992
	call Function11c7bc
	call Function11c86e
	ret

.select
	ld de, hJoyLast
	ld a, [de]
	and D_UP
	jr nz, .asm_11c708
	ld a, [de]
	and D_DOWN
	jr nz, .asm_11c731
	ld a, [de]
	and D_LEFT
	jr nz, .asm_11c746
	ld a, [de]
	and D_RIGHT
	jr nz, .asm_11c755
	ret

.a
	call Function11c8f6
	ld a, $4
	ld [wcd35], a
	jr .asm_11c6fc
.b
	ld a, [wcd2b]
	and a
	jr nz, .asm_11c6fa
	ld a, $6
	jr .asm_11c6fc
.asm_11c6fa
	ld a, $15
.asm_11c6fc
	ld [wJumptableIndex], a
	ld hl, wcd24
	set 3, [hl]
	call PlayClickSFX
	ret

.asm_11c708
	ld a, [hl]
	cp $3
	jr c, .asm_11c711
	sub $3
	jr .asm_11c76e
.asm_11c711
	ld a, [wcd26]
	sub $3
	ret c
	ld [wcd26], a
	jr .asm_11c6c4
.asm_11c71c
	ld hl, wcd28
	ld a, [wcd26]
	add $c
	ret c
	cp [hl]
	ret nc
	ld a, [wcd26]
	add $3
	ld [wcd26], a
	jr .asm_11c6c4
.asm_11c731
	ld a, [wcd28]
	ld b, a
	ld a, [wcd26]
	add [hl]
	add $3
	cp b
	ret nc
	ld a, [hl]
	cp $9
	jr nc, .asm_11c71c
	add $3
	jr .asm_11c76e
.asm_11c746
	ld a, [hl]
	and a
	ret z
	cp $3
	ret z
	cp $6
	ret z
	cp $9
	ret z
	dec a
	jr .asm_11c76e
.asm_11c755
	ld a, [wcd28]
	ld b, a
	ld a, [wcd26]
	add [hl]
	inc a
	cp b
	ret nc
	ld a, [hl]
	cp $2
	ret z
	cp $5
	ret z
	cp $8
	ret z
	cp $b
	ret z
	inc a
.asm_11c76e
	ld [hl], a
	ret

Function11c770: ; 11c770 (47:4770)
	xor a
	ld [wcd25], a
	ld [wcd26], a
	ld [wcd27], a
	ld a, [wcd2b]
	and a
	jr nz, .asm_11c7ab
	ld a, [wcd21]
	and a
	jr z, .asm_11c799
	dec a
	sla a
	ld hl, Unknown_11f220
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld [wcd28], a
	ld a, [hl]
.asm_11c795
	ld [wcd29], a
	ret

.asm_11c799
	ld a, [wc7d2]
	ld [wcd28], a
.asm_11c79f
	ld c, $c
	call SimpleDivide
	and a
	jr nz, .asm_11c7a8
	dec b
.asm_11c7a8
	ld a, b
	jr .asm_11c795
.asm_11c7ab
	ld hl, $c68a + 30
	ld a, [wcd22]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hl]
	ld [wcd28], a
	jr .asm_11c79f

Function11c7bc: ; 11c7bc (47:47bc)
	ld bc, Unknown_11c854
	ld a, [wcd2b]
	and a
	jr nz, .asm_11c814
	ld a, [wcd21]
	ld d, a
	and a
	jr z, .asm_11c7e9
	ld a, [wcd26]
	ld e, a
.asm_11c7d0
	ld a, [bc]
	ld l, a
	inc bc
	ld a, [bc]
	ld h, a
	inc bc
	and l
	cp $ff
	ret z
	push bc
	push de

	pop de
	pop bc
	inc e
	ld a, [wcd28]
	cp e
	jr nz, .asm_11c7d0
	ret

.asm_11c7e9
	ld hl, wd100
	ld a, [wcd26]
	ld e, a
	add hl, de
.asm_11c7f1
	push de
	ld a, [hli]
	ld e, a
	ld d, $0
	push hl
	ld a, [bc]
	ld l, a
	inc bc
	ld a, [bc]
	ld h, a
	inc bc
	and l
	cp $ff
	jr z, .asm_11c811
	push bc

	pop bc
	pop hl
	pop de
	inc e
	ld a, [wcd28]
	cp e
	jr nz, .asm_11c7f1
	ret

.asm_11c811
	pop hl
	pop de
	ret

.asm_11c814
	ld hl, $c648
	ld a, [wcd22]
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	push de
	pop hl
	ld a, [wcd26]
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [wcd26]
	ld e, a
.asm_11c831
	push de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld a, [bc]
	ld l, a
	inc bc
	ld a, [bc]
	ld h, a
	inc bc
	and l
	cp $ff
	jr z, .asm_11c851
	push bc

	pop bc
	pop hl
	pop de
	inc e
	ld a, [wcd28]
	cp e
	jr nz, .asm_11c831
	ret

.asm_11c851
	pop hl
	pop de
	ret

; 11c854 (47:4854)

Unknown_11c854: ; 11c854
	dwcoord  2,  8
	dwcoord  8,  8
	dwcoord 14,  8
	dwcoord  2, 10
	dwcoord  8, 10
	dwcoord 14, 10
	dwcoord  2, 12
	dwcoord  8, 12
	dwcoord 14, 12
	dwcoord  2, 14
	dwcoord  8, 14
	dwcoord 14, 14
	dw -1
; 11c86e

Function11c86e: ; 11c86e (47:486e)
	ld a, [wcd26]
	and a
	jr z, .asm_11c88a
	hlcoord 2, 17
	ld de, MobileString_Prev
	call PlaceString
	hlcoord 6, 17
	ld c, $3
	xor a
.asm_11c883
	ld [hli], a
	inc a
	dec c
	jr nz, .asm_11c883
	jr .asm_11c895
.asm_11c88a
	hlcoord 2, 17
	ld c, $7
	ld a, $7f
.asm_11c891
	ld [hli], a
	dec c
	jr nz, .asm_11c891
.asm_11c895
	ld hl, wcd28
	ld a, [wcd26]
	add $c
	jr c, .asm_11c8b7
	cp [hl]
	jr nc, .asm_11c8b7
	hlcoord 16, 17
	ld de, MobileString_Next
	call PlaceString
	hlcoord 11, 17
	ld a, $3
	ld c, a
.asm_11c8b1
	ld [hli], a
	inc a
	dec c
	jr nz, .asm_11c8b1
	ret

.asm_11c8b7
	hlcoord 17, 16
	ld a, $7f
	ld [hl], a
	hlcoord 11, 17
	ld c, $7
.asm_11c8c2
	ld [hli], a
	dec c
	jr nz, .asm_11c8c2
	ret

; 11c8c7 (47:48c7)

MobileString_Prev: ; 11c8f0
	db "まえ@"
; 11c8f3

MobileString_Next: ; 11c8f3
	db "つぎ@"
; 11c8f6

Function11c8f6: ; 11c8f6 (47:48f6)
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	call Function11c95d
	push hl
	ld a, [wcd2b]
	and a
	jr nz, .asm_11c938
	ld a, [wcd21]
	ld d, a
	and a
	jr z, .asm_11c927
	ld hl, wcd26
	ld a, [wcd25]
	add [hl]
.asm_11c911
	ld e, a
.asm_11c912
	pop hl
	push de

	pop de
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	ld c, a
	ld b, $0
	ld hl, wcd36
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.asm_11c927
	ld hl, wcd26
	ld a, [wcd25]
	add [hl]
	ld c, a
	ld b, $0
	ld hl, wd100
	add hl, bc
	ld a, [hl]
	jr .asm_11c911
.asm_11c938
	ld hl, $c648
	ld a, [wcd22]
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	push de
	pop hl
	ld a, [wcd26]
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [wcd25]
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	jr .asm_11c912

Function11c95d: ; 11c95d (47:495d)
	sla a
	ld c, a
	ld b, 0
	ld hl, Unknown_11c986
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	push bc
	push bc
	pop hl
	ld a, $5
	ld c, a
	ld a, $7f
.asm_11c972
	ld [hli], a
	dec c
	jr nz, .asm_11c972
	dec hl
	ld bc, -20
	add hl, bc
	ld a, $5
	ld c, a
	ld a, $7f
.asm_11c980
	ld [hld], a
	dec c
	jr nz, .asm_11c980
	pop hl
	ret

; 11c986 (47:4986)

Unknown_11c986:
	dwcoord  1,  2
	dwcoord  7,  2
	dwcoord 13,  2
	dwcoord  1,  4
	dwcoord  7,  4
	dwcoord 13,  4
; 11c992

Function11c992: ; 11c992 (47:4992)
	ld a, $8
	hlcoord 2, 7
.asm_11c997
	push af
	ld a, $7f
	push hl
	ld bc, $11
	call ByteFill
	pop hl
	ld bc, $14
	add hl, bc
	pop af
	dec a
	jr nz, .asm_11c997
	ret

Function11c9ab: ; 11c9ab (47:49ab)
	ld a, $7
	hlcoord 0, 6, AttrMap
	ld bc, $c8
	call ByteFill
	callba ReloadMapPart
	ret

Function11c9bd: ; 11c9bd (47:49bd)
	ld de, String_11ca38
	call Function11ca7f

Function11c9c3: ; 11c9c3 (47:49c3)
	ld hl, wcd2a
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and $1
	jr nz, .asm_11c9de
	ld a, [de]
	and $2
	jr nz, .asm_11c9e9
	ld a, [de]
	and $40
	jr nz, .asm_11c9f7
	ld a, [de]
	and $80
	jr nz, .asm_11c9fc
	ret

.asm_11c9de
	ld a, [hl]
	and a
	jr nz, .asm_11c9e9
	call Function11ca5e
	xor a
	ld [wcd20], a ; wcd20 (aliases: CreditsPos)
.asm_11c9e9
	ld hl, wcd24
	set 4, [hl]
	ld a, $4
	ld [wJumptableIndex], a
	call PlayClickSFX
	ret

.asm_11c9f7
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.asm_11c9fc
	ld a, [hl]
	and a
	ret nz
	inc [hl]
	ret

Function11ca01: ; 11ca01 (47:4a01)
	hlcoord 14, 7, AttrMap
	ld de, $14
	ld a, $5
	ld c, a
.asm_11ca0a
	push hl
	ld a, $6
	ld b, a
	ld a, $7
.asm_11ca10
	ld [hli], a
	dec b
	jr nz, .asm_11ca10
	pop hl
	add hl, de
	dec c
	jr nz, .asm_11ca0a

Function11ca19: ; 11ca19 (47:4a19)
	hlcoord 0, 12, AttrMap
	ld de, $14
	ld a, $6
	ld c, a
.asm_11ca22
	push hl
	ld a, $14
	ld b, a
	ld a, $7
.asm_11ca28
	ld [hli], a
	dec b
	jr nz, .asm_11ca28
	pop hl
	add hl, de
	dec c
	jr nz, .asm_11ca22
	callba ReloadMapPart
	ret

; 11ca38 (47:4a38)

String_11ca38: ; 11ca38
	db   "とうろくちゅう", $25, "あいさつ¯ぜんぶ"
	next "けしても よろしいですか?@"
; 11ca57

String_11ca57: ; 11ca57
	db   "はい"
	next "いいえ@"
; 11ca5e

Function11ca5e: ; 11ca5e (47:4a5e)
	xor a
.asm_11ca5f
	push af
	call Function11ca6a
	pop af
	inc a
	cp $6
	jr nz, .asm_11ca5f
	ret

Function11ca6a: ; 11ca6a (47:4a6a)
	ld hl, wcd36
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	ld [hl], b
	inc hl
	ld [hl], b
	call Function11c95d
	ld de, String_11c3bc
	call PlaceString
	ret

Function11ca7f: ; 11ca7f (47:4a7f)
	push de
	ld de, Unknown_11cfc6
	call Function11cfce
	ld de, Unknown_11cfca
	call Function11cfce
	hlcoord 1, 14
	pop de
	call PlaceString
	hlcoord 16, 8
	ld de, String_11ca57
	call PlaceString
	call Function11ca01
	ld a, $1
	ld [wcd2a], a
	ld hl, wcd24
	res 4, [hl]
	call Function11cfb5
	ret

Function11caad: ; 11caad (47:4aad)
	ld de, String_11cb1c
	call Function11ca7f

Function11cab3: ; 11cab3 (47:4ab3)
	ld hl, wcd2a
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and $1
	jr nz, .asm_11cace
	ld a, [de]
	and $2
	jr nz, .asm_11caf9
	ld a, [de]
	and $40
	jr nz, .asm_11cb12
	ld a, [de]
	and $80
	jr nz, .asm_11cb17
	ret

.asm_11cace
	call PlayClickSFX
	ld a, [hl]
	and a
	jr nz, .asm_11cafc
	ld a, [wcd35]
	and a
	jr z, .asm_11caf3
	cp $ff
	jr z, .asm_11caf3
	ld a, $ff
	ld [wcd35], a
	hlcoord 1, 14
	ld de, String_11cb31
	call PlaceString
	ld a, $1
	ld [wcd2a], a
	ret

.asm_11caf3
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.asm_11caf9
	call PlayClickSFX
.asm_11cafc
	ld hl, wcd24
	set 4, [hl]
	ld a, $4
	ld [wJumptableIndex], a
	ld a, [wcd35]
	cp $ff
	ret nz
	ld a, $1
	ld [wcd35], a
	ret

.asm_11cb12
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.asm_11cb17
	ld a, [hl]
	and a
	ret nz
	inc [hl]
	ret

; 11cb1c (47:4b1c)

String_11cb1c: ; 11cb1c
	db   "あいさつ", $25, "とうろく¯ちゅうし"
	next "しますか?@"
; 11cb31

String_11cb31: ; 11cb31
	db   "とうろくちゅう", $25, "あいさつ", $24, "ほぞん"
	next "されません", $4a, "よろしい ですか?@"
; 11cb52

Function11cb52: ; 11cb52 (47:4b52)
	ld hl, Unknown_11cc01
	ld a, [wMenuCursorY]
.asm_11cb58
	dec a
	jr z, .asm_11cb5f
	inc hl
	inc hl
	jr .asm_11cb58
.asm_11cb5f
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	call Function11ca7f

Function11cb66: ; 11cb66 (47:4b66)
	ld hl, wcd2a
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and $1
	jr nz, .asm_11cb81
	ld a, [de]
	and $2
	jr nz, .asm_11cbd7
	ld a, [de]
	and $40
	jr nz, .asm_11cbeb
	ld a, [de]
	and $80
	jr nz, .asm_11cbf0
	ret

.asm_11cb81
	ld a, [hl]
	and a
	jr nz, .asm_11cbd4
	ld a, $4
	call GetSRAMBank
	ld hl, $a007
	ld a, [wMenuCursorY]
	dec a
	sla a
	sla a
	ld c, a
	sla a
	add c
	ld c, a
	ld b, $0
	add hl, bc
	ld de, wcd36
	ld c, $c
.asm_11cba2
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .asm_11cba2
	call CloseSRAM
	call PlayClickSFX
	ld de, Unknown_11cfc6
	call Function11cfce
	ld hl, Unknown_11cc7e
	ld a, [wMenuCursorY]
.asm_11cbba
	dec a
	jr z, .asm_11cbc1
	inc hl
	inc hl
	jr .asm_11cbba
.asm_11cbc1
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	hlcoord 1, 14
	call PlaceString
	ld hl, wJumptableIndex
	inc [hl]
	inc hl
	ld a, $10
	ld [hl], a
	ret

.asm_11cbd4
	call PlayClickSFX
.asm_11cbd7
	ld de, Unknown_11cfba
	call Function11cfce
	call Function11c38a
	ld hl, wcd24
	set 4, [hl]
	ld a, $4
	ld [wJumptableIndex], a
	ret

.asm_11cbeb
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.asm_11cbf0
	ld a, [hl]
	and a
	ret nz
	inc [hl]
	ret

Function11cbf5: ; 11cbf5 (47:4bf5)
	call WaitSFX
	ld hl, wcf64
	dec [hl]
	ret nz
	dec hl
	set 7, [hl]
	ret

; 11cc01 (47:4c01)

Unknown_11cc01: ; 11cc01
	dw String_11cc09
	dw String_11cc23
	dw String_11cc42
	dw String_11cc60

String_11cc09: ; 11cc09
	db   "じこしょうかい は"
	next "この あいさつで いいですか?@"

String_11cc23: ; 11cc23
	db   "たいせん ", $4a, "はじまるとき は"
	next "この あいさつで いいですか?@"

String_11cc42: ; 11cc42
	db   "たいせん ", $1d, "かったとき は"
	next "この あいさつで いいですか?@"

String_11cc60: ; 11cc60
	db   "たいせん ", $1d, "まけたとき は"
	next "この あいさつで いいですか?@"
; 11cc7e

Unknown_11cc7e: ; 11cc7e
	dw String_11cc86
	dw String_11cc9d
	dw String_11ccb9
	dw String_11ccd4

String_11cc86: ; 11cc86
	db   "じこしょうかい の"
	next "あいさつ¯とうろくした!@"

String_11cc9d: ; 11cc9d
	db   "たいせん ", $4a, "はじまるとき の"
	next "あいさつ¯とうろくした!@"

String_11ccb9: ; 11ccb9
	db   "たいせん ", $1d, "かったとき の"
	next "あいさつ¯とうろくした!@"

String_11ccd4: ; 11ccd4
	db   "たいせん ", $1d, "まけたとき の"
	next "あいさつ¯とうろくした!@"
; 11ccef

Function11ccef: ; 11ccef (47:4cef)
	ld de, Unknown_11cfc6
	call Function11cfce
	hlcoord 1, 14
	ld de, String_11cd10
	call PlaceString
	call Function11ca19
	call Function11cfb5

Function11cd04: ; 11cd04 (47:4d04)
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and a
	ret z
	ld a, $4
	ld [wJumptableIndex], a
	ret

; 11cd10 (47:4d10)

String_11cd10: ; 11cd10
	db "なにか ことば¯いれてください@"
; 11cd20

Function11cd20: ; 11cd20 (47:4d20)
	call Function11c277
	ld de, Unknown_11cfc6
	call Function11cfce
	hlcoord 1, 14
	ld a, [wcd2b]
	ld [wcd2c], a
	and a
	jr nz, .asm_11cd3a
	ld de, String_11cdc7
	jr .asm_11cd3d
.asm_11cd3a
	ld de, String_11cdd9
.asm_11cd3d
	call PlaceString
	hlcoord 4, 8
	ld de, String_11cdf5
	call PlaceString
	call Function11cdaa
	ld hl, wcd24
	res 5, [hl]
	call Function11cfb5

Function11cd54: ; 11cd54 (47:4d54)
	ld hl, wcd2c
	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and A_BUTTON
	jr nz, .asm_11cd6f
	ld a, [de]
	and B_BUTTON
	jr nz, .asm_11cd73
	ld a, [de]
	and D_UP
	jr nz, .asm_11cd8b
	ld a, [de]
	and D_DOWN
	jr nz, .asm_11cd94
	ret

.asm_11cd6f
	ld a, [hl]
	ld [wcd2b], a
.asm_11cd73
	ld a, [wcd2b]
	and a
	jr nz, .asm_11cd7d
	ld a, $6
	jr .asm_11cd7f

.asm_11cd7d
	ld a, $15
.asm_11cd7f
	ld [wJumptableIndex], a
	ld hl, wcd24
	set 5, [hl]
	call PlayClickSFX
	ret

.asm_11cd8b
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld de, String_11cdc7
	jr .asm_11cd9b

.asm_11cd94
	ld a, [hl]
	and a
	ret nz
	inc [hl]
	ld de, String_11cdd9
.asm_11cd9b
	push de
	ld de, Unknown_11cfc6
	call Function11cfce
	pop de
	hlcoord 1, 14
	call PlaceString
	ret

Function11cdaa: ; 11cdaa (47:4daa)
	ld a, $2
	hlcoord 0, 6, AttrMap
	ld bc, 6 * SCREEN_WIDTH
	call ByteFill
	ld a, $7
	hlcoord 0, 12, AttrMap
	ld bc, 4 * SCREEN_WIDTH
	call ByteFill
	callba ReloadMapPart
	ret

; 11cdc7 (47:4dc7)

String_11cdc7: ; 11cdc7
; Words will be displayed by category
	db   "ことば¯しゅるいべつに"
	next "えらべます@"
; 11cdd9

String_11cdd9: ; 11cdd9
; Words will be displayed in alphabetical order
	db   "ことば¯アイウエォ の"
	next "じゅんばんで ひょうじ します@"
; 11cdf5

String_11cdf5: ; 11cdf5
	db   "しゅるいべつ モード"  ; Category mode
	next "アイウエォ  モード@" ; ABC mode
; 11ce0b

Function11ce0b: ; 11ce0b (47:4e0b)
	call Function11c277
	hlcoord 1, 7
	ld de, String_11cf79
	call PlaceString
	hlcoord 1, 17
	ld de, String_11c62a
	call PlaceString
	call Function11c618
	ld hl, wcd24
	res 2, [hl]
	call Function11cfb5

Function11ce2b: ; 11ce2b (47:4e2b)
	ld a, [wcd22]
	sla a
	sla a
	ld c, a
	ld b, 0
	ld hl, Unknown_11ceb9
	add hl, bc

	ld de, hJoypadPressed ; $ffa3
	ld a, [de]
	and START
	jr nz, .start
	ld a, [de]
	and SELECT
	jr nz, .select
	ld a, [de]
	and A_BUTTON
	jr nz, .a
	ld a, [de]
	and B_BUTTON
	jr nz, .b

	ld de, hJoyLast
	ld a, [de]
	and D_UP
	jr nz, .up
	ld a, [de]
	and D_DOWN
	jr nz, .down
	ld a, [de]
	and D_LEFT
	jr nz, .left
	ld a, [de]
	and D_RIGHT
	jr nz, .right

	ret

.a
	ld a, [wcd22]
	cp NUM_KANA
	jr c, .place
	sub NUM_KANA
	jr z, .asm_11cea4
	dec a
	jr z, .asm_11ce96
	jr .b

.start
	ld hl, wcd24
	set 0, [hl]
	ld a, $8
	ld [wcd20], a ; wcd20 (aliases: CreditsPos)
.b
	ld a, $4
	jr .load

.select
	ld a, [wcd2b]
	xor $1
	ld [wcd2b], a
	ld a, $6
	jr .load

.place
	ld a, $8
	jr .load

.asm_11ce96
	ld a, $13
.load
	ld [wJumptableIndex], a
	ld hl, wcd24
	set 2, [hl]
	call PlayClickSFX
	ret

.asm_11cea4
	ld a, [wcd20] ; wcd20 (aliases: CreditsPos)
	call Function11ca6a
	call PlayClickSFX
	ret

.left
	inc hl
.down
	inc hl
.right
	inc hl
.up
	ld a, [hl]
	cp $ff
	ret z
	ld [wcd22], a
	ret

; 11ceb9 (47:4eb9)

Unknown_11ceb9: ; 11ceb9
	; up left down right
	db $ff, $01
	db $05, $ff
	db $ff, $02
	db $06, $00
	db $ff, $03
	db $07, $01
	db $ff, $04
	db $08, $02
	db $ff, $14
	db $09, $03
	db $00, $06
	db $0a, $ff
	db $01, $07
	db $0b, $05
	db $02, $08
	db $0c, $06
	db $03, $09
	db $0d, $07
	db $04, $19
	db $0e, $08
	db $05, $0b
	db $0f, $ff
	db $06, $0c
	db $10, $0a
	db $07, $0d
	db $11, $0b
	db $08, $0e
	db $12, $0c
	db $09, $1e
	db $13, $0d
	db $0a, $10
	db $2d, $ff
	db $0b, $11
	db $2d, $0f
	db $0c, $12
	db $2d, $10
	db $0d, $13
	db $2d, $11
	db $0e, $26
	db $2d, $12
	db $ff, $15
	db $19, $04
	db $ff, $16
	db $1a, $14
	db $ff, $17
	db $1b, $15
	db $ff, $18
	db $1c, $16
	db $ff, $23
	db $1d, $17
	db $14, $1a
	db $1e, $09
	db $15, $1b
	db $1f, $19
	db $16, $1c
	db $20, $1a
	db $17, $1d
	db $21, $1b
	db $18, $2b
	db $22, $1c
	db $19, $1f
	db $26, $0e
	db $1a, $20
	db $27, $1e
	db $1b, $21
	db $28, $1f
	db $1c, $22
	db $29, $20
	db $1d, $2c
	db $2a, $21
	db $ff, $24
	db $2b, $18
	db $ff, $25
	db $2b, $23
	db $ff, $ff
	db $2b, $24
	db $1e, $27
	db $2e, $13
	db $1f, $28
	db $2e, $26
	db $20, $29
	db $2e, $27
	db $21, $2a
	db $2e, $28
	db $22, $ff
	db $2e, $29
	db $23, $ff
	db $2c, $1d
	db $2b, $ff
	db $2f, $22
	db $0f, $2e
	db $ff, $ff
	db $26, $2f
	db $ff, $2d
	db $2c, $ff
	db $ff, $2e
; 11cf79

String_11cf79: ; 11cf79
; Hiragana table
	db   "あいうえお なにぬねの や ゆ よ"
	next "かきくけこ はひふへほ わ"
	next "さしすせそ まみむめも そのた"
	next "たちつてと らりるれろ"
	db   "@"
; 11cfb5

Function11cfb5: ; 11cfb5 (47:4fb5)
	ld hl, wJumptableIndex
	inc [hl]
	ret

; 11cfba (47:4fba)

Unknown_11cfba:
	db  0,  0 ; start coords
	db 20,  6 ; end coords

Unknown_11cfbe:
	db  0, 14 ; start coords
	db 20,  4 ; end coords

Unknown_11cfc2:
	db  0,  6 ; start coords
	db 20, 10 ; end coords

Unknown_11cfc6:
	db  0, 12 ; start coords
	db 20,  6 ; end coords

Unknown_11cfca:
	db 14,  7 ; start coords
	db  6,  5 ; end coords
; 11cfce

Function11cfce: ; 11cfce (47:4fce)
	hlcoord 0, 0
	ld bc, $14
	ld a, [de]
	inc de
	push af
	ld a, [de]
	inc de
	and a
.asm_11cfda
	jr z, .asm_11cfe0
	add hl, bc
	dec a
	jr .asm_11cfda
.asm_11cfe0
	pop af
	ld c, a
	ld b, 0
	add hl, bc
	push hl
	ld a, $79
	ld [hli], a
	ld a, [de]
	inc de
	dec a
	dec a
	jr z, .asm_11cff6
	ld c, a
	ld a, $7a
.asm_11cff2
	ld [hli], a
	dec c
	jr nz, .asm_11cff2
.asm_11cff6
	ld a, $7b
	ld [hl], a
	pop hl
	ld bc, $14
	add hl, bc
	ld a, [de]
	dec de
	dec a
	dec a
	jr z, .asm_11d022
	ld b, a
.asm_11d005
	push hl
	ld a, $7c
	ld [hli], a
	ld a, [de]
	dec a
	dec a
	jr z, .asm_11d015
	ld c, a
	ld a, $7f
.asm_11d011
	ld [hli], a
	dec c
	jr nz, .asm_11d011
.asm_11d015
	ld a, $7c
	ld [hl], a
	pop hl
	push bc
	ld bc, $14
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_11d005
.asm_11d022
	ld a, $7d
	ld [hli], a
	ld a, [de]
	dec a
	dec a
	jr z, .asm_11d031
	ld c, a
	ld a, $7a
.asm_11d02d
	ld [hli], a
	dec c
	jr nz, .asm_11d02d
.asm_11d031
	ld a, $7e
	ld [hl], a
	ret

Function11d035: ; 11d035 (47:5035)
	hlcoord 0, 0
	ld bc, $14
	ld a, [de]
	inc de
	push af
	ld a, [de]
	inc de
	and a
.asm_11d041
	jr z, .asm_11d047
	add hl, bc
	dec a
	jr .asm_11d041
.asm_11d047
	pop af
	ld c, a
	ld b, $0
	add hl, bc
	push hl
	ld a, $79
	ld [hl], a
	pop hl
	push hl
	ld a, [de]
	dec a
	inc de
	ld c, a
	add hl, bc
	ld a, $7b
	ld [hl], a
	call Function11d0ac
	ld a, $7e
	ld [hl], a
	pop hl
	push hl
	call Function11d0ac
	ld a, $7d
	ld [hl], a
	pop hl
	push hl
	inc hl
	push hl
	call Function11d0ac
	pop bc
	dec de
	ld a, [de]
	cp $2
	jr z, .asm_11d082
	dec a
	dec a
.asm_11d078
	push af
	ld a, $7a
	ld [hli], a
	ld [bc], a
	inc bc
	pop af
	dec a
	jr nz, .asm_11d078
.asm_11d082
	pop hl
	ld bc, $14
	add hl, bc
	push hl
	ld a, [de]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	pop bc
	inc de
	ld a, [de]
	cp $2
	ret z
	push bc
	dec a
	dec a
	ld c, a
	ld b, a
	ld de, $14
.asm_11d09c
	ld a, $7c
	ld [hl], a
	add hl, de
	dec c
	jr nz, .asm_11d09c
	pop hl
.asm_11d0a4
	ld a, $7c
	ld [hl], a
	add hl, de
	dec b
	jr nz, .asm_11d0a4
	ret

Function11d0ac: ; 11d0ac (47:50ac)
	ld a, [de]
	dec a
	ld bc, $14
.asm_11d0b1
	add hl, bc
	dec a
	jr nz, .asm_11d0b1
	ret

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
	ld hl, Unknown_11d208
	ld e, $1
	jr .load

.one ; 11d0e9 (47:50e9)
	ld a, [wcd21]
	sla a
	ld hl, Unknown_11d21a
	ld e, $2
	jr .load

.two ; 11d0f5 (47:50f5)
	ld hl, Unknown_11d2be
	ld a, [wcd22]
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hl]
	call ReinitSpriteAnimFrame
	ld a, [wcd22]
	sla a
	ld hl, Unknown_11d23e
	ld e, $4
	jr .load

.three ; 11d10f (47:510f)
	ld a, SPRITE_ANIM_FRAMESET_27
	call ReinitSpriteAnimFrame
	ld a, [wcd25]
	sla a
	ld hl, Unknown_11d29e
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
	ld hl, Unknown_11d2b6
	ld e, $10
	jr .load

.five ; 11d145 (47:5145)
	ld a, SPRITE_ANIM_FRAMESET_27
	call ReinitSpriteAnimFrame
	ld a, [wcd2c]
	sla a
	ld hl, Unknown_11d2ba
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

Unknown_11d208: ; 11d208
	db $0d, $1a
	db $3d, $1a
	db $6d, $1a
	db $0d, $2a
	db $3d, $2a
	db $6d, $2a
	db $0d, $8a
	db $3d, $8a
	db $6d, $8a

Unknown_11d21a: ; 11d21a
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

Unknown_11d23e: ; 11d23e
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

Unknown_11d29e: ; 11d29e
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

Unknown_11d2b6: ; 11d2b6
	db $80, $50
	db $80, $60

Unknown_11d2ba: ; 11d2ba
	db $20, $50
	db $20, $60

Unknown_11d2be: ; 11d2be
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
	ld a, $0
	ld [hld], a
	ld a, $1
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

Unknown_11f220:
	db $12, $01 ; 01
	db $24, $02 ; 02
	db $45, $05 ; 03
	db $45, $05 ; 04
	db $42, $05 ; 05
	db $42, $05 ; 06
	db $45, $05 ; 07
	db $42, $05 ; 08
	db $27, $03 ; 09
	db $27, $03 ; 0a
	db $45, $05 ; 0b
	db $27, $03 ; 0c
	db $42, $05 ; 0d
	db $24, $02 ; 0e
