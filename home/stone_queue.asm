HandleStoneTableAction::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call .WarpAction

	pop bc
	ld a, b
	rst Bankswitch
	ret

.WarpAction:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .nope

	ld l, a
	push hl
	call .IsPersonOnWarp
	pop hl
	jr nc, .nope
	ld d, a
	ld e, l
	call .IsObjectInStoneTable
	jr nc, .nope
	call CallMapScript
	farcall EnableScriptMode
	scf
	ret

.nope
	and a
	ret

.IsPersonOnWarp:
	push de

	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld e, [hl]

	sub 4
	ld d, a
	ld a, e
	sub 4
	ld e, a
	call .check_on_warp

	pop de
	ret

.check_on_warp
	ld hl, wCurMapWarpsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurMapWarpCount]
	and a
	jr z, .nope2

.loop
	push af
	ld a, [hl]
	cp e
	jr nz, .not_on_warp
	inc hl
	ld a, [hld]
	cp d
	jr nz, .not_on_warp
	pop af
	ld d, a
	ld a, [wCurMapWarpCount]
	sub d
	inc a
	scf
	ret

.not_on_warp
	ld a, 5
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	pop af
	dec a
	jr nz, .loop

.nope2
	and a
	ret

.IsObjectInStoneTable:
	ld h, b
	ld l, c
.loop2
	ld a, [hli]
	cp -1 ; end?
	jr z, .nope3
	cp d
	jr nz, .next_inc3
	ld a, [hli]
	cp e
	jr nz, .next_inc2
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .yes

.next_inc3
	inc hl

.next_inc2
	inc hl
	inc hl
	jr .loop2

.nope3
	and a
	ret

.yes
	scf
	ret
