CanObjectMoveInDirection:

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 4, [hl]
	jr nz, .continue

	push hl
	push bc

	ld hl, OBJECT_PALETTE
	add hl, bc
	bit 5, [hl]
	jr z, .not_bit_5
	call WillObjectBumpIntoLand
	jr .resume
.not_bit_5
	call WillObjectBumpIntoWater
.resume
	pop bc
	pop hl
	ret c

.continue
	bit 6, [hl]
	jr nz, .bit_6

	push hl
	push bc
	call WillPersonBumpIntoSomeoneElse
	pop bc
	pop hl
	ret c

.bit_6
	bit 5, [hl]
	jr nz, .bit_5
	push hl
	call HasPersonReachedMovementLimit
	pop hl
	ret c

	push hl
	call IsPersonMovingOffEdgeOfScreen
	pop hl
	ret c

.bit_5
	and a
	ret

WillObjectBumpIntoWater:
	call CanObjectLeaveTile
	ret c
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_PALETTE
	add hl, bc
	bit 7, [hl]
	jr nz, WillObjectRemainOnWater
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ld d, a
	call GetTileCollision
	and a ; cp LAND_TILE
	jr z, WillObjectBumpIntoTile
	scf
	ret

WillObjectBumpIntoLand:
	call CanObjectLeaveTile
	ret c
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call GetTileCollision
	dec a ; cp WATER_TILE
	jr z, WillObjectBumpIntoTile
	scf
	ret

WillObjectBumpIntoTile:
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call GetSideWallDirectionMask
	ret nc
	push af
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and 3
	ld e, a
	ld d, 0
	ld hl, .dir_masks
	add hl, de
	pop af
	and [hl]
	ret z
	scf
	ret

.dir_masks
	db 1 << DOWN, 1 << UP, 1 << RIGHT, 1 << LEFT

CanObjectLeaveTile:
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	call GetSideWallDirectionMask
	ret nc
	push af
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	and 3
	ld e, a
	ld d, 0
	ld hl, .dir_masks
	add hl, de
	pop af
	and [hl]
	ret z
	scf
	ret

.dir_masks
	db 1 << UP, 1 << DOWN, 1 << LEFT, 1 << RIGHT

GetSideWallDirectionMask:
	ld d, a
	and $f0
	cp $b0
	jr z, .done
	xor a
	ret

.done
	ld a, d
	and 7
	ld e, a
	ld d, 0
	ld hl, .side_wall_masks
	add hl, de
	ld a, [hl]
	scf
	ret

.side_wall_masks
	db  8, 4, 1, 2
	db 10, 6, 9, 5

WillObjectRemainOnWater:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and 3
	jr z, .asm_6fb2
	dec a
	jr z, .asm_6fb7
	dec a
	jr z, .asm_6fbb
	jr .asm_6fbf

.asm_6fb2
	inc e
	push de
	inc d
	jr .asm_6fc2

.asm_6fb7
	push de
	inc d
	jr .asm_6fc2

.asm_6fbb
	push de
	inc e
	jr .asm_6fc2

.asm_6fbf
	inc d
	push de
	inc e

.asm_6fc2
	call GetCoordTile
	call GetTileCollision
	pop de
	and a ; cp LAND_TILE
	jr nz, .asm_6fd7
	call GetCoordTile
	call GetTileCollision
	and a ; cp LAND_TILE
	jr nz, .asm_6fd7
	xor a
	ret

.asm_6fd7
	scf
	ret

CheckFacingObject::

	call GetFacingTileCoord

; Double the distance for counter tiles.
	cp COLL_COUNTER
	jr nz, .asm_6ff1

	ld a, [wPlayerStandingMapX]
	sub d
	cpl
	inc a
	add d
	ld d, a

	ld a, [wPlayerStandingMapY]
	sub e
	cpl
	inc a
	add e
	ld e, a

.asm_6ff1
	xor a
	ldh [hMapObjectIndexBuffer], a
	call IsNPCAtCoord
	ret nc
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .standing
	xor a
	ret

.standing
	scf
	ret

WillPersonBumpIntoSomeoneElse:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
IsNPCAtCoord:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hObjectStructIndexBuffer], a
	call DoesObjectHaveASprite
	jr z, .next

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 7, [hl]
	jr nz, .next

	ld hl, OBJECT_PALETTE
	add hl, bc
	bit 7, [hl]
	jr z, .got

	call WillObjectIntersectBigObject
	jr nc, .ok
	jr .ok2

.got
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .ok
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .ok

.ok2
	ldh a, [hMapObjectIndexBuffer]
	ld l, a
	ldh a, [hObjectStructIndexBuffer]
	cp l
	jr nz, .setcarry

.ok
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .next
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .next
	ldh a, [hMapObjectIndexBuffer]
	ld l, a
	ldh a, [hObjectStructIndexBuffer]
	cp l
	jr nz, .setcarry

.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	and a
	ret

.setcarry
	scf
	ret

HasPersonReachedMovementLimit:
	ld hl, OBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	and a
	jr z, .nope
	and $f
	jr z, .check_y
	ld e, a
	ld d, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .yes
	cp e
	jr z, .yes

.check_y
	ld hl, OBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	jr z, .nope
	ld e, a
	ld d, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .yes
	cp e
	jr z, .yes

.nope
	xor a
	ret

.yes
	scf
	ret

IsPersonMovingOffEdgeOfScreen:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [wXCoord]
	cp [hl]
	jr z, .check_y
	jr nc, .yes
	add $9
	cp [hl]
	jr c, .yes

.check_y
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [wYCoord]
	cp [hl]
	jr z, .nope
	jr nc, .yes
	add $8
	cp [hl]
	jr c, .yes

.nope
	and a
	ret

.yes
	scf
	ret

WillObjectIntersectBigObject:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, d
	sub [hl]
	jr c, .nope
	cp $2
	jr nc, .nope
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, e
	sub [hl]
	jr c, .nope
	cp $2
	jr nc, .nope
	scf
	ret

.nope
	and a
	ret
